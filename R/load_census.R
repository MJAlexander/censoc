#' Load a census file
#'
#' @param census_file string indicating location of file.
#' @param cols_to_keep vector indicating colname names of variables to keep. Default is just what is needed for match: first name, last name, age, sex, serial number, person number.
#' @param males_only whether to just keep males. Default is \code{TRUE}.
#' @return a census dataframe with match key and unique IPUMS identifier
#' @import data.table

load_census <- function(census_file,
                        cols_to_keep = NULL,
                        males_only = TRUE){

  all_cols_to_keep <- c("SERIAL40", "PERNUM", "AGE", "SEX", "NAMELAST", "NAMEFRST")
  if(!is.null(cols_to_keep)){
    all_cols_to_keep <- c(all_cols_to_keep, cols_to_keep)
  }

  # read in census file, only keeping desired columns
  census <- fread(census_file, select = all_cols_to_keep)
  census <- as.data.table(census)

  # clean variables
  census[,"fname" := str_to_upper(NAMEFRST)]
  census[,"fname" := get_first_word(fname)]
  census[,"lname" := str_to_upper(NAMELAST)]
  census[,"census_age" := as.numeric(AGE)]
  # create unique ID
  census[,"ipums_id" := paste(SERIAL40, PERNUM, sep = "_")]

  # remove those with no name info
  # remove blanks or anything that has question marks
  census <- census[!(grepl("\\?", census$fname)|grepl("\\?", census$lname)|census$lname==""),]

  # create key
  census[,"tmp_key" := paste0(lname, fname, census_age)]
  census[,"clean_key" := clean_key(tmp_key),]
  census[,"n_clean_key" := .N, by = clean_key]
  census <- census[,!"tmp_key"]

  if(males_only==TRUE){
    census <- census[census$SEX == 1,]
  }

  return(census)

}
