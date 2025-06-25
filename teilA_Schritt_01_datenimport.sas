/* Teil a) Import und Verarbeitung von Daten
Schritt 01: Import der Excel-Dateien in SAS Studio */

libname lager XLSX "/home/u64226650/DLBINGDABD01/data/5000_Lagerdaten.xlsx";
libname produkt XLSX "/home/u64226650/DLBINGDABD01/data/5000_Produktionsdaten.xlsx";
libname vertrieb XLSX "/home/u64226650/DLBINGDABD01/data/5000_Vertriebsdaten.xlsx";
libname wartung XLSX "/home/u64226650/DLBINGDABD01/data/5000_Wartungsdaten.xlsx";
libname historie XLSX "/home/u64226650/DLBINGDABD01/data/15000_Historische_Daten_Pumpenhersteller_2000_2017.xlsx";

/* 1. Lagerdaten importieren */
proc import datafile="/home/u64226650/DLBINGDABD01/data/5000_Lagerdaten.xlsx"
	out=pumpy.lagerdaten
	dbms=xlsx
	replace;
	getnames=yes;
	options validvarname=v7;
	options msglevel=i;
run;

/* 2. Produktionsdaten importieren */
proc import datafile="/home/u64226650/DLBINGDABD01/data/5000_Produktionsdaten.xlsx"
	out=pumpy.produktionsdaten
	dbms=xlsx
	replace;
	getnames=yes;
	options validvarname=v7;
	options msglevel=i;
run;

/* 3. Vertriebsdaten importieren */
proc import datafile="/home/u64226650/DLBINGDABD01/data/5000_Vertriebsdaten.xlsx"
	out=pumpy.vertriebsdaten
	dbms=xlsx
	replace;
	getnames=yes;
	options validvarname=v7;
	options msglevel=i;
run;

/* 4. Wartungsdaten importieren */
proc import datafile="/home/u64226650/DLBINGDABD01/data/5000_Wartungsdaten.xlsx"
	out=pumpy.wartungsdaten
	dbms=xlsx
	replace;
	getnames=yes;
	options validvarname=v7;
	options msglevel=i;
run;

/* 5. Historische Daten importieren */
proc import datafile="/home/u64226650/DLBINGDABD01/data/15000_Historische_Daten_Pumpenhersteller_2000_2017.xlsx"
	out=pumpy.historiedaten
	dbms=xlsx
	replace;
	getnames=yes;
	options validvarname=v7;
	options msglevel=i;
run;