#' Add age of death column to a CenSoc data table
#' Add age of death based on month and year of birth and death.
#'
#'@param dt a CenSoc data table
#'@return a CenSoc data table with `age_of_death` column.

add_age_of_death_column <- function(dt){
  dt <- as.data.table(dt)
  if(sum(c("byear", "dyear", "bmonth", "dmonth") %in% colnames(dt))!=4){
    stop("Need to have the following columns to calculate age of death: byear, dyear, bmonth, dmonth.")
  }
  dt[, age_of_death := ifelse(bmonth<=dmonth, dyear-byear, dyear-byear-1)]
  return(dt)
}
