/* Teil c) Grafiken

Schritt 04: Ausreißer-Visualisierung

Ziel:
- Visualisierung extremer Schwankungen in der Produktionsmenge
	- Identifikation potenzieller Probleme oder annormalem Verhalten im Produktionsverlauf

Inhalt:
1. Scatterplot
	- Datum vs. Produktionsmenge, farbig nach Ausreißerstatus
2. Boxplot
	- Differenz je Pumpentyp */

/* 1. Datengrundlage inkl. Ausreißer-Kennzeichnung */
data pumpx.produktion_diff_plotbasis;
  set pumpen.produktion_diff_kurz;
  length Ausreisser $3;
  if abs(Differenz) > 1000 then Ausreisser = "JA";
  else Ausreisser = "NEIN";
run;

/* 2. Scatterplot: Produktionsmenge über Zeit, farbig nach Ausreißer */
proc sgplot data=pumpx.produktion_diff_plotbasis;
  scatter x=Datum y=Produktionsmenge / group=Ausreisser;
  title "Produktionsverlauf mit Ausreißerkennzeichnung (±1000)";
  xaxis label="Datum";
  yaxis label="Produktionsmenge";
run;

/* 3. Boxplot: Differenz je Pumpentyp */
proc sgplot data=pumpx.produktion_diff_plotbasis;
  vbox Differenz / category=Pumpentyp;
  title "Verteilung der Produktionsdifferenz je Pumpentyp";
  yaxis label="Differenz zur Vorperiode";
run;