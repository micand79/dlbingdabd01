/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse

Schritt 07: Teil 4 - Früherkennung von Fehlentwicklungen (Produktion)

Ziel:
- Negative Entwicklungen in Produktionsprozessen frühzeitig erkennen
- Identifizierte Produktionsrückgänge, Trendbrüche oder untypische Entwicklungen z.B.:
	- Plötzlicher Rückgang der Stückzahlen für einen Pumpentyp
	- Atypische Abweichungen in einem Werk
	- Langsamer Abwärtstrend über Wochen/Monate hinweg

Methode:
- Zeitreihenanalyse mit proc timeseries oder gleitendem Mittelwert
- Visualisierung mit proc sgplot
- Moving Averages / Glättung mit proc expand
- Berechnung von Abweichungen zur Vorperiode

/* 1. Filter auf Stückzahl und Datumsformat vorbereiten */
data pumpen.produktion_stueckzahl;
  set pumpy.standard_produktion_clean;
  where Kennzahl = "Stueckzahl";
  format Datum date9.;
run;

/* 2. Aggregation: Summe der Stückzahl je Datum und Pumpentyp */
proc sql;
  create table pumpen.produktion_trendbasis as
  select Datum, Pumpentyp, sum(Wert) as Produktionsmenge
  from pumpen.produktion_stueckzahl
  group by Pumpentyp, Datum
  order by Pumpentyp, Datum;
quit;

/* 3. Glättung über gleitenden Mittelwert (7 Tage oder Perioden) */
proc expand data=pumpen.produktion_trendbasis out=pumpen.produktion_rolling method=none;
  by Pumpentyp;
  id Datum;
  convert Produktionsmenge = MA7_Produktion / transformout=(movave 7);
run;

/* 4. Visualisierung der Produktionstrends je Pumpentyp */
proc sgplot data=pumpen.produktion_rolling;
  by Pumpentyp;
  series x=Datum y=Produktionsmenge / lineattrs=(color=blue);
  series x=Datum y=MA7_Produktion / lineattrs=(color=red pattern=shortdash);
  title "Produktionstrend mit gleitendem Mittelwert (Pumpentyp = #BYVAL(Pumpentyp))";
  yaxis label="Stückzahl";
  xaxis label="Datum";
run;

/* 5. Berechnung der Differenz zur Vorperiode (Tages-/Wochenvergleich) */
data pumpen.produktion_diff;
  set pumpen.produktion_rolling;
  by Pumpentyp;
  retain letzte_Produktion;

  if first.Pumpentyp then Differenz = .;
  else Differenz = Produktionsmenge - letzte_Produktion;

  letzte_Produktion = Produktionsmenge;
run;

/* Nur jede 7. Zeile behalten */
data pumpen.produktion_diff_kurz;
	set pumpen.produktion_diff;
	retain counter 0;
	counter + 1;
	
	if mod(counter, 7) = 0; /* Nur jede siebte Beobachtung behalten */
run;

proc sgplot data=pumpen.produktion_diff_kurz;
  vbar Datum / response=Differenz group=Pumpentyp groupdisplay=cluster;
  title "Veränderung der Produktionsmenge (Wochenauswahl)";
  yaxis label="Differenz zur Vorperiode";
run;