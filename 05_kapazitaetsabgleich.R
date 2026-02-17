# 05_kapazitaetsabgleich.R
library(tidyverse)

# Kapazitäten definieren (Stand 2024)
kapazitaet_u3 <- 80
kapazitaet_ue3 <- 336

# Daten aus Skript 04 laden (kita_prognose_reilingen)
abgleich <- kita_prognose_reilingen %>%
  mutate(
    differenz_u3 = kapazitaet_u3 - bedarf_u3,
    differenz_ue3 = kapazitaet_ue3 - bedarf_ue3,
    status_u3 = ifelse(differenz_u3 < 0, "Mangel", "Deckung"),
    status_ue3 = ifelse(differenz_ue3 < 0, "Mangel", "Deckung")
  )

print("Abgleich Bedarf vs. Kapazität:")
print(abgleich)