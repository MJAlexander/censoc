#' Get first word from a string
#'
#' @param x a string with spaces between words
#' @return first word from string of words
#' @examples
#' get_first_word("Agatha Christie")
#' @export

get_first_word <- function(x)
{
  x.split <- strsplit(x, split = " ")
  x1.list <- lapply(x.split,`[`, 1) # returns NA if no name
  x1 <- unlist(x1.list)
  return(x1)
}

#' Clean matching keys
#'
#' @param key a string that acts as a key that may have punctuation
#' @return a string with no punctuation
#' @examples
#' clean_key("testi'ing")
#' @export


## function to clean keys
clean_key <- function(key){
  return(gsub(" +|[[:punct:]]", "", key))
}


