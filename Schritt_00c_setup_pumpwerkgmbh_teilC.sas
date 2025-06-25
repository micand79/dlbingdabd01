%let pumpwerkgmbh=/home/u64226650/DLBINGDABD01/teilC;

libname PUMPX "&pumpwerkgmbh";

options fmtsearch=(pumpx.myfmts);

proc format library=pumpx.myfmts;
run;

/* Macro Variablen zur Verwendung in den einzelnen Statistik Berechnungen */

%let lager=Lager_ID Pumpentyp Lagerort Bestandsmenge Letzte_Bestandspruefung;

%let produktion=Produktions_ID Produktionsdatum Pumpentyp Stueckzahl Ausschuss_Fehlproduktion Standort;

%let vertrieb=Verkaufs_ID Verkaufsdatum Pumpentyp Gelieferte_Stueckzahl Stueckpreis Gesamtpreis Region;

%let wartung=Wartungs_ID Pumpe_ID Wartungsdatum Wartungstyp Techniker Dauer_Stunden;

%let historie=Historie_ID Datum Pumpentyp Abteilung Standort Kennzahl_Wert;