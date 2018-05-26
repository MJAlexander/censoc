#' Read in HMD text file
#'
#' @param file_name string indicating location of hmd text file
#' @param add_country logicial indicating whether or not to add a column with the country name. Default is `FALSE`
#' @param country_name country name
#' @return a data table with the contents of HMD file read in.
#' @export


read_hmd <- function(file_name,
                     add_country = FALSE,
                     country_name = NULL){
  d <- fread(file_name)
  if(add_country){
    if(is.null(country_name)){
      stop("Need to supply country name")
    }
    else{
      d$Country <- country_name
    }
  }
  return(d)
}
