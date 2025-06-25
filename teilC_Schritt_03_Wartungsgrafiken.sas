/* Teil c) Grafiken

Schritt 03: Wartungsgrafiken

Ziel:
- Visualisierung zentraler Kennzahlen im Wartungsbereich, um:
	- häufige Wartungstypen zu erkennen
	- typische Wartungsdauer zu analysieren
	- Techniker-Auslastung vergleichen

Inhalt:
1. Balkendiagramm: Wartungstypen
	- Top 5 häufigste Wartungstypen
2. Histogramm: Dauer_Stunden
	- Verteilung der Wartungsdauer in Stunden
3. Balkendiagramm: Techniker
	- Anzahl Wartungen pro Techniker */

/* 1. Datenübernahme in Teil C */
data pumpx.wartungsbasis;
  set pumpy.wartungsdaten;
run;

/* 2. Top 5 häufigste Wartungstypen */
proc freq data=pumpx.wartungsbasis noprint;
  tables Wartungstyp / out=pumpx.top5_wartungstypen;
run;

proc sort data=pumpx.top5_wartungstypen out=pumpx.top5_sorted;
  by descending count;
run;

data pumpx.top5_final;
  set pumpx.top5_sorted(obs=5);
run;

proc sgplot data=pumpx.top5_final;
  vbar Wartungstyp / response=Count;
  title "Top 5 Wartungstypen";
  yaxis label="Anzahl Wartungen";
run;

/* 3. Histogramm der Wartungsdauer */
proc sgplot data=pumpx.wartungsbasis;
  histogram Dauer_Stunden;
  density Dauer_Stunden / type=kernel;
  title "Verteilung der Wartungsdauer in Stunden";
  xaxis label="Dauer (Stunden)";
run;

/* 4. Techniker-Auslastung */
proc freq data=pumpx.wartungsbasis noprint;
  tables Techniker / out=pumpx.techniker_anzahl;
run;

proc sgplot data=pumpx.techniker_anzahl;
  vbar Techniker / response=Count;
  title "Wartungen je Techniker";
  yaxis label="Anzahl Wartungen";
run;