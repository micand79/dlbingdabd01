/* Teil c) Grafiken

Schritt 06: Früherkennung - Differenzgrafik

Ziel:
- Visualisierung von Produktionsabweichungen über die Zeit
--> schnelles Erkennen ungewöhnlicher Veränderungen oder Abwärtstrends in der Produktion

Inhalt:
1. Balkendiagramm
	- Differenz je Datum & Pumpentyp
		- Positiv/negativ sichtbar machen
2. Zeitreihe
	- Original + MA7 für Glättung
		- Frühindikatoren erkennen
3. Optional: gestapelte Entwicklung
	- Summierte Differenz über Zeit
		- Gesamttrend auf Werksebene */

/* 1. Quelle sichern */
data pumpx.produktion_diff_basis;
  set pumpen.produktion_diff_kurz;
run;

/* 2. Balkendiagramm: Differenz je Datum je Pumpentyp */
proc sgplot data=pumpx.produktion_diff_basis;
  vbar Datum / response=Differenz group=Pumpentyp groupdisplay=cluster;
  title "Produktionsabweichungen je Pumpentyp über Zeit";
  xaxis label="Datum" fitpolicy=rotate;
  yaxis label="Differenz zur Vorperiode";
run;

/* 3. Zeitreihe: Produktionsmenge + geglätteter Trend */
proc sgplot data=pumpx.produktion_diff_basis;
  series x=Datum y=Produktionsmenge / group=Pumpentyp lineattrs=(pattern=solid);
  series x=Datum y=MA7_Produktion / group=Pumpentyp lineattrs=(pattern=shortdash);
  title "Produktionsverlauf mit 7-Tage-Gleit-Mittelwert";
  xaxis label="Datum";
  yaxis label="Produktionsmenge";
run;