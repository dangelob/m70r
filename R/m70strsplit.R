#' Stringr wrapper to easily return parts of the m70 filenames
#' 
#' This function allow to return information (date, time) from a m70 filename
#' 
#' @param filename filename to treat
#' @param output What part to return ?
#'   "name" : return filename without extension
#'   "date" : return date 
#'   "time" : return time
#' @export
#' @examples
#' file <- "2013-10-01 08_03.m70"
#' splt_m70(file, "name")
#' splt_m70(file, "date")
#' splt_m70(file, "time")

# TODO supprimer la partie "clean" car elle est faite par la suite (cf check_names)
m70strsplit <- function(filename, output="name"){
  
  cpt_time <- c()
  cpt_time_ok <- c()
  cpt_time_ko <- c()
  remain <- NULL
  
  basename <- str_split(filename, "\\.")[[1]][1]
  baseClean <- c()
  splt1 <-  unlist(str_split(basename, " "))
  dateFile <- splt1[1]
  timeFile <- splt1[2]
  if (length(splt1) > 2){
    remain <- paste0(" ", splt1[3:length(splt1)])
  }else{
    remain <- NULL
  }
  if (nchar(timeFile) == 5){
    cpt_time_ok <- cpt_time_ok + 1 
  }else if (nchar(timeFile) == 4){
    timeFile <- paste("0", timeFile, sep="")
    cpt_time <- cpt_time + 1 
  }else{
    cpt_time_ko
    cat("Error : time length is not right")
#     cat("Le traitement est peut être déjà passé :/")
  }# End test on time length
  
  if (nchar(str_split(filename, "_")[[1]][1]) == 13){
    #     cat("basename déjà ok")
  }else if (nchar(str_split(filename, "_")[[1]][1]) == 12){
    if(is.null(remain)){
      baseClean <- paste(dateFile, " ", timeFile, sep="")
    }else{
      baseClean <- paste(dateFile, " ", timeFile, remain, sep="")
    }
  }else{
    cat("Problème : avec BaseClean")
  }
  # What's going to be returned
  if (output == "name"){
    return(basename)
  }else if (output == "date"){
    return(dateFile)
  }else if (output == "time"){
    return(timeFile)
  }else if (output == "baseClean"){
    return(baseClean)
  }  
  
}