#' Get left and right truncation ages for each cohort and grouping variable level
#'
#' Given a tabulated deaths data frame and the number of groups and cohorts,
#' will return list containing data elements in the right form for JAGS input
#'
#' @param tab_df A tabulated CenSoc dataframe
#' @param ncohorts Number of cohorts
#' @param ngroups Number of group levels
#' @return a list containing data elements in the right form for JAGS input


get_jags_data <- function(tab_df, ncohorts, ngroups){

  y.ci <- matrix(NA, nrow = ncohorts, ncol = (tab_df %>% group_by(byear) %>% summarise(n = n()) %>% summarise(max(n)))[[1]])
  geta.ci <- matrix(NA, nrow = ncohorts, ncol = (tab_df %>% group_by(byear) %>% summarise(n = n()) %>% summarise(max(n)))[[1]])
  getg.ci <- matrix(NA, nrow = ncohorts, ncol = (tab_df %>% group_by(byear) %>% summarise(n = n()) %>% summarise(max(n)))[[1]])
  n.c <- rep(NA, ncohorts)

  for(i in 1:ncohorts){
    ccounts <- tab_df %>% ungroup() %>% filter(byear==cohorts[i]) %>% select(n) %>% pull()
    cages <- (tab_df %>% ungroup() %>% filter(byear==cohorts[i]) %>% select(age_of_death) %>% pull()) - min(ages)+1
    ceduc <- (tab_df %>% ungroup() %>% filter(byear==cohorts[i]) %>% select(3) %>% pull()) - min(group_levels)+1
    y.ci[i,1:length(ccounts)] <- ccounts
    geta.ci[i,1:length(cages)] <- cages
    getg.ci[i,1:length(ceduc)] <- ceduc
    n.c[i] <- length(ccounts)
  }


  N.cg <- matrix(NA, nrow = ncohorts, ncol = ngroups)
  for(i in 1:ncohorts){
    for(j in 1:ngroups){
      N.cg[i,j] <- tab_df %>% filter(byear == cohorts[i]) %>% filter(.[[3]]==j) %>% summarise(sum(n)) %>% pull()
    }
  }

  return(list(y.ci = y.ci,
              geta.ci = geta.ci,
              getg.ci = getg.ci,
              n.c = n.c,
              N.cg = N.cg))
}
