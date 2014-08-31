#' Set up diagnostic plots
#' 
#' This function print a diagnostic plot for multiple measurements
#' A fileid column is necessary
#'
#' @param df data to proceed
#' @param outname a name for the output pdf file, 
#' by default the name is "diagPlot.pdf"
#' @param outpath a path to a directory to save the file
#' by default a "output" directory is created in the working directory to store
#' the file
#' @export

pdfdplot <- function(df, outname="diagPlot.pdf", outpath=NULL){
  
  if(is.null(outpath)){ #
    dirls <- basename(list.dirs(getwd(), recursive=FALSE))
    outpath <- paste0(getwd(), "/output/")
    if ("output" %in% dirls){ # Is an output directory available
    }else{
      dir.create(outpath)
    }
    savpath <- paste0(outpath, outname)
  }else{
    savpath <- paste0(chk_eop(outpath), outname)
  }
  
  pdf(savpath)
  for(i in unique(df$fileid)){
    dplot(df[which(df$fileid == i),], i)
  }  
  graphics.off()
}