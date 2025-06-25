/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse

Schritt 05: Teil 2 - Kunden-/Marktsegmentierung (Vertrieb)

Ziel:
- Kundengruppen mit typischen Bestellverhalten finden z.B.:
	- Große Einzelbestellungen
	- Viele kleine Bestellungen mit niedrigem Preis
	- Hochwertkäufer aus den einzelnen Regionen
	
Methode:
- Clusteranalyse mit proc fastclus
- Vorverarbeitung mit proc standard oder proc princomp (für Hauptkomponenten)
- Visualisierung mit proc sgplot (Scatterplot oder Balken) */

/* 1. Import der Excel-Datei */
proc import datafile="/home/u64226650/DLBINGDABD01/data/5000_Vertriebsdaten.xlsx"
  out=pumpen.vertriebsdaten
  dbms=xlsx
  replace;
  getnames=yes;
run;

/* 2. Vorbereitung: Auswahl geeigneter Variablen */
data pumpen.vertrieb_clusterbasis;
  set pumpen.vertriebsdaten;
  /* Beispiel: Dummy-Codierung für Region */
  if Region = "Nord" then region_nord = 1; else region_nord = 0;
  if Region = "Süd" then region_sued = 1; else region_sued = 0;
  if Region = "West" then region_west = 1; else region_west = 0;
  if Region = "Ost" then region_ost = 1; else region_ost = 0;
  /* Umsatz und Auftragsfrequenz direkt übernehmen */
run;

/* 3. Clusteranalyse */
proc fastclus data=pumpen.vertrieb_clusterbasis maxclusters=4 out=pumpen.vertrieb_clusterergebnis;
  var Gelieferte_Stueckzahl Stueckpreis Gesamtpreis region_nord region_sued region_west region_ost;
run;

/* 4. Visualisierung der Cluster */
proc sgplot data=pumpen.vertrieb_clusterergebnis;
  scatter x=Stueckpreis y=Gesamtpreis / group=Cluster datalabel=Verkaufs_ID;
  title "Kundensegmentierung nach Stückpreis und Gesamtpreis";
  xaxis label="Stückpreis";
  yaxis label="Gesamtpreis";
run;

/* 5. Clusterbeschreibung je Cluster */
proc means data=pumpen.vertrieb_clusterergebnis n mean min max maxdec=1;
	class Cluster;
	var Gelieferte_Stueckzahl Stueckpreis Gesamtpreis;
run;