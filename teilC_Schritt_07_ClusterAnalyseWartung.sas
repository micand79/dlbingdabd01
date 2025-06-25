/* Teil c) Grafiken

Schritt 07: Clusteranalyse Wartung

Ziel:
- Visualisierung der Ergebnisse aus der Clusteranalyse im Bereich Wartung & Service
--> Erkennung von Fehlerprofilen, die sich in Dauer und Struktur unterscheiden
--> Unterstützt Technikerzuteilung, Ressourcenplanung und strategische Prozessoptimierung

Inhalt:
1. Scatterplot
	- Dauer_Stunden vs. Distance, farbig nach Cluster
		- Streuung und Clustertrennung sichtbar
2. Boxplot
	- Dauer_Stunden je Cluster
		- Dauervergleich je Fehlerprofil
3. Balkendiagramm
	- Wartungstyp je Cluster
		- Verteilung von Fehlerarten */

/* 1. Clusterdaten übernehmen */
data pumpx.wartung_clusterplot;
  set pumpen.wartung_cluster;
run;

/* 2. Scatterplot: Dauer vs. Distanz, gruppiert nach Cluster */
proc sgplot data=pumpx.wartung_clusterplot;
  scatter x=Dauer_Stunden y=Distance / group=Cluster;
  title "Wartung: Dauer vs. Distanz zum Cluster-Zentrum";
  xaxis label="Dauer (Stunden)";
  yaxis label="Distanz zum Cluster-Zentrum";
run;

/* 3. Boxplot: Dauer_Stunden je Cluster */
proc sgplot data=pumpx.wartung_clusterplot;
  vbox Dauer_Stunden / category=Cluster;
  title "Verteilung der Wartungsdauer je Cluster";
  yaxis label="Dauer in Stunden";
run;

/* 4. Balkendiagramm: Wartungstypen je Cluster */
proc sql;
  create table pumpx.wartungstypen_cluster as
  select Cluster, Wartungstyp, count(*) as Anzahl
  from pumpx.wartung_clusterplot
  group by Cluster, Wartungstyp;
quit;

proc sgplot data=pumpx.wartungstypen_cluster;
  vbar Wartungstyp / response=Anzahl group=Cluster groupdisplay=cluster;
  title "Wartungstypen je Cluster";
  yaxis label="Häufigkeit";
run;