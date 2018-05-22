#' Calculate number of deaths by birth year, age of death and possible grouping variables
#'
#' Given a CenSoc data frame with individual birth years, ages of death and other grouping variables,
#' will return tabulated deaths by group
#'
#' @param df CenSoc dataframe
#' @param ... grouping variables (in addition to year and race)
#' @return tabulated dataframe

tabulate_deaths <- function(df, ...){
  if(sum(c("byear", "age_of_death") %in% colnames(df))!=2){
    stop("Data frame must contain columns byear and age_of death.")
  }

  add_grps   <- quos(...)

  tab_df <- df %>%
    group_by(byear, age_of_death) %>%
    group_by(!!!add_grps, add = TRUE) %>%
    summarise(n = n()) %>%
    ungroup()

  # remove obs that have implausible ages
  tab_df <- tab_df %>%  mutate(year_death = age_of_death+byear) %>% filter(year_death %in% 1975:2005)
  ## restrict to only use ages 65+
  tab_df <- tab_df %>% filter(age_of_death>64)
  return(tab_df)

}
