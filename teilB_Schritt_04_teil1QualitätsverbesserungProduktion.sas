/* Teil b) Analyse: Ausreißererkennung und Clusteranalyse

Schritt 04: Teil 1 - Qualitätsverbesserung (Produktion)

Ziel: 
- Ausreißer erkennen, die auf Produktionsprobleme oder Sondereffekte hinweisen
- Ausreißer finden in den Produktionsmengen je Pumpentyp und Werk - z.B. extrem hohe oder niedrige Werte 
	--> möglicher Hinweis auf:
	- Maschinenstillstand
	- Sondereinsatz
	- Datenerfassungsfehler

Methode:
- Deskriptive Statistik mit proc univatiate je Gruppe
- Boxplot mit proc sgplot zur visuellen Erkennung von Ausreißern */

/* 1. Filter auf Produktionsmenge */
data pumpen.produktion_stueckzahl;
  set pumpy.standard_produktion_clean;
  where Kennzahl = "Stueckzahl";
run;

/* 2. Boxplot nach Pumpentyp + Werk */
proc sgplot data=pumpen.produktion_stueckzahl;
  vbox Wert / category=Pumpentyp group=Standort;
  title "Boxplot der Produktionsmenge je Pumpentyp und Werk";
  yaxis label="Produktionsmenge";
run;

/* 3. Univariate Analyse zur Ausreißererkennung je Pumpentyp */
proc sort data=pumpen.produktion_stueckzahl;
  by Pumpentyp;
run;

proc univariate data=pumpen.produktion_stueckzahl noprint;
  by Pumpentyp;
  var Wert;
  output out=pumpen.ausreisser_diagnose
    q1=Q1 q3=Q3
    pctlpre=P_ pctlpts=1 5 95 99
    mean=Mean std=Stddev
    min=Min max=Max;
run;

/* 4. Ausgabe zur Kontrolle */
proc print data=pumpen.ausreisser_diagnose;
  title "Statistische Kenngrößen zur Produktionsmenge je Pumpentyp";
run;