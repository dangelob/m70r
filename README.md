m70r
====

Easy m70 files treatement

***

# Reminder

## Fonction list

### High level
* m70setup
  input : dossier plein de csv
  output : un df contenant l'ensemble des données prêt à être traité
* pdfdplot
  input : df de la forme date,time,…
  output : un pdf contenant des graphes de diagnostique des régressions
* dplot
  input : df contenant une mesure
  output : graphes de diagnostique des régressions
* regselect
  input : df à traiter + un fichier de traitement
  output : un df avec une colonne keep (TRUE/FALSE) renseigné
* extrcFlux
  input : df (fileid, timestamp, date, time, RH, temperature, CO2, keep)
  output : df (filename, fluxCO2, sqR, temp.mean, temp.sd, hr.mean, hr.sd)
* getNF
  input : 

### Middle level
* chk_filename
  input : chaine de caractère contenant un nom de fichier
  ouput : chaine de caractère contenant tout ou une partie du nom de fichier avec correction de l'heure (9:53 devient 09:53)
* m70tocsv
  input : path vers un dossier plein de fichiers m70
  output : dossier contenant les données des fichiers m70 convertis en csv
* m70concat
  input : path vers un dossier contenant des fichiers m70
  output : df contenant l'ensemble des données

### Low level
* misc
* chk_col
* splt_m70
* timestp
<<<<<<< HEAD
=======

### TRASH ?
CO2vis
***
>>>>>>> 4f09b33f66f36532e728963cd85c2dda619fc9cb
