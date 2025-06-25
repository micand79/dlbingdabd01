/* Teil a) Import und Verarbeitung von Daten
Schritt 06: Bereinige Tabelle Lager */

proc sql;
    create table pumpy.standard_lager_clean as
    select 
        coalesce(m.Standort_Gereinigt, l.Standort) as Standort length=30,
        l.Datum,
        l.Pumpentyp,
        l.Quelle,
        l.Kennzahl,
        l.Wert
    from pumpy.standard_lager l
    left join pumpy.mapping_standorte m
    on strip(upcase(l.Standort)) = strip(upcase(m.Standort_Original));
quit;