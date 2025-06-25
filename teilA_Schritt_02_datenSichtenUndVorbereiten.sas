/* Teil a) Import und Verarbeitung von Daten
Schritt 02: Daten sichten und vorbereiten */

/* 1. Datenüberblick verschaffen */
proc contents data=pumpy.lagerdaten;
run;

proc contents data=pumpy.produktionsdaten;
run;

proc contents data=pumpy.vertriebsdaten;
run;

proc contents data=pumpy.wartungsdaten;
run;

proc contents data=pumpy.historiedaten;
run;

/* 2. Datumsformate prüfen und konvertieren */
data pumpy.lagerdaten;
	set pumpy.lagerdaten;
	format Letzte_Bestandspruefung ddmmyy10.;
run;

data pumpy.produktionsdaten;
	set pumpy.produktionsdaten;
	format Produktionsdatum ddmmyy10.;
run;

data pumpy.vertriebsdaten;
	set pumpy.vertriebsdaten;
	format Verkaufsdatum ddmmyy10.;
run;

data pumpy.wartungsdaten;
	set pumpy.wartungsdaten;
	format Wartungsdatum ddmmyy10.;
	format Dauer_Stunden commax8.1;
run;

data pumpy.historiedaten;
	set pumpy.historiedaten;
	format Datum ddmmyy10.;
run;