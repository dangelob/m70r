#' Stringr wrapper to easily return parts of the m70 filenames
#' 
#' Cette fonction prend un nom de fichier m70 (Vaisala) en entrée et le découpe. 
#' Elle permet d'isoler les informations présentent dans le nom du fichier
#' (Exemple : la date, l'heure)
#' @param filename Nom du fichier à traiter (nom de fichier Vaisala)
#' @param output Choix de la partie du nom à retourner : 
#'   "base" : renvoie le nom du fichier sans l'extension
#'   "date" : renvoie la date 
#'   "heure" : renvoie l'heure du fichier
#' @export
#' @examples
#' file <- "2013-10-01 08_03.m70"
#' splt_m70(file, "base")
#' splt_m70(file, "date")
#' splt_m70(file, "heure")

# TODO supprimer la partie "clean" car elle est faite par la suite (cf check_names)
m70strsplit <- function(filename, output="base"){
  
  cpt_heure <- c()
  cpt_heure_ok <- c()
  cpt_heure_ko <- c()
  remain <- NULL
  
  basename <- str_split(filename, "\\.")[[1]][1]
  baseClean <- c()
  splt1 <-  unlist(str_split(basename, " "))
  dateFile <- splt1[1]
  heureFile <- splt1[2]
  if (length(splt1) > 2){
    remain <- paste0(" ", splt1[3:length(splt1)])
  }else{
    remain <- NULL
  }
  if (nchar(heureFile) == 5){
    cpt_heure_ok <- cpt_heure_ok + 1 
  }else if (nchar(heureFile) == 4){
    heureFile <- paste("0", heureFile, sep="")
    cpt_heure <- cpt_heure + 1 
  }else{
    cpt_heure_ko
    cat("Problème : la variable heure ne contient pas un nombre de caractère attendu")
    cat("Le traitement est peut être déjà passé :/")
  }#Fin condition test nombre de caractère de l'heure
  
  if (nchar(str_split(filename, "_")[[1]][1]) == 13){
    #     cat("basename déjà ok")
  }else if (nchar(str_split(filename, "_")[[1]][1]) == 12){
    if(is.null(remain)){
      baseClean <- paste(dateFile, " ", heureFile, sep="")
    }else{
      baseClean <- paste(dateFile, " ", heureFile, remain, sep="")
    }
  }else{
    cat("Problème : avec BaseClean")
  }
  # What's going to be returned
  if (output == "base"){
    return(basename)
  }else if (output == "date"){
    return(dateFile)
  }else if (output == "heure"){
    return(heureFile)
  }else if (output == "baseClean"){
    return(baseClean)
  }  
  
}