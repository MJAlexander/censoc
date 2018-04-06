#' Get CenSoc tabulations into data format for JAGS
#'
#' @param tab_df a tabulated CenSoc dataset. Use `tabulate_deaths` on original dataset.
#' @param group_col a grouping column. If `NULL` there is no grouping column
#' @return a three-dimensional array with dimensions cohort x age x group level.


get_deaths_in_jags_format<- function(tab_df, group_col = NULL) {

  group_col <- enquo(group_col)

  if (rlang::quo_is_null(group_col)) {
    y.cxg <- as.matrix(tab_df %>% spread(age_of_death, n))[,-1]
    dim(y.cxg) <- c(dim(as.matrix(tab_df %>% spread(age_of_death, n))[,-1]), 1)
  } else {

    group_vals <- df %>%
      distinct(!!group_col) %>%
      pull()

    if (length(group_vals) > 2){
      stop("Grouping variable can only have 2 levels.")
    }

    y.cx1 <- as.matrix(tab_df %>% filter(!!group_col==group_vals[1]) %>% select(-!!group_col) %>% spread(age_of_death, n))[,-1]
    y.cx0 <- as.matrix(tab_df %>% filter(!!group_col==group_vals[2]) %>% select(-!!group_col) %>% spread(age_of_death, n))[,-1]
    y.cxg <- abind(y.cx1, y.cx0, along = 3)

  }
  return(y.cxg)
}
