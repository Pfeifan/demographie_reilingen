# 02_basis_trend_modell.R
# Projekt: Bevölkerungsvorausberechnung und Kita-Bedarf Reilingen
# Teil 2: Berechnung des durchschnittlichen Wanderungssaldos (Der Trend)

library(tidyverse)

# ==============================================================================
# Teil 2a: Zuzüge importieren und aufräumen
# ==============================================================================
zuzuege_roh <- read_csv2(
  "data/reilingen_zuzuege.csv",
  locale = locale(encoding = "latin1"), 
  skip = 4 
)

zuzuege_sauber <- zuzuege_roh %>%
  rename(gemeinde = `...1`, jahr = `...2`) %>%
  filter(!is.na(jahr)) %>%
  mutate(across(-gemeinde, as.numeric)) %>%
  select(-Insgesamt) %>%
  pivot_longer(
    cols = -c(gemeinde, jahr), 
    names_to = "altersgruppe",
    values_to = "zuzuege"
  )

# ==============================================================================
# Teil 2b: Fortzüge importieren und aufräumen (Das ist neu!)
# ==============================================================================
# ACHTUNG: Bitte prüfe, ob die Datei in deinem data/ Ordner wirklich so heißt:
fortzuege_roh <- read_csv2(
  "data/reilingen_fortzuege.csv",
  locale = locale(encoding = "latin1"), 
  skip = 4 
)

fortzuege_sauber <- fortzuege_roh %>%
  rename(gemeinde = `...1`, jahr = `...2`) %>%
  filter(!is.na(jahr)) %>%
  mutate(across(-gemeinde, as.numeric)) %>%
  select(-Insgesamt) %>%
  pivot_longer(
    cols = -c(gemeinde, jahr), 
    names_to = "altersgruppe",
    values_to = "fortzuege" # Hier nennen wir den Wert jetzt 'fortzuege'
  )

# ==============================================================================
# Teil 2c: Tabellen zusammenführen und den Trend-Saldo berechnen!
# ==============================================================================
wanderungs_trend <- zuzuege_sauber %>%
  # Wir kleben die Fortzüge exakt passend zu Jahr und Altersgruppe daneben
  left_join(fortzuege_sauber, by = c("gemeinde", "jahr", "altersgruppe")) %>%
  
  # Wir rechnen für jedes Jahr: Zuzüge minus Fortzüge
  mutate(saldo = zuzuege - fortzuege) %>%
  
  # Jetzt das Wichtigste: Wir fassen alle Jahre zusammen!
  group_by(altersgruppe) %>%
  
  # Wir berechnen den DURCHSCHNITT für Reilingen über den gesamten Zeitraum
  summarise(
    durchschnittlicher_saldo_pro_jahr = round(mean(saldo, na.rm = TRUE), 0)
  )

# Schauen wir uns das fertige Meisterwerk an:
print("Der jährliche durchschnittliche Wanderungssaldo für Reilingen:")
print(wanderungs_trend)