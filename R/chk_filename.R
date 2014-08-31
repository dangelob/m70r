#' Check m70 filenames
#' 
#' This function check if m70 files are standard. 
#' Files are considered standard if they begin with a standard timestamp (AAAA-MM-JJ HH_MM). If not the function try to correct it.
#' 
#' 
#' (Example : 2013-02-11 7_45.m70 become : 2013-02-11 07_45.m70 )
#' 
#' @param dirpath Path to the directory to treat

chk_filename <- function(dirpath){
  
  # Check path format
  dirpath <- chk_eop(dirpath)
  
  file_list <- list.files(dirpath, pattern="*.m70")
  #Nombre de fichier :
  nbFile <- length(file_list)
  
  #Compteur
  cpt_file <- 0     # Nb de fichiesr traités
  cpt_rename <- 0   # Nb de fichiers renommés
  cpt_norename <- 0 # Nb de fichiers non renommés
  
  for(i in file_list){
    cpt_file <- cpt_file + 1 
    if(nchar(strsplit(i, "_")[[1]][1]) == 12){
      cpt_rename <- cpt_rename + 1 
      baseClean <- m70strsplit(i, "baseClean")
      newname <- paste(baseClean, ".m70", sep="")
      savepath <- paste(dirpath,newname, sep="")
      oldpath <- paste(dirpath, i, sep="")
      file.rename(from=oldpath, to=savepath)
    }else{
      #On ne renomme pas 
      cpt_norename <- cpt_norename + 1
    }
  }
  
  cpt_total <- (cpt_rename + cpt_norename)
  
  cat("Treated files: ", cpt_file,"/", nbFile, "\n")
  cat("Renamed files: ", cpt_rename,"/", nbFile, "\n")
  cat("Not renamed files: ", cpt_norename, "/", nbFile, "\n")
  cat("Total (renamed + not renamed): ", cpt_total, "/", nbFile, "\n")
}