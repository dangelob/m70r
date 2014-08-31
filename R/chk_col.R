#' Order the columns if needed and rename them
#' 
#' This function check the column order and rename them
#'
#' @param df dataframe to check
#' 
#' 
# TODO : Séparer la partie renommage de la fonction dans une autre ?
# en même temps c'est juste un renommage de colonne...

chk_col <- function(df){
  
  fix_missing <- function(x) {
    x[x == "-"] <- NA
    x
  }
  
  df[3:5] <- lapply(df[3:5], fix_missing) # delete '-' on columns 3 to 5
  df <- data.frame(lapply(df, as.character), stringsAsFactors=FALSE)
  df[3:5] <- lapply(df[3:5], as.numeric) # Last 3 columns as numeric
  col_5 <- mean(df[,5], na.rm=TRUE) # Mean on the 5th col
  
  if (col_5 > 100){ # if TRUE that the CO2 column
    # Do nothing
  }else{ # Reorder colums
    df$CO2 <- df$V3
    df$V3 <- NULL
  }   
  colnames(df) <- c("date","time", "RH","temperature", "CO2") # Rename
  return(df)
}
