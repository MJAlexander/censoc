#' Get meta data associated with tabulated deaths by cohort, age of death and grouping variable
#'
#' Given a tabulated deaths data frame and a minimum age of estimation,
#' will return age vector and length, cohort length, group levels and length
#'
#' @param tab_df A tabulated CenSoc dataframe
#' @param min_age The minimum age of estimation, i.e. where to start estimates of dx from (lowest that makes sense is probably 40)
#' @return a list of metadata

get_meta_data <- function(tab_df, min_age){
  ages <- min_age:110
  nages <- length(ages)
  cohorts <- sort(unique(tab_df$byear))
  ncohorts <- length(cohorts)
  group_levels <- sort(unique(tab_df[,3][[1]])) # grouping variable should be in the third column
  ngroups <- length(group_levels)

  return(list(ages = ages,
              nages = nages,
              ncohorts = ncohorts,
              group_levels = group_levels,
              ngroups = ngroups))

}
