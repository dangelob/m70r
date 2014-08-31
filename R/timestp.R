#' Add a timestamp column based on date and time ones
#' 
#' This function add a timestamp column based on the date and time columns
#'
#' @param df data to proceed
#' @param replace if true after the timestamp column addition the date and time columns will be removed

timestp <- function(df, replace=T){
  df$timestamp <- paste(as.character(df$date), as.character(df$time))
  df$timestamp <- as.POSIXct(df$timestamp, format = "%y-%m-%d %H:%M:%S",tz="CET")
  if(replace){
    df$date <- NULL
    df$time <- NULL
  }else{}
  return(df)
}