#' Add column with recoded race to a CenSoc data table
#'
#' Recode race variable.
#'
#'@param df a CenSoc data frame. Must have `RACE` column.
#'@return a CenSoc data frame with `race_recode` column.
#'@export

add_race_recode_column <- function(df){
  df <- df %>%
    mutate(race_recode = case_when(
      RACE==100 ~ "White",
      RACE==200 ~ "Black",
      RACE==300 ~ "American Indian/Alaska Native",
      RACE==400 ~ "Chinese",
      RACE==600 ~ "Filipino",
      RACE==210 ~ "Black",
      RACE==500 ~ "Japanese",
      RACE==620 ~ "Filipino",
      RACE==610 ~ "Filipino",
      RACE==634~ "Filipino",
      RACE==685 ~ "Filipino",
      RACE==371 ~ "American Indian/Alaska Native",
      RACE==372 ~ "American Indian/Alaska Native",
      RACE==630~ "Filipino",
      RACE==354~ "American Indian/Alaska Native",
      RACE==680~ "Filipino",
      TRUE ~ "NA"
    ))
  return(df)
}
