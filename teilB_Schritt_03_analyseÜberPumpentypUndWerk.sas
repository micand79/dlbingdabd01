/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse
Schritt 03: Aggregation von Produktion und Lagerdaten über Pumpentyp + Werk

Ziel:
- Welche Werke produzieren welche Pumpentypen in welchem Umfang - und wie stehen diese Mengen im Verhältnis zu den Lagerbeständen?
1. Vergleich der Produktionsleistung pro Werk und Pumpentyp
	- Wer produziert am meisten Kolbenpumpen?
	- Welche Werke sind auf welchen Pumpentyp spezialisiert?
2. Beziehung zwischen Produktion und Lagerbestand
	- Wird zu viel produziert und wenig eingelagert?
	- Gibt es Engpässe (hohe Produktion, aber leeres Lager)?
	- Oder Überproduktion (volle Lager, geringe Produktion)?
3. Identifikation von logistischen Auffälligkeiten
	- z.B. Produktion in Werk A, aber Lager in Werk B

Was die beiden Plots aussagen:
1. vbar (Balkendiagramm):
	- Ziel: Produktionsfokus sichtbar machen

2. scatter (Streudiagramm):
	- Zeigt das Verhältnis von Produktion vs. Lagerbestand, gruppiert nach Pumpentyp
	- Ziel: Beziehung erkennen --> Über-/Unterdeckung, logistische Balance

Fazit: Diese zentrale logistikstrategische Analyse beantwortet: "Wo wird was produziert - und wo landet es?" */

/* 1. Aggregiere Produktionsmenge pro Pumpentyp und Werk */
proc sql;
  create table pumpen.prod_agg as
  select Standort, Pumpentyp, sum(Wert) as Produktionsmenge
  from pumpy.standard_produktion_clean
  where not missing(Standort)
    and Kennzahl = "Stueckzahl"
  group by Standort, Pumpentyp;
quit;

/* 2. Aggregiere Lagerbestand pro Pumpentyp und Werk */
proc sql;
  create table pumpen.lager_agg as
  select Standort, Pumpentyp, sum(Wert) as Lagerbestand
  from pumpy.standard_lager_clean
  where not missing(Standort)
    and Kennzahl = "Bestandsmenge"
  group by Standort, Pumpentyp;
quit;

/* 3. Join der beiden aggregierten Tabellen */
proc sql;
  create table pumpen.pumpe_werk_analyse as
  select 
    p.Standort as Werk,
    p.Pumpentyp,
    p.Produktionsmenge,
    l.Lagerbestand
  from pumpen.prod_agg p
  left join pumpen.lager_agg l
    on strip(upcase(p.Pumpentyp)) = strip(upcase(l.Pumpentyp))
   and strip(upcase(p.Standort)) = strip(upcase(l.Standort));
quit;

/* 4. Visualisierung Produktionsmenge je Pumpentyp und Werk */
proc sgplot data=pumpen.pumpe_werk_analyse;
  vbar Werk / response=Produktionsmenge group=Pumpentyp groupdisplay=cluster datalabel;
  yaxis label="Produktionsmenge";
  xaxis label="Werk";
  title "Produktionsmenge je Pumpentyp und Werk";
run;

/* 5. Produktionsmenge vs. Lagerbestand Scatterplot */
proc sgplot data=pumpen.pumpe_werk_analyse;
  scatter x=Produktionsmenge y=Lagerbestand / group=Pumpentyp datalabel=Werk;
  xaxis label="Produktionsmenge";
  yaxis label="Lagerbestand";
  title "Verhältnis von Produktionsmenge zu Lagerbestand (nach Pumpentyp und Werk)";
run;