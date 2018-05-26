#' Get posterior samples of death distribution from Bayesian truncated Gompertz model
#'
#' Get posterior samples of death distribution by age, group and cohort and associated uncertainty intervals.
#'
#' @param mod a JAGS model object
#' @param ncohorts number of cohorts
#' @param ngroups number of groups
#' @param nages number of ages
#' @return an array of posterior samples of death proportions by age, cohort and group
#' @export

get_death_proportions_post_samples <- function(mod,
                                               ncohorts,
                                               ngroups,
                                               nages){

  mcmc.array <- mod$BUGSoutput$sims.array
  nsims <- dim(mcmc.array)[1]*dim(mcmc.array)[2]
  d.xcgs <- array(NA, c(nages, ncohorts, ngroups, nsims))

  for (i in 1:ncohorts){
    for(j in 1:ngroups){
      for(k in 1:nages){
        d.xcgs[k,i,j,] <- c(mcmc.array[,,paste0("mu.cgx[",i,",",j,",",k,"]")])
      }
    }
  }
  return(d.xcgs)
}
