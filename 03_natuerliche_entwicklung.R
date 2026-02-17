# 03_natuerliche_entwicklung.R
# Projekt: Bevölkerungsvorausberechnung Reilingen

library(tidyverse)

# 1. Daten einlesen
reilingen_bewegung <- read_csv2(
  "data/reilingen_birth_death.csv",
  locale = locale(encoding = "latin1"),
  skip = 4
)

# 2. Spalten säubern
reilingen_bewegung_clean <- reilingen_bewegung %>%
  rename(
    jahr = `...2`
  ) %>%
  # Die Zeile, in der überall "Anzahl" steht, rauswerfen:
  filter(Zuzüge != "Anzahl") %>%
  # Nur die Zeilen behalten, wo ein Jahr steht:
  filter(!is.na(jahr)) %>%
  # Jetzt alle relevanten Spalten in Zahlen umwandeln:
  mutate(across(c(Zuzüge, Fortzüge, Lebendgeborene, Gestorbene), as.numeric)) %>%
  # Für die Bequemlichkeit vergeben wir jetzt kurze Namen:
  select(
    jahr, 
    zuzuege = Zuzüge, 
    fortzuege = Fortzüge, 
    geburten = Lebendgeborene, 
    sterbefaelle = Gestorbene
  )

# 3. Durchschnittswerte berechnen
trends_reilingen <- reilingen_bewegung_clean %>%
  summarise(
    avg_geburten = mean(geburten, na.rm = TRUE),
    avg_sterbefaelle = mean(sterbefaelle, na.rm = TRUE),
    avg_wanderungssaldo = mean(zuzuege - fortzuege, na.rm = TRUE)
  )

print("Historische Durchschnitte (2015-2024) für Reilingen:")
print(trends_reilingen)