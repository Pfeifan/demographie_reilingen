# 04_prognose_motor.R
# Das Herzstück: Die schrittweise Vorausberechnung für Reilingen

library(tidyverse)

# 1. Parameter aus deinen vorigen Berechnungen laden
# (Hier nutzen wir die Werte, die du gerade in der Konsole hattest)
avg_geburten <- 73
avg_wanderung_u18 <- 31 # aus deinem Skript 02 Ergebnis
avg_wanderung_gesamt <- 110

# 2. Startzustand 2024 (aus deinem image_0864c2.png)
# Wir erstellen eine Tabelle für die relevanten Kita-Jahrgänge
bevoelkerung_aktuell <- tibble(
  alter = 0:6,
  anzahl = c(rep(249/3, 3), rep(258/3, 3), 385/4) # Wir verteilen die Gruppen auf Einzeljahre
)

# 3. Die Prognose-Schleife (2025 bis 2035)
prognose_jahre <- 2025:2035
ergebnisse <- list()

temp_bev <- bevoelkerung_aktuell

for(j in prognose_jahre) {
  
  # A) Altern: Jeder Jahrgang rückt ein Jahr weiter
  temp_bev <- temp_bev %>%
    mutate(alter = alter + 1)
  
  # B) Zuzug: Wir addieren den Trend-Zuzug (31 Kinder / 18 Jahre = ca. 1.7 pro Jahrgang)
  zuzug_pro_jahrgang <- avg_wanderung_u18 / 18
  temp_bev <- temp_bev %>%
    mutate(anzahl = anzahl + zuzug_pro_jahrgang)
  
  # C) Geburten: Wir fügen die neuen Babys (Alter 0) hinzu
  neue_babys <- tibble(alter = 0, anzahl = avg_geburten + (zuzug_pro_jahrgang))
  temp_bev <- bind_rows(neue_babys, temp_bev) %>% filter(alter <= 6)
  
  # D) Bedarfsrechnung für dieses Jahr
  u3_bedarf <- sum(temp_bev$anzahl[temp_bev$alter < 3]) * 0.45
  ue3_bedarf <- sum(temp_bev$anzahl[temp_bev$alter >= 3 & temp_bev$alter < 6]) * 0.96
  
  ergebnisse[[as.character(j)]] <- tibble(
    jahr = j,
    bedarf_u3 = round(u3_bedarf),
    bedarf_ue3 = round(ue3_bedarf),
    gesamt_bedarf = round(u3_bedarf + ue3_bedarf)
  )
}

# 4. Endergebnis anzeigen
kita_prognose_reilingen <- bind_rows(ergebnisse)
print(kita_prognose_reilingen)