/* Teil c) Grafiken

Schritt 01: Produktionsgrafiken

Ziel:
- Visualisierung der Produktionsmengen nach Pumpentyp und Standort

Inhalt:
1. Boxplot der Stückzahlen je Pumpentyp --> Erkennung von Ausreißern & Streuung
2. Boxplot der Stückzahlen je Standort --> Vergleich der Produktionsvariabilität
3. Zeitlicher Verlauf der Produktion pro Pumpentyp über Datum */

/* 1. Filter auf Kennzahl = Stueckzahl */
data pumpx.produktion_plotbasis;
  set pumpy.standard_produktion_clean;
  where Kennzahl = "Stueckzahl";
run;

/* 2. Boxplot der Stückzahl je Pumpentyp */
proc sgplot data=pumpx.produktion_plotbasis;
  vbox Wert / category=Pumpentyp;
  title "Produktionsmenge – Boxplot je Pumpentyp";
  yaxis label="Stückzahl";
run;

/* 3. Boxplot der Stückzahl je Standort */
proc sgplot data=pumpx.produktion_plotbasis;
  vbox Wert / category=Standort;
  title "Produktionsmenge – Boxplot je Standort";
  yaxis label="Stückzahl";
run;

/* 4. Zeitverlauf der Produktionsmenge pro Pumpentyp */
proc sort data=pumpx.produktion_plotbasis;
  by Pumpentyp Datum;
run;

proc sgplot data=pumpx.produktion_plotbasis;
  series x=Datum y=Wert / group=Pumpentyp;
  title "Produktionsverlauf – Zeitreihe je Pumpentyp";
  xaxis label="Datum";
  yaxis label="Stückzahl";
run;