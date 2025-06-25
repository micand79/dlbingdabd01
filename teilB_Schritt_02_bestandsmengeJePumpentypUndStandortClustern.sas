/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse
Schritt 02: Bestandsmenge je Pumpentyp und Standort clustern

Ziel:
- Unterschiedliche Lagerstrategien oder -verhalten zu erkennen
- Über- oder Unterdeckungstypen gruppieren
- Cluster für gezielte Maßnahmen (z. B. Umlagerung, Produktionsanpassung) zu definieren */

/* 1. Datenbasis vorbereiten */
proc sql;
  	create table pumpen.cluster_lagerbasis as
  	select
    	Standort,
    	Pumpentyp,
    	sum(Wert) as Bestandsmenge
  	from pumpy.standard_lager_clean
  	where Wert > 0
  	group by Standort, Pumpentyp;
quit;

/* 2. Clusteranalyse */
proc fastclus data=pumpen.cluster_lagerbasis
				maxclusters=4
				out=pumpen.cluster_lager_out
				outstat=pumpen.cluster_lager_stat
				distance
				maxiter=100;
	var Bestandsmenge;
run;

/* 3. Visualisierung der Cluster */
proc sgplot data=pumpen.cluster_lager_out;
	scatter x=Pumpentyp y=Bestandsmenge / group=Cluster markerattrs=(symbol=CircleFilled);
	title "Clusteranalyse der Bestandsmengen je Pumpentyp";
run;

/* 4. Tabelle mit Cluster-Zugehörigkeit */
proc print data=pumpen.cluster_lager_out (obs=10);
	var Standort Pumpentyp Bestandsmenge Cluster;
	title "Beispielhafte Cluster-Zuordnung (erste 10 Zeilen)";
run;

/* 5. Mittelwerte pro Cluster
Hiermit sieht man, wie hoch die typischen Bestände je Cluster liegen und ob es klare Unterschiede gibt. */
proc means data=pumpen.cluster_lager_out mean stddev min max maxdec=2;
	class Cluster;
	var Bestandsmenge;
	title "Mittelwerte der Bestandsmenge pro Cluster";
run;

/* 6. Häufigkeit der Pumpentypen pro Cluster */
proc freq data=pumpen.cluster_lager_out;
	tables Cluster*Pumpentyp / nopercent norow nocol;
	title "Häufigkeit der Pumpentypen pro Cluster";
run;

/* 7. Boxplot: Bestandsmenge je Cluster
Mit diesem Diagramm erkennt man Streuung, Median, Ausreißer - hilfreich für Clustervergleich */
proc sgplot data=pumpen.cluster_lager_out;
	vbox Bestandsmenge / category=Cluster;
	title "Boxplot der Bestandsmengen nach Cluster";
run;