#' Data preparation
#' 
#' Input a path to a directory with m70 files. The function will prepare the data
#' for visualisation. By defaut m70 files will be converted in csv and written in 
#' an CO2_csv directory, a csv file with all the data will be written in an "output"
#' directory 
#'
#' @param path Path to the directory to treat
#' 

## TODO
# Retrait de la copie en csv (m70tocsv) − DONE
# Mettre la fonction a disposition quand même dans le package

m70setup <- function(path){
  m70filename(path)
  df <- m70concat(path, id="name")
  return(df)
}