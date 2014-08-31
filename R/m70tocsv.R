#' Convert \emph{Vaisala} files ".M70" to ".csv"
#' 
#' Convert all m70 from a directory to csv files
#'
#' @param path path to the directory to treat
#' @param newdir if TRUE the file are saved in a new directory
#' @param dirname a name for the output directory
#' @export

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
  
  file_list <- list.files(path, pattern="*.m70") # file list creation
  
  # file number stat setup
  nbFile <- length(file_list)
  cpt_file <- 0 # to count how many files are treated
  
  # For all files in the directory
  for (i in file_list){
    cpt_file <- cpt_file + 1
    file <- paste(path,i,sep="") # complete path to file
    df <- read.m70(file)

    savepath <- paste(savdir, 
                      strsplit(basename(file), "[.]")[[1]][1],
                      ".csv", sep="") # save path
    write.csv(df, savepath, row.names=FALSE, quote=FALSE)
  }
  cat("Treated files: ", cpt_file, "/", nbFile, "\n")
}