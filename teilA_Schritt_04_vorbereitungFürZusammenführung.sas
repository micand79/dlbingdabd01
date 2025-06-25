/* Teil a) Import und Verarbeitung von Daten
Schritt 04: Vorbereitung für Zusammenführung */

/* 1. Historische Daten vorbereiten */
data pumpy.standard_historisch;
	 set pumpy.historiedaten;
	
	 length Wert_anzeige $40; /* ausreichend groß für formatierte Eurowerte */
	
	 Quelle = "Historisch";
	 Kennzahl = "Kennzahl_Wert";
	 Wert = Kennzahl_Wert;
	
	 /* explizites Format für numerische Spalte */
	 format Wert commax20.2;
	
	 /* Euro-Format mit deutschen Komma */
	 Wert_anzeige = catx(' ', put(Wert, commax20.2), " €"); /* Euro anhängen */
	
	 keep Datum Pumpentyp Standort Quelle Kennzahl Wert Wert_anzeige;
	 format Datum ddmmyy10.;
run;

data pumpy.standard_historisch_final;
	 
	 length Datum 8 Pumpentyp $30 Standort $30 Quelle $20 Kennzahl $30 Wert 8 Wert_anzeige $40;
	
	 set pumpy.standard_historisch;
	
	 format Datum ddmmyy10.;
run;

/* 2. Produktionsdaten */
data pumpy.standard_produktion;
	 length Produktionsdatum 8 Pumpentyp $30 Quelle $20 Kennzahl $30 Wert 8 Standort $30;	
	 set pumpy.produktionsdaten;
	 
	 Quelle = "Produktion";
	
	 /* Stueckzahl */
	 Kennzahl = "Stueckzahl";
	 Wert = Stueckzahl;
	 output;
	
	 /* Ausschuss */
	 Kennzahl = "Ausschuss_Fehlproduktion";
	 Wert = Ausschuss_Fehlproduktion;
	 output;
	
	 rename Produktionsdatum=Datum;
	 keep Produktionsdatum Pumpentyp Quelle Kennzahl Wert Standort;
run;

/* 3. Lagerdaten */
data pumpy.standard_lager;
	 length Letzte_Bestandspruefung 8 Pumpentyp $30 Quelle $20 Kennzahl $30 Wert 8 Standort $30;
	 set pumpy.lagerdaten(rename=(Lagerort=Standort));
	 
	 Quelle = "Lager";
	 Kennzahl = "Bestandsmenge";
	 Wert = Bestandsmenge;
	 
	 rename Letzte_Bestandspruefung=Datum;
	 keep Letzte_Bestandspruefung Pumpentyp Quelle Kennzahl Wert Standort;
run;

/* 4. Vertriebsdaten */
data pumpy.standard_vertrieb;
	 set pumpy.vertriebsdaten;
	 
	 Quelle = "Vertrieb";
	
	 length Wert_anzeige $40; /* genug Platz für große Werte */
	
	 /* Stueckzahl - normaler numerischer Wert */
	 Kennzahl = "Gelieferte_Stueckzahl";
	 Wert = Gelieferte_Stueckzahl;
	 Wert_anzeige = put(Wert, comma15.); /* Als Text mit Punkt oder Komma */
	 output;
	
	 /* Gesamtpreis - mit Euro, nur wenn vorhanden */
	 if not missing(Gesamtpreis) then do;
		Kennzahl = "Gesamtpreis";
		Wert = Gesamtpreis;
		Wert_anzeige = catx(' ', put(Wert, commax20.2), " €"); /* Euro anhängen */
		output;
	 end;
	
	 /* Variablen auswählen und umbenennen */
	 keep Verkaufsdatum Pumpentyp Region Quelle Kennzahl Wert Wert_anzeige;
	 rename Verkaufsdatum=Datum Region=Standort;
run;

data pumpy.standard_vertrieb_final;
	 
	 length Datum 8 Pumpentyp $30 Standort $30 Quelle $20 Kennzahl $30 Wert 8 Wert_anzeige $40;
	
	 set pumpy.standard_vertrieb;
	
	 format Datum ddmmyy10.;
run;

/* 5. Wartungsdaten */
data pumpy.standard_wartung;
	 set pumpy.wartungsdaten;
	 
	 Standort = "unbekannt"; /* Standort optional oder später über Mapping */
	 Quelle = "Wartung";
	 Kennzahl = "Dauer_Stunden";
	 Wert = Dauer_Stunden;
	 format Wert commax8.1;
	 Datum = Wartungsdatum;
	 format Datum ddmmyy10.;
	 
	 keep Datum Pumpe_ID Quelle Kennzahl Wert;
	 rename Pumpe_ID=Pumpentyp; 
run;

/* 6. Alles zusammenführen */
data pumpy.gesamtdaten;
	 set
	 	pumpy.standard_historisch_final
	 	pumpy.standard_produktion
	 	pumpy.standard_lager
	 	pumpy.standard_vertrieb_final
	 	pumpy.standard_wartung;
	
	 length Wert_anzeige $40;
	
	 select (Kennzahl);
		 when ("Gesamtpreis", "Kennzahl_Wert")
			 Wert_anzeige = catx(' ', put(Wert, commax20.2), " €");
			
		 when ("Dauer_Stunden")
			 Wert_anzeige = catx(' ', put(Wert, commax8.1), " Std.");
			
		 when ("Gelieferte_Stueckzahl", "Stueckzahl", "Bestandsmenge", "Ausschuss_Fehlproduktion")
			 Wert_anzeige = put(Wert, commax10.);
			
		 otherwise
			 Wert_anzeige = "---";
	 end;
run;