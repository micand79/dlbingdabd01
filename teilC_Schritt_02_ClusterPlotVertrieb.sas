/* Teil c) Grafiken

Schritt 02: Vetriebsdaten - Regionale & preisliche Verteilung

Ziel:
- Analyse und Visualisierung von Verkaufsverhalten je Region und Preisstruktur

Inhalt:
1. Boxplot Gesamtpreis je Region
	- Verteilung der Auftragsvolumen pro Region
		- Vergleich der Umsatzhöhe
2. Histogramm Stueckpreis
	- Verteilung der Einzelpreise
		- Preisstruktur sichtbar machen
3. Balkendiagramm Gelieferte_Stueckzahl je Region
	- Menge nach Region
		- Absatzschwerpunkt regional erkennen */

/* 1. Quelle sichern in Teil-C-Library */
data pumpx.vertrieb_visualbasis;
  set pumpen.vertrieb_clusterbasis;
run;

/* 2. Boxplot: Gesamtpreis je Region */
proc sgplot data=pumpx.vertrieb_visualbasis;
  vbox Gesamtpreis / category=Region;
  title "Verteilung des Gesamtpreises je Region";
  yaxis label="Gesamtpreis (€)";
run;

/* 3. Histogramm: Stückpreis-Verteilung */
proc sgplot data=pumpx.vertrieb_visualbasis;
  histogram Stueckpreis;
  density Stueckpreis / type=kernel;
  title "Verteilung der Stückpreise im Vertrieb";
  xaxis label="Stückpreis (€)";
run;

/* 4. Balkendiagramm: Gelieferte Stückzahl je Region (aggregiert) */
proc sql;
  create table pumpx.region_absatz as
  select Region, sum(Gelieferte_Stueckzahl) as Gesamtmenge
  from pumpx.vertrieb_visualbasis
  group by Region;
quit;

proc sgplot data=pumpx.region_absatz;
  vbar Region / response=Gesamtmenge;
  title "Gelieferte Stückzahl je Region (aggregiert)";
  yaxis label="Gesamtmenge";
run;