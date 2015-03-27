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
df <- m70setup("path/to/m70/directory")
```
During the process a function check if the file name have the hours written as follow : HH_MM and if not make a correction:
"8_00" will became "08_00"


* The `pdfdplot` function generate diagnostic plots based on the files. 
```r
pdfdplot(df)
```
Optionnal (but you probably want to use them !):

    * outname = custom name for the file (default: "diagPlot.pdf"), 
    * outpath = path to directory in which you want to save the file
    
* The `regsetup` function allow to select the data you want for the regression, throught a "selection file". The selection file is a file to specify which data points you want to dicard. There are 5 columns in the "selection file"
    * fileid: The file name (as the titles of the diagnostic plots are written)
    * start: Number of point you want to discard at the beginning of the measurement
    * end: Number of point you want to discard at the end of the measurement
    * other: Line number of single(s) value(s) to remove (separated by "-")
    * state: Useless for now, leave blank
You probably want to iterate with pdfplot until you are satisfied with the regression.

```r
regsetup(df, path="path/to/regselection/file", file="regselectionfilename")
```

Optionnal (but you also probably want to use them !):

    * path = "path/to/directory" (the working directory by default)
    * file = "filename" (regselection.csv by default)
If you don't specify these 2 parameters and have no "selection file", the function is going to create one for you with the default parameters.  

__Warning:__ For now no control are done on want you enter to this file, so double check that there is no typo or weird things might happen.

__Warning:__ Consequently the csv file should use coma (",") as field separator and dots (".") as decimal point.
* The `extrcFlux` function do the regression and extract flux (+ other usefull data) 
```r
extrcFlux(df)
```
* The `getNF` function calculate a net flux based on chamber caracteristics
```r
getNF(RF = 3.4, Dchb_mm = 300, Hchb_mm = 300, Patm = 101300, T_Cel = 25)
```

You might just want to convert a bunch of m70 to csv : 
```r
m70tocsv("path/to/m70/directory")
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
