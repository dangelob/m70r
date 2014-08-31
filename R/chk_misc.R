#' Misc
#' 
#' Misc
#' 
#' @param x string to proceed
#' @param n starting on the right, how many characters to keep
#' 

# Keep some character of a character string starting on the right side
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

# Check the end of the path
chk_eop <- function(path){
  if(substrRight(path, 1) == "/"){
    
  }else{
    path <- paste0(path, "/")
  }
  return(path)
}

# Check if timestamp col exist and if not create it
chk_ts <- function(df){
  if ("timestamp" %in% colnames(df)){
  }else{
    df <- timestp(df, F)
  }
  return(df)
}

# Create a time colonne (in sec) from a posixct object
posixctTOsec <- function(x){
  step <- as.numeric(x[2] - x[1])
  y <- seq(from=0, by=step, length.out=length(x))
  return(y)
}

# Check if the keep column exists
chk_keep <- function(df){
  if ("keep" %in% colnames(df)){
  }else{
    df$keep <- TRUE
  }
  return(df)
}
