#' Run MCMC for Bayesian truncated Gompertz model
#'
#' Estimates a Bayesian truncated Gompertz model based on an inputted tabulated dataframe of deaths
#' and a minimum age of estimation.
#'
#' @param tab_df A tabulated CenSoc dataframe
#' @param min_age The minimum age of estimation, i.e. where to start estimates of dx from (lowest that makes sense is probably 40)
#' @param number_chains The number of chains of MCMC
#' @param number_iterations The number of iterations per chain of MCMC
#' @param run_update Whether or not to automatically run model update if model did not converge
#' @return a JAGS model object



truncated_gompertz_model <- function(tab_df,
                               min_age,
                               number_chains = 3,
                               number_iterations = 7500,
                               run_update = FALSE){

  cat("Processing data into JAGS format. \n")
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
  cat("Running model. \n")
  mod<-jags(data = jags.data,
            parameters.to.save=parnames,
            n.chains = number_chains,
            n.iter = number_iterations,
            model.file = system.file("models",
                                     "model_mode_censoc_group.txt",
                                     package="censoc"))

  if(max(mod$BUGSoutput$summary[grepl("b|M",rownames(mod$BUGSoutput$summary)),"Rhat"])>1.1){
    if(run_update){
      cat(paste0("Maximum Rhat is ", max(mod$BUGSoutput$summary[,"Rhat"]), ". \n"))
      cat("Model did not converge, Running update. \n")
      mod <- autojags(mod, n.iter = number_iterations)
    }
  }
  cat(paste0("Maximum Rhat is ", max(mod$BUGSoutput$summary[,"Rhat"]), ". \n"))
  return(mod)

}
