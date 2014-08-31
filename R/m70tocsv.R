#' Convert \emph{Vaisala} files ".M70" to ".csv"
#' 
#' Convert all m70 from a directory to csv files
#'
#' @param path path to the directory to treat
#' @param newdir if TRUE the file are saved in a new directory
#' @param dirname a name for the output directory
#' 

# TODO :
# Si dirname différent de défaut et newdir = F : Warning ou erreur

m70tocsv <- function(path, newdir=T, dirname="CO2_csv"){
  # Check path format
  path <- chk_eop(path)
  
  # Create output directory if asked
  if(newdir){
    savdir <- paste(dirname(path), "/", dirname,"/", sep="")
    dir.create(savdir)
  }else{
    savdir <- path
  }
  
  # Création de la liste des fichiers issue de la sonde Vaisala ##
  file_list <- list.files(path, pattern="*.m70")
  
  #Nombre de fichier :
  nbFile <- length(file_list)
  
  # Mise à 0 des compteurs
  cpt_file <- 0
  
  # For all files in the directory
  for (i in file_list){
    cpt_file <- cpt_file + 1
    # Création du chemin vers le fichier n
    file <- paste(path,i,sep="")
    # Lecture du fichier n en ommettant les 9 1re lignes
    df <- read.m70(file)
#     df <- read.table(file, sep="", skip=9)
    # Check column order
#     df <- colchk(df)
    
    # Création du chemin d'écriture
    savepath <- paste(savdir, 
                      strsplit(basename(file), "[.]")[[1]][1],
                      ".csv", sep="")
    write.csv(df, savepath, row.names=FALSE, quote=FALSE)
  }
  # Comptage des fichiers traités
  cat("Treated files: ", cpt_file, "/", nbFile, "\n")
} # Function end