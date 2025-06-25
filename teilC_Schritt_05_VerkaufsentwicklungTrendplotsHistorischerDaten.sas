/* Teil c) Grafiken

Schritt 05: Verkaufsentwicklung (Trendplots historischer Daten)

Ziel:
- Visualisierung der langfristigen Verkaufsentwicklung der Pumpentypen --> 
Trenderkennung, zyklisches Verhalten, Langzeitanalyse für Innovation und Strategie

Inhalt:
1. Trendlinie
	- Verkaufswert je Pumpentyp über Zeit (Datum)
2. Gleitender Mittelwert
	- 3-Jahres-Glättung für klarere Trendverläufe */

/* 1. Jahr aus Datum extrahieren */
data pumpx.hist_basis;
  set pumpy.standard_historisch_final;
  Jahr = year(Datum);
run;

/* 2. Aggregation je Jahr und Pumpentyp */
proc sql;
  create table pumpx.hist_aggregiert as
  select Jahr, Pumpentyp, sum(Wert) as Verkaufsmenge
  from pumpx.hist_basis
  group by Jahr, Pumpentyp
  order by Pumpentyp, Jahr;
quit;

/* 3. Gleitender 3-Jahres-Mittelwert berechnen */
proc sort data=pumpx.hist_aggregiert out=pumpx.sorted_hist;
  by Pumpentyp Jahr;
run;

proc expand data=pumpx.sorted_hist out=pumpx.hist_ma method=none;
  by Pumpentyp;
  id Jahr;
  convert Verkaufsmenge = MA3_Verkaufsmenge / transformout=(movave 3);
run;

/* 4. Visualisierung: Original + Glättung */
proc sgplot data=pumpx.hist_ma;
  series x=Jahr y=Verkaufsmenge / group=Pumpentyp lineattrs=(pattern=solid);
  series x=Jahr y=MA3_Verkaufsmenge / group=Pumpentyp lineattrs=(pattern=shortdash);
  title "Verkaufsentwicklung & Trend (Pumpentypen)";
  xaxis label="Jahr";
  yaxis label="Verkaufsmenge";
run;