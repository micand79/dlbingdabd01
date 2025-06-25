/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse
Schritt 01: Produktionsvolumen & Join aufbauen

Ziel: Über- oder Unterdeckung erkennen --> Produktionsstrategie optimieren

Interpretation:
- Positive Differenz = Mehr Lagerbestand als Produktion (Überstand?)
- Negative Differenz = Lager kleiner als Produktionsmenge (möglicher Engpass?)
- Ist gruppiert nach Pumpentyp, damit die Unterschiede pro Baureihe erkennbar sind */

/* 1. Produktionsvolumen je Pumpentyp & Standort */
proc sql;
	create table pumpen.produktionsvolumen as
	select
		Standort,
		Pumpentyp,
		sum(Wert) as Produktionsmenge
	from pumpy.standard_produktion_clean
	where Kennzahl = "Stueckzahl"
	group by Standort, Pumpentyp;
quit;

/* 2. Lagerbestand je Pumpentyp & Standort */
proc sql;
  	create table pumpy.lagerbestand as
  	select
    	Standort,
    	Pumpentyp,
    	sum(Wert) as Lagerbestand
  	from pumpy.standard_lager_clean
  	where Kennzahl = "Bestandsmenge"
  	group by Standort, Pumpentyp;
quit;

/* 3. Lager vs. Produktion: Differenz berechnen */
proc sql;
  create table pumpen.lager_vs_produktionsmenge as
  select
    l.Standort,
    l.Pumpentyp,
    l.Lagerbestand,
    p.Produktionsmenge,
    (l.Lagerbestand - p.Produktionsmenge) as Differenz
  from pumpy.lagerbestand l
  left join pumpen.produktionsvolumen p
    on strip(upcase(l.Pumpentyp)) = strip(upcase(p.Pumpentyp))
   and strip(upcase(l.Standort)) = strip(upcase(p.Standort));
quit;

proc print data=pumpen.lager_vs_produktionsmenge;
	where Differenz ne .;
run;

/* 4. Visualisierung der Differenz */
proc sgplot data=pumpen.lager_vs_produktionsmenge;
    where Differenz ne .;
    
    vbar Standort / 
    	response=Differenz 
    	group=Pumpentyp 
    	groupdisplay=cluster
    	datalabel
    	datalabelattrs=(size=8)
    	barwidth=0.6;
    	
    yaxis label="Differenz Lager - Produktion";
    xaxis label="Standort";
    title "Lager vs. Produktionsmenge pro Standort und Pumpentyp";
run;