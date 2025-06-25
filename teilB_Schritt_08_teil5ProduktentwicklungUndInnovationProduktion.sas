/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse

Schritt 08: Teil 5 - Produktentwicklung & Innovation (Produktion)

Ziel:
- Entwicklungstrends auf Basis historischer Daten erkennen --> Innovationspotenzial nutzen
1. Erfolgreiche Pumpentypen identifizieren
	- Welche Pumpentypen zeigen kontinuierliches Wachstum?
2. Versteckte Marktverlierer erkennen
	- Gibt es Pumpentypen mit rückläufiger Nachfrage?
3. Trends und Produktlebenszyklen analysieren
	- Welche Typen sind reif für Innovation oder Weiterentwicklung?
4. Entscheidungshilfe für Investitionen in neue Produktgenerationen
	- Welche Pumpentypen sind Kandidaten für Nachfolgemodelle?

Methode:
Jahresaggregation (SUM)
	- Umwandlung täglicher Verkaufsdaten in Jahreswerte je Pumpentyp
		- proc sql, group by jahr, Pumpentyp
Zeitreihen-Trend
	- Visualisierung der Entwicklung von Verkaufszahlen
		- proc sgplot mit series
Gleitender Mittelwert (Moving Average)
	- Glättung saisonaler Schwankungen, Identifikation stabiler Trends
		- proc expand mit movave 3
Ranking je Jahr
	- Vergleich der Beliebtheit (Top 3) pro Jahr
		- RANK() mit Partition by Jahr in proc sql */

/* 1. Jahr aus Datum extrahieren */
data pumpen.historisch_basis;
  set pumpy.standard_historisch_final;
  Jahr = year(Datum);
run;

/* 2. Aggregation: Summe Verkaufsmenge je Pumpentyp und Jahr */
proc sql;
  create table pumpen.historisch_aggregiert as
  select Jahr, Pumpentyp, sum(Wert) as Verkaufsmenge
  from pumpen.historisch_basis
  group by Jahr, Pumpentyp
  order by Pumpentyp, Jahr;
quit;

/* 3. Trendvisualisierung */
proc sgplot data=pumpen.historisch_aggregiert;
  series x=Jahr y=Verkaufsmenge / group=Pumpentyp;
  title "Verkaufsentwicklung je Pumpentyp (2000–2017)";
  yaxis label="Verkaufsmenge";
  xaxis label="Jahr";
run;

/* 4. Gleitender 3-Jahres-Mittelwert */
proc sort data=pumpen.historisch_aggregiert out=pumpen.hist_sorted;
  by Pumpentyp Jahr;
run;

proc expand data=pumpen.hist_sorted out=pumpen.hist_ma method=none;
  by Pumpentyp;
  id Jahr;
  convert Verkaufsmenge = MA3_Verkaufsmenge / transformout=(movave 3);
run;

proc sgplot data=pumpen.hist_ma;
  series x=Jahr y=Verkaufsmenge / group=Pumpentyp lineattrs=(pattern=solid);
  series x=Jahr y=MA3_Verkaufsmenge / group=Pumpentyp lineattrs=(pattern=shortdash);
  title "Geglättete Verkaufsentwicklung je Pumpentyp";
  yaxis label="Verkaufsmenge";
run;

/* 5. Top 3 Pumpentypen je Jahr (ohne SQL-RANK-Funktion) */
proc sort data=pumpen.historisch_aggregiert out=pumpen.sorted_ranking;
  by Jahr descending Verkaufsmenge;
run;

data pumpen.top3_pumpen;
  set pumpen.sorted_ranking;
  by Jahr;
  retain Rang;
  
  if first.Jahr then Rang = 1;
  else Rang + 1;

  if Rang <= 3;
run;

proc print data=pumpen.top3_pumpen;
  title "Top 3 Pumpentypen je Jahr nach Verkaufsmenge";
run;