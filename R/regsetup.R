#' Select data used for regression
#' 
#' This function add a keep column to the dataframe from an external file to
#' allow easy and reproducible changes in regression setup.
#' The external file is generated if not found.
#' The fileid column must contain the measurement ID to treat
#' The start column allow to put aside the desired number of starting points (interger)
#' The end column allow to put aside the desired number of ending points (interger)
#' The other column allow to put aside specifique point, 
#' by giving a line number (interger)
#' The state column do nothing for now
#'
#' @param df data to proceed
#' @param path path to the setup file (working directory by defaut)
#' @param file setup file name ("regselection.csv" by defaut)
#' @export

# TODO: insert an id for each file processed
# TODO: create the file if he does not exit

regsetup <- function(df, path=getwd(), file="regselection.csv"){
  
#   path <- chk_eop(path)
  file <- file.path(path,file)
  
  # Check file existence and create a template it doesn't
  if (!file.exists(file)){
    init <- data.frame("fileid"=NA, "start"=NA, "end"=NA
                       , "other"=NA,"state"=NA)
    cat(paste0("file not found !\n Creating template in:\n", path))
    write.csv(init, file, quote=FALSE, row.names = FALSE)
  }else{
    slct <- read.csv(file,
                     sep=",",
                     dec=".",
                     header=TRUE)
    slct$other <- as.character(slct$other)
    slct[slct == ""] <- NA
    slct[is.na(slct)] <- 0
    slct$fileid <- gsub("−", "-", slct$file)
    
    # Compute a list of the number of row for each fileid
    x <- unique(df$fileid)
    nro <- unlist(lapply(x, function(x) NROW(df[df$fileid == x,])))
    slct <- merge(slct, data.frame(fileid=x, nro=nro), all.x = TRUE, by = "fileid")
    # Ajout control sur colonne : NA >> 0 ; - >> 0
    mgdf <- data.frame()
    for (i in unique(slct$fileid)){
      
      wdf <- slct[which(slct$fileid == i),]
      
      A <- B <- C <- K <- sgl <- NULL
      
      A <- rep(FALSE, wdf$start)
      B <- rep(TRUE, (wdf$nro-(wdf$start+wdf$end)))
      C <- rep(FALSE, wdf$end)
      K <- c(A,B,C)
      
      # Process single value
      sgl <- unlist(strsplit(as.character(wdf$other), "-"))
      
      K[as.numeric(sgl)] <- FALSE
      tmp <- data.frame(fileid=i,
                        timestamp=df[which(df$fileid == i),]$timestamp,
                        keep=K)
      mgdf <- rbind(mgdf, tmp)
    }
    
    df$keep <- NULL
    df <- merge(df, mgdf, all.x=TRUE)
    df$keep[is.na(df$keep)] <- TRUE
    
  }
    return(df)
}