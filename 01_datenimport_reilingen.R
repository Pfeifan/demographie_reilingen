# 01_datenimport_reilingen.R
# Projekt: Bevölkerungsvorausberechnung und Kita-Bedarf Reilingen

# Lade das wichtigste Paket für Datenbearbeitung in R
# Falls es noch nicht installiert ist, vorher in die Konsole tippen: install.packages("tidyverse")
library(tidyverse)

# Hier importieren wir später die echten Daten vom Statistischen Landesamt.
# Fürs Erste legen wir einen kleinen Platzhalter an:
reilingen_basisdaten <- tibble(
  jahr = 2026,
  einwohner_gesamt = 8300, # Ungefähre Einwohnerzahl Reilingen
  kinder_u3 = 250,         # Beispielwert
  kinder_ue3_bis_6 = 300   # Beispielwert
)

print("Skript erfolgreich angelegt und Basisdaten-Struktur für Reilingen geladen!")