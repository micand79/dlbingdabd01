/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse

Schritt 06: Teil 3 - Effizienzsteigerung (Wartung & Service)

Ziel:
- Wartungstyp-Analyse
- Wartungsdauer je Typ
- Intervallanalyse nach Wartungsdatum
- Clustering auf Basis von Dauer_Stunden
- Top-Wartungstypen je Techniker

/* 1. Häufigkeit je Wartungstyp */
proc freq data=pumpy.wartungsdaten;
  tables Wartungstyp / nocum nopercent;
  title "Anzahl Wartungsvorgänge je Wartungstyp";
run;

/* 2. Durchschnittliche Dauer je Wartungstyp */
proc means data=pumpy.wartungsdaten mean stddev maxdec=1;
  class Wartungstyp;
  var Dauer_Stunden;
  title "Durchschnittliche Wartungsdauer je Wartungstyp";
run;

/* 3. Visualisierung: Dauer pro Wartungstyp */
proc sgplot data=pumpy.wartungsdaten;
  vbox Dauer_Stunden / category=Wartungstyp;
  yaxis label="Dauer (Stunden)";
  title "Verteilung der Wartungsdauer je Wartungstyp";
run;

/* 4. Intervallanalyse: Tage zwischen Wartungen pro Pumpe */
proc sort data=pumpy.wartungsdaten;
  by Pumpe_ID Wartungsdatum;
run;

data pumpen.wartung_mit_intervall;
  set pumpy.wartungsdaten;
  by Pumpe_ID;
  format Letztes_Datum date9.;
  retain Letztes_Datum;

  if first.Pumpe_ID then do;
    Intervall_Tage = .;
    Letztes_Datum = .;
  end;
  else do;
    Intervall_Tage = Wartungsdatum - Letztes_Datum;
  end;

  Letztes_Datum = Wartungsdatum;
run;

proc sgplot data=pumpen.wartung_mit_intervall;
  histogram Intervall_Tage;
  density Intervall_Tage;
  title "Verteilung der Tage zwischen Wartungen je Pumpe";
run;

/* 5. Clustering: Wartungsdauer */
proc fastclus data=pumpy.wartungsdaten maxclusters=3 out=pumpen.wartung_cluster;
  var Dauer_Stunden;
run;

/* Erzeuge laufende Nummer für stabilen X-Achsen-Plot */
data pumpen.wartung_cluster_plot;
  set pumpen.wartung_cluster;
  Laufnummer + 1;
run;

proc sgplot data=pumpen.wartung_cluster_plot;
  scatter x=Laufnummer y=Dauer_Stunden / group=Cluster;
  title "Clusteranalyse der Wartungsdauer (nach Stunden, X=Laufnummer)";
  yaxis label="Dauer (Stunden)";
  xaxis label="Laufende Beobachtungsnummer";
run;

/* 6. Top 3 Wartungstypen je Techniker */
proc sql;
  create table pumpen.top_wartungen as
  select Techniker, Wartungstyp, count(*) as Anzahl
  from pumpy.wartungsdaten
  group by Techniker, Wartungstyp
  order by Techniker, calculated Anzahl desc;
quit;

data pumpen.top3_wartungstypen;
  set pumpen.top_wartungen;
  by Techniker;
  if first.Techniker then Rang = 1;
  else Rang + 1;
  if Rang <= 3;
run;

proc print data=pumpen.top3_wartungstypen;
  title "Top 3 Wartungstypen pro Techniker";
run;