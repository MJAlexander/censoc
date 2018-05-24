#' Add column with recoded hispanic origin to a CenSoc data table
#'
#' Recode hispanic variable.
#'
#'@param df a CenSoc data frame. Must have `HISPAN` column.
#'@return a CenSoc data frame with `hispan_recode` column.

add_hispan_recode_column <- function(df){
  df <- df %>%
    mutate(hispan_recode = case_when(
      as.numeric(substring(df$HISPAN, 1, 1))==0 ~ "Not Hispanic",
      as.numeric(substring(df$HISPAN, 1, 1))==1 ~ "Mexican",
      as.numeric(substring(df$HISPAN, 1, 1))==2 ~ "Puerto Rican",
      as.numeric(substring(df$HISPAN, 1, 1))==3 ~ "Cuban",
      as.numeric(substring(df$HISPAN, 1, 1))==4 ~ "Other",
      TRUE ~ "NA"
    ))
  return(df)
}
