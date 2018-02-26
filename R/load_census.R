#' Load a census state file
#'
#' @param state_file string indicating location of file
#' @param cols_to_keep vector indicating colname names of variables to keep
#'

load_census <- function(state_file,
                              cols_to_keep){
  fread(state_file)
  return("Yay")
}
