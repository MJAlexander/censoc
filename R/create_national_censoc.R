#' Create a national dataset of matched census and socsec data based on state matched files
#'
#' @param state_censoc_files a vector of filenames referring to state matched censoc files
#' @return a dataframe with matched census and socsec data
#' @export


create_national_censoc <- function(state_censoc_files){
  tables <- lapply(state_censoc_files, read_csv)
  d <- do.call(rbind , tables)
  rm(tables)
  all_censoc_unique <- d[!duplicated(d$clean_key),]
  return(all_censoc_unique)
}
