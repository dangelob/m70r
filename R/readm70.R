#' Read ".m70" files
#' 
#' This function read the .m70 files
#' 
#'
#' @param path path to the file to clean
#' 

read.m70 <- function(path){
  df <- read.table(path, sep="", skip=9) # Read file without the 1st 9 lines
  df <- chk_col(df) # Check column order
  return(df) 
}