#' Run MCMC for Bayesian truncated Gompertz model
#'
#' Estimates a Bayesian truncated Gompertz model based on an inputted tabulated dataframe of deaths
#' and a minimum age of estimation.
#'
#' @param tab_df A tabulated CenSoc dataframe
#' @param min_age The minimum age of estimation, i.e. where to start estimates of dx from (lowest that makes sense is probably 40)
#' @param number_chains The number of chains of MCMC
#' @param number_iterations The number of iterations per chain of MCMC
#' @return a list containing data elements in the right form for JAGS input



run_gompertz_model <- function(tab_df,
                               min_age,
                               number_chains = 6,
                               number_iterations = 5000){

  # get meta data
  md <- get_meta_data(tab_df, min_age)
  for (i in 1:length(md)){
    assign(names(md)[i], md[[i]])
  }

  # get trunacted ages
  xtruncs <- get_truncation_ages(tab_df, ncohorts,  ngroups)
  for (i in 1:length(xtruncs)){
    assign(names(xtruncs)[i], xtruncs[[i]])
  }

  # get data in JAGS form
  dta <- get_jags_data(tab_df, ncohorts, ngroups, min_age)
  for (i in 1:length(dta)){
    assign(names(dta)[i], dta[[i]])
  }


  # define JAGS data list and parameters to save
  jags.data <- c(md, xtruncs, dta,  list(log_y.ci = log(y.ci), log_N.cg = log(N.cg)))
  jags.data[["cohorts"]] <- NULL
  jags.data[["group_levels"]] <- NULL
  jags.data[["y.ci"]] <- NULL
  jags.data[["N.cg"]] <- NULL

  parnames <- c("y.hat", "b", "M", "mu.cgx", "tau.y")

  # run MCMC!
  mod<-jags(data = jags.data,
            parameters.to.save=parnames,
            n.chains = number_chains,
            n.iter = number_iterations,
            model.file = system.file("models",
                                     "model_mode_censoc_group.txt",
                                     package="censoc"))

  mod$BUGSoutput$summary[mod$BUGSoutput$summary[,"Rhat"]>1.1,]
  mcmc.array <- mod$BUGSoutput$sims.array



}
