#' Get estimated deaths from Bayesian truncated Gompertz model
#'
#' Get estimated deaths by age, group and cohort and associated uncertainty intervals.
#'
#' @param mod a JAGS model object
#' @param cohorts vector of cohorts
#' @param ncohorts number of cohorts
#' @param group_levels vector of groups
#' @param ngroups number of groups
#' @param ages vector of ages
#' @param nages number of ages
#' @param alpha_level level of significance. Default is 5\%.
#' @return a dataframe with estimated deaths by age, group and cohort

get_estimated_deaths <- function(mod,
                                 cohorts,
                                 ncohorts,
                                 group_levels,
                                 ngroups,
                                 ages,
                                 nages,
                                 alpha_level = 0.05){
  mcmc.array <- mod$BUGSoutput$sims.array
  y.df <- c()

  for(i in 1:ncohorts){
    for(j in 1:ngroups){
      for(k in 1:nages){
        yhat <- median(mcmc.array[,,paste0("y.hat[",i,",",j,",",k,"]")])
        ylower <- quantile(mcmc.array[,,paste0("y.hat[",i,",",j,",",k,"]")], alpha_level/2)
        yupper <- quantile(mcmc.array[,,paste0("y.hat[",i,",",j,",",k,"]")], 1- alpha_level/2)

        y.df <- rbind(y.df, c(cohorts[i], group_levels[j], ages[k], yhat, ylower, yupper))
      }

    }
  }

  y.df <- as_data_frame(y.df)
  colnames(y.df) <- c("cohort", "group", "age", "median", "lower", "upper")
  return(y.df)
}
