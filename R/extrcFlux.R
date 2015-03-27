#' Calcul flux from measurements.
#' 
#' This function compute flux from measurements
#' 
#'
#' @param path path to the file to clean
#' 
#' @export

# TODO :
# Format d'export
# filename, fluxCO2, R2, temperature, temp_sd, RH, RH_sd 
# i, mslp, mr2, 

extrcFlux <- function(df){
  # Check if timestamp is present (and if not creation occur)
  df <- chk_ts(df)
  
  # Remove unwanted data (keep = FALSE)
  df <- df[df$keep == TRUE,]
  
  ## Création d'un dataframe vide dont nb lignes = nb fichier Vaisala
  N <- length(unique(df$fileid))
  out <- NULL
  out <- data.frame(
    filename=rep(NA, N),
    rawCO2F=rep(NA, N),
    R2=rep(NA, N), # R²
    temperature=rep(NA, N), # température moyenne
    temp_sd=rep(NA, N), # température standard deviation
    RH=rep(NA, N), #humidité relative moyenne
    RH_sd=rep(NA, N), #humidité relative standard deviation
    pvalue=rep(NA, N),
    mtime=rep(NA, N),
    stringsAsFactors=FALSE) # String NON converti en facteur 
  
  # function to retrieve p-value
  lmp <- function (modelobject) {
    if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
    f <- summary(modelobject)$fstatistic
    p <- pf(f[1],f[2],f[3],lower.tail=F)
    attributes(p) <- NULL
    return(p)
  }

  j <- 0
  for (i in unique(df$fileid)){
    j <- j + 1
    wdf <- NULL
    wdf <- df[which(df$fileid == i),]
     
    m <- lm(wdf$CO2~wdf$tps)
    
    filename <- i
    R2 <- summary(m)$r.squared
    rawCO2F <- coef(m)[2]
    temperature <- mean(wdf$temperature, na.rm = TRUE)
    temp_sd <- sd(wdf$temperature, na.rm = TRUE)
    RH <- mean(wdf$RH, na.rm = TRUE)
    RH_sd <- sd(wdf$RH, na.rm = TRUE)
    pvalue <- lmp(m)
    mtime <- tail(wdf$tps, 1)-head(wdf$tps, 1)
    
    newrow <- list(filename, rawCO2F, R2, temperature, temp_sd, RH, RH_sd, 
                   pvalue, mtime)  
    out[j,] <- newrow
  }
  return(out)
}