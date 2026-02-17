# Kita-Planung Reilingen 2035

Dieses Projekt berechnet, wie viele Kita-Plätze die Gemeinde Reilingen bis zum Jahr 2035 benötigt.

## 📋 Was machen die Skripte?
Ich habe die Analyse in vier einfache Schritte unterteilt:
* **01_datenimport**: Lädt die aktuelle Bevölkerungsstruktur aus Reilingen.
* **02_wanderung**: Berechnet, wie viele Menschen jedes Jahr nach Reilingen ziehen (+110 Personen im Schnitt).
* **03_geburten**: Ermittelt die durchschnittliche Kinderzahl pro Jahr (~73 Geburten).
* **04_prognose**: Lässt die Bevölkerung bis 2035 "altern" und zeigt den Platzbedarf an.

## 💡 Wichtigste Ergebnisse
* [cite_start]**U3-Bereich (Krippe)**: Die Gemeinde rechnet mit einer Quote von 45%[cite: 579]. Mein Modell bestätigt, dass bei ca. [cite_start]80 verfügbaren Plätzen und steigender Nachfrage (>50%) eine Lücke entstehen kann[cite: 581].
* [cite_start]**Ü3-Bereich (Kindergarten)**: Hier entspannt sich die Lage langfristig etwas, da der "Babyboom" in den Neubaugebieten (Herten II) nachlässt[cite: 587, 591].
* [cite_start]**Validierung**: Meine Berechnungen passen sehr gut zu den offiziellen Zahlen der Gemeinde (118 Kinder mit U3-Anspruch im Jahr 2025)[cite: 571].

## 🛠 Voraussetzungen
Um die Skripte auszuführen, benötigst du RStudio und das Paket `tidyverse`. [cite_start]Die Daten stammen aus der Genesis-Datenbank und dem offiziellen Bedarfsplan der Gemeinde[cite: 5, 570].