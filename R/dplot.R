#' Diagnostic plot for m70 data
#' 
#' This function print diagnostic plots
#'
#' @param df data to proceed
#' @export

# TODO: insert an id for each file processed

dplot <- function(df, title="Main Title"){
  title <- as.character(title)
  # Check if timestamp is present (and if not creation occur)
  df <- chk_ts(df)
  # Création d'une colonne temps en seconde
  df$tps <- posixctTOsec(df$timestamp)
  
  kdf <- df[which(df$keep==TRUE),]
  nkdf <- df[which(df$keep==FALSE),]
  
  # Template
  m <- lm(df$CO2~df$tps)
  km <- lm(kdf$CO2~kdf$tps)
  mr2 <- paste("R² =", as.character(round(summary(m)$r.squared, 3)))
  mslp <- paste("slope =", as.character(round(coef(m)[2], 3)))
  kmr2 <- paste("R² =", as.character(round(summary(km)$r.squared, 3)))
  kmslp <- paste("slope =", as.character(round(coef(km)[2], 3)))
  
  # Graphical parameters
  opar <- par(no.readonly = TRUE) # Save graphical parameters
  par(oma=c(0,0,3,0),
      mfrow = c(3,2),
      mar=c(2,3,2,1))
  
  plot(m, which=2, sub.caption=NA, caption = NA)
  plot(km, which=2, sub.caption=NA, caption = NA)
  
  # plot CO2  
  plot(df$CO2~df$tps, ann = FALSE)
  title(main=mr2, line = 0.2, cex.main = .9, adj=1)
  mtext(mslp,side=3, line = 0.1, cex= .6, adj=0)
  title(ylab="CO2 (µmol/m²/s)", line = 2)
  abline(m, col="red")

  plot(df$CO2~df$tps, ann = FALSE, col="white")
  points(kdf$CO2~kdf$tps, ann = FALSE)
  title(main=kmr2, line = 0.2, cex.main = .9, adj=1)
  mtext(kmslp,side=3, line = 0.1, cex= .6, adj=0)
  title(ylab="CO2 (µmol/m²/s)", line = 2)
  points(nkdf$CO2~nkdf$tps, col="darkgrey")
  abline(km, col="red")
  abline(v=c(min(kdf$tps), max(kdf$tps)), col="blue")
  
  plot(df$RH~df$tps, ann = FALSE)
  abline(v=c(min(kdf$tps), max(kdf$tps)), col="blue")
  title(ylab="RH (%)", line = 2)
  
  plot(df$temperature~df$tps, ann = FALSE)
  abline(v=c(min(kdf$tps), max(kdf$tps)), col="blue")
  title(ylab="T (°C)", line = 2)
  
  par(opar) # Restore graphical parameters
  mtext(title, line=2, font=2, cex=1.2)
  
}