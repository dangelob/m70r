#' Concat files
#' 
#' This function Concat CO2 files either csv or m70
#'
#' @param path Path to the files to concatenate
#' @param id defaut is "name" and add a file id (the actual name of the file)
#' @param inFormat choose the input format of the files "m70" or "csv"

# TODO: insert an id for each file processed
# TO THINK: The write option seems useless... if people want to write it they can do it themselves éventullement à garder comme débug... et encore

m70concat <- function(path, id="name", inFormat="m70"){
  # Check path format if there is an "/" at the end or not
  path <- chk_eop(path)
  
  if (inFormat == "csv"){
    file_list <- list.files(path, pattern="*.csv", full.names=TRUE)
  }else if (inFormat == "m70"){
    file_list <- list.files(path, pattern="*.m70", full.names=TRUE)
  }else{
    cat("unknown format \n")
  }
  
  df <- data.frame()
  
  # Create a list of list which will contain the data 
  ls <- rep(list(list()), length(file_list)) 
  
  if(inFormat=="csv"){    
    # If we want to insert an ID for each file
    if(id == "name"){
      for (fileid in seq_along(file_list)){
        ls[[fileid]] <- cbind(read.csv(file_list[fileid], header=TRUE, sep=","), fileid=basename(file_list[fileid]))
      }
    }else if(id == "num"){
      for (fileid in seq_along(file_list)){
        ls[[fileid]] <- cbind(read.csv(file_list[fileid], header=TRUE, sep=","), fileid)
      }
    }else{
      ls[[fileid]] <- read.csv(file_list[fileid], header=TRUE, sep=",")
    }
  }else if (inFormat == "m70"){
    # If we want to insert an ID for each file
    if(id == "name"){
      for (fileid in seq_along(file_list)){
        ls[[fileid]] <- cbind(read.m70(file_list[fileid]), fileid=basename(file_list[fileid]))
      }
    }else if (id == "num"){
      for (fileid in seq_along(file_list)){
        ls[[fileid]] <- cbind(read.m70(file_list[fileid]), fileid)  
      }
    }else{
      ls[[fileid]] <- read.m70(file_list[fileid])
    }
  }
  
  df <- do.call("rbind", ls)

  #Check for timestamp col
  if ("timestamp" %in% colnames(df)){
  }else{
    df <- timestp(df, replace=FALSE)
  }
  df <- chk_keep(df)
  
  return(df)
}