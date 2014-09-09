m70r
====

m70r is a toolbox to handle m70 files (hopefully) easily.
This package was developped for a personnal need, so there is probably plenty rooms for improvement.

You can install: 

* the latest development version from github with (devtools package needed) 

```r
devtools::install_github("dangelob/m70r")
```
* The package is not available on CRAN

## How to use it ? 

The starting point is that you have a directory full of *.m70 file.

* The `m70setup` function allow to read all the files and concatenate them. 
```r
df <- m70setup(path/to/m70/directory)
```
* The `pdfdplot` function generate diagnostic plots based on the files. 
```r
pdfdplot(df)
```
* The `regsetup` function allow to select the data you want for the regression.
You probably want to iterate with pdfplot until you are satisfied with the regression
```r
regsetup(df)
```
* The `extrcFlux` function do the regression and extract flux (+ other usefull data) 
```r
extrcFlux(df)
```
* The `getNF` function calculate a net flux based on chamber caracteristics
```r
extrcFlux(df)
```

You might just want to convert a bunch of m70 to csv : 
```r
m70tocsv(path/to/m70/directory)
```

***

# Reminder

## Fonction list

### High level
* m70setup
    * input : dossier plein de csv
    * output : un df contenant l'ensemble des données prêt à être traité
* pdfdplot
    * input : df de la forme date,time,…
    * output : un pdf contenant des graphes de diagnostique des régressions
* dplot
    * input : df contenant une mesure
    * output : graphes de diagnostique des régressions
* regsetup
    * input : df à traiter + un fichier de traitement
    * output : un df avec une colonne keep (TRUE/FALSE) renseigné
* extrcFlux
    * input : df (fileid, timestamp, date, time, RH, temperature, CO2, keep)
    * output : df (filename, fluxCO2, sqR, temp.mean, temp.sd, hr.mean, hr.sd)
* getNF
    * input : Rawflux + chamber characteristics + atmospheric pressure + temperature
    * output : net CO2 flux

### Middle level
* chk_filename
    * input : chaine de caractère contenant un nom de fichier
    * ouput : chaine de caractère contenant tout ou une partie du nom de fichier avec correction de l'heure (9:53 devient 09:53)
* m70tocsv
    * input : path vers un dossier plein de fichiers m70
    * output : dossier contenant les données des fichiers m70 convertis en csv
* m70concat
    * input : path vers un dossier contenant des fichiers m70
    * output : df contenant l'ensemble des données

### Low level
* misc  
* chk_col
* splt_m70
* timestp
