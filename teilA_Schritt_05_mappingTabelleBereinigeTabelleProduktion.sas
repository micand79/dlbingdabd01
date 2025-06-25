/* Teil a) Import und Verarbeitung von Daten
Schritt 05: Bereinige Tabelle Produktion */

proc sql;
    create table pumpy.standard_produktion_clean as
    select 
        coalesce(m.Standort_Gereinigt, p.Standort) as Standort length=30,
        p.Datum,
        p.Pumpentyp,
        p.Quelle,
        p.Kennzahl,
        p.Wert
    from pumpy.standard_produktion p
    left join pumpy.mapping_standorte m
    on strip(upcase(p.Standort)) = strip(upcase(m.Standort_Original));
quit;