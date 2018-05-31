#' Get estimates of hazard rates and life expectancy
#'
#' Get estimates and uncertainity intervals of mortality indicators
#' by age, group and cohort and associated uncertainty intervals.
#'
#' @param mod a JAGS model object
#' @param ncohorts number of cohorts
#' @param ngroups number of groups
#' @param group_labels labels of groups
#' @param nages number of ages
#' @param alpha_level level of significance. Default is 5\%.
#' @return an array of posterior samples of death proportions by age, cohort and group
#' @export


get_estimated_hx_ex <- function(mod,
                                ncohorts,
                                ngroups,
                                group_labels,
                                nages,
                                alpha_level = 0.05){

  nsims <- dim(mod$BUGSoutput$sims.array)[1]*dim(mod$BUGSoutput$sims.array)[2]
  d.xcgs <- get_death_proportions_post_samples(mod, ncohorts, ngroups, nages)

  h.xcgs <- array(NA, c(nages, ncohorts, ngroups, nsims))
  e.xcgs <- array(NA, c(nages, ncohorts, ngroups, nsims))

  for(i in 1:ncohorts){
    for(j in 1:ngroups){
      for(s in 1:nsims){
        dx <- d.xcgs[,i,j,s]
        lx = (sum(dx)-lag(cumsum(dx)))/sum(dx)
        lx[1] <- 1
        hx = dx/lx
        Lx = (lx+lead(lx))/2
        Lx[length(ages)]<- lx[length(ages)]
        Tx = rev(cumsum(rev(Lx)))

        h.xcgs[,i,j,s] <- hx
        e.xcgs[,i,j,s] <- (Tx/Lx)
      }
    }
  }

  # make ex dataframe
  e.xcgm <- apply(e.xcgs, 1:3, median)
  e.xcgl <- apply(e.xcgs, 1:3, quantile, alpha_level/2)
  e.xcgu <- apply(e.xcgs, 1:3, quantile, 1 - alpha_level/2)
  edf <- c()
  for(i in 1:ngroups){
    edfm <- as_tibble(e.xcgm[,,i])
    colnames(edfm) <- cohorts
    edfm$age <- ages
    edfm$group <- i
    edfm <- edfm %>% gather(cohort, ex_median, -age, -group)

    edfl <- as_tibble(e.xcgl[,,i])
    colnames(edfl) <- cohorts
    edfl$age <- ages
    edfl$group <- i
    edfl <- edfl %>% gather(cohort, ex_lower, -age, -group)

    edfu <- as_tibble(e.xcgu[,,i])
    colnames(edfu) <- cohorts
    edfu$age <- ages
    edfu$group <- i
    edfu <- edfu %>% gather(cohort, ex_upper, -age, -group)

    edfg <- edfm %>% left_join(edfl) %>% left_join(edfu)
    edf <- rbind(edf, edfg)
  }

  # make hx dataframe


  h.xcgm <- apply(h.xcgs, 1:3, median)
  h.xcgl <- apply(h.xcgs, 1:3, quantile, alpha_level/2)
  h.xcgu <- apply(h.xcgs, 1:3, quantile, 1 - alpha_level/2)
  hdf <- c()
  for(i in 1:ngroups){
    hdfm <- as_tibble(h.xcgm[,,i])
    colnames(hdfm) <- cohorts
    hdfm$age <- ages
    hdfm$group <- i
    hdfm <- hdfm %>% gather(cohort, hx_median, -age, -group)

    hdfl <- as_tibble(h.xcgl[,,i])
    colnames(hdfl) <- cohorts
    hdfl$age <- ages
    hdfl$group <- i
    hdfl <- hdfl %>% gather(cohort, hx_lower, -age, -group)

    hdfu <- as_tibble(h.xcgu[,,i])
    colnames(hdfu) <- cohorts
    hdfu$age <- ages
    hdfu$group <- i
    hdfu <- hdfu %>% gather(cohort, hx_upper, -age, -group)

    hdfg <- hdfm %>% left_join(hdfl) %>% left_join(hdfu)
    hdf <- rbind(hdf, hdfg)
  }
  edf <- edf %>% mutate(group_label = group_labels[group])
  edf$group_label <- factor(edf$group_label, levels = group_labels)
  edf$cohort <- as.numeric(edf$cohort)
  hdf <- hdf %>% mutate(group_label = group_labels[group])
  hdf$group_label <- factor(hdf$group_label, levels = group_labels)
  hdf$cohort <- as.numeric(hdf$cohort)
  return(list(ex_df = edf, hx_df = hdf))
}
