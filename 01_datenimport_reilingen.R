# 01_datenimport_reilingen.R
# Projekt: Bevölkerungsvorausberechnung und Kita-Bedarf Reilingen

library(tidyverse)

# 1. Datenimport aus dem Ordner "data"
# Lösung 1: encoding = "latin1" (wegen der Umlaute im Behörden-Format)
# Lösung 2: skip = 8 (überspringt Titel UND die dreizeiligen Spaltenköpfe)
# Lösung 3: col_names (wir vergeben unsere eigenen, sauberen Namen)
reilingen_roh <- read_csv2(
  "data/reilingen_demo_20_y_brackets.csv",
  locale = locale(encoding = "latin1"),
  skip = 8,
  col_names = c(
    "stichtag", 
    "regionalschluessel", 
    "gemeinde", 
    "altersgruppe", 
    "insgesamt", 
    "maennlich", 
    "weiblich"
  )
)

# Wir schauen uns das Ergebnis an
print(head(reilingen_roh))