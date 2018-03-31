#' HMD death distributions
#'
#' Calculate distribution of deaths for males given death rates and exposure information from HMD
#'
#' @param mx_data HMD data on death rates
#' @param exp_data HMD data on exposure. Must be same dimensions as death rates
#' @param ages age range
#' @param remove_na whether or not to remove the countries/ years that do not have every age. Default is `TRUE`.
#' @param single_country whether or not dataset contains single or multiple countries
#' @return a tibble that contains proportion of male deaths by age


get_hmd_death_distribution <- function(mx_data,
                                       exp_data,
                                       ages,
                                       remove_na = TRUE,
                                       single_country){

  if(single_country){
    d <- mx_data %>% select(Year, age, Male) %>%
      rename(year = Year, rate = Male) %>%
      mutate(rate = as.numeric(rate)) %>%
      left_join(exp_data %>%
                  select(Year, age, Male) %>%
                  mutate(Male = as.numeric(Male)) %>%
                  rename(year = Year, exp = Male)) %>%
      group_by(year) %>%
      filter(age %in% ages) %>%
      mutate(deaths = rate*exp, prop = deaths/sum(deaths))
  }
  else{
    d <- mx_data %>% select(Year, age, Male, Country) %>%
      rename(year = Year, rate = Male, country = Country) %>%
      mutate(rate = as.numeric(rate)) %>%
      left_join(exp_data %>%
                  select(Year, age, Male, Country) %>%
                  mutate(Male = as.numeric(Male)) %>%
                  rename(year = Year, exp = Male, country = Country)) %>%
      group_by(year, country) %>%
      filter(age %in% ages) %>%
      mutate(deaths = rate*exp, prop = deaths/sum(deaths))
  }

  if(remove_na){
    d <- d %>% filter(!is.na(prop))
  }
  return(d)
}
