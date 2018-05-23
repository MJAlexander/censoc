#' Get left and right truncation ages for each cohort and grouping variable level
#'
#' Given a tabulated deaths data frame and the number of groups and cohorts,
#' will return matrices containing left and right truncation ages
#'
#' @param tab_df A tabulated CenSoc dataframe
#' @param ncohorts Number of cohorts
#' @param ngroups Number of group levels
#' @return a list containing matrices of left and right truncation ages

get_truncation_ages <- function(tab_df, ncohorts, ngroups){
  x_left <- tab_df %>%
    group_by(byear) %>%
    summarise(xl = min(age_of_death)) %>%
    select(xl) %>%
    pull()
  x_right <- tab_df %>%
    group_by(byear) %>%
    summarise(xr = max(age_of_death)) %>%
    select(xr) %>%
    pull()

  x_left <- matrix(rep(x_left, ngroups), nrow = ncohorts)
  x_right <- matrix(rep(x_right, ngroups), nrow = ncohorts)

  return(list(x_left = x_left,
              x_right = x_right))
}
