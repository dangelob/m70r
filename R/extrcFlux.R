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
    stringsAsFactors=FALSE) # String NON converti en facteur 
  
  j <- 0
  for (i in unique(df$fileid)){
    j <- j + 1
    wdf <- NULL
    wdf <- df[which(df$fileid == i),]
    wdf$tps <- posixctTOsec(wdf$timestamp)
    
    m <- lm(wdf$CO2~wdf$tps)
    
    filename <- i
    R2 <- summary(m)$r.squared
    rawCO2F <- coef(m)[2]
    temperature <- mean(wdf$temperature, na.rm = TRUE)
    temp_sd <- sd(wdf$temperature, na.rm = TRUE)
    RH <- mean(wdf$RH, na.rm = TRUE)
    RH_sd <- sd(wdf$RH, na.rm = TRUE)
    
    newrow <- list(filename, rawCO2F, R2, temperature, temp_sd, RH, RH_sd)  
    out[j,] <- newrow
  }
  return(out)
}