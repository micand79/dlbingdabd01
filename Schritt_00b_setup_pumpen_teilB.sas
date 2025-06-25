%let pumpe=/home/u64226650/DLBINGDABD01/teilB;

libname PUMPEN "&pumpe";

options fmtsearch=(pumpen.myfmts);

proc format library=pumpen.myfmts;
run;

/* Macro Variablen zur Verwendung in den einzelnen Statistik Berechnungen */

%let standLager=Pumpentyp Standort Quelle Kennzahl Wert Datum;

%let standProduktion=Datum Pumpentyp Kennzahl Quelle Wert;

%let standVertriebFinal=Datum Pumpentyp Standort Quelle Kennzahl Wert Wert_anzeige;

%let standWartung=Pumpentyp Quelle Kennzahl Wert Datum;

%let standHistorieFinal=Datum Pumpentyp Standort Quelle Kennzahl Wert Wert_anzeige;

%let gesamt=Kennzahl Quelle Standort Datum Pumpentyp Wert Wert_anzeige;