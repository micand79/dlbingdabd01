/* Teil a) Import und Verarbeitung von Daten
Schritt 03: Mapping-Tabelle aufbauen */

data pumpy.mapping_standorte;
    length Standort_Original $30 Standort_Gereinigt $30;
    infile datalines dsd;
    input Standort_Original :$30. Standort_Gereinigt :$30.;

datalines;
Lager Nord,Werk B
Lager Süd,Werk C
Lager West,Werk D
Zentrallager,Werk A
Werk_Mitte,Werk_Mitte
Werk A,Werk A
Werk B,Werk B
Werk C,Werk C
Werk D,Werk D
unbekannt,Werk_Unbekannt
;
run;