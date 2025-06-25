/* Teil d) Daten Export

Schritt 01: Daten Export Funktion Microsoft Word Dokumente */

/* 1. Daten Export Macro */
%macro export_to_rtf(schritt, datei, titel);
    ods rtf file="/home/u64226650/DLBINGDABD01/rtf/&schritt._export.rtf" style=journal;
    title "&titel";
    %include "/home/u64226650/DLBINGDABD01/&datei..sas";
    ods rtf close;
%mend;

/* 2. Export-Liste */
%export_to_rtf(teilA_Schritt_02_datenSichtenUndVorbereiten,
               teilA_Schritt_02_datenSichtenUndVorbereiten,
               Teil A – Schritt 02: Datensichten und Vorbereitung);

%export_to_rtf(teilB_Schritt_01_produktionsvolumenUndJoinAufbauen,
               teilB_Schritt_01_produktionsvolumenUndJoinAufbauen,
               Teil B – Schritt 01: Produktionsvolumen & Join aufbauen);

%export_to_rtf(teilB_Schritt_02_bestandsmengeJePumpentypUndStandortClustern,
               teilB_Schritt_02_bestandsmengeJePumpentypUndStandortClustern,
               Teil B – Schritt 02: Bestandsmenge je Pumpentyp & Standort clustern);

%export_to_rtf(teilB_Schritt_03_analyseÜberPumpentypUndWerk,
               teilB_Schritt_03_analyseÜberPumpentypUndWerk,
               Teil B – Schritt 03: Analyse über Pumpentyp & Werk);

%export_to_rtf(teilB_Schritt_04_teil1QualitätsverbesserungProduktion,
               teilB_Schritt_04_teil1QualitätsverbesserungProduktion,
               Teil B – Schritt 04: Qualitätsverbesserung (Produktion));

%export_to_rtf(teilB_Schritt_05_teil2KundenUndMarktsegmentierungVertrieb,
               teilB_Schritt_05_teil2KundenUndMarktsegmentierungVertrieb,
               Teil B – Schritt 05: Marktsegmentierung (Vertrieb));

%export_to_rtf(teilB_Schritt_06_teil3EffizienzsteigerungWartungUndService,
               teilB_Schritt_06_teil3EffizienzsteigerungWartungUndService,
               Teil B – Schritt 06: Effizienzsteigerung (Wartung));

%export_to_rtf(teilB_Schritt_07_teil4FrüherkennungVonFehlentwicklungenProduktion,
               teilB_Schritt_07_teil4FrüherkennungVonFehlentwicklungenProduktion,
               Teil B – Schritt 07: Früherkennung von Fehlentwicklungen (Produktion));

%export_to_rtf(teilB_Schritt_08_teil5ProduktentwicklungUndInnovationProduktion,
               teilB_Schritt_08_teil5ProduktentwicklungUndInnovationProduktion,
               Teil B – Schritt 08: Produktentwicklung & Innovation);

%export_to_rtf(teilC_Schritt_01_Produktionsgrafiken,
               teilC_Schritt_01_Produktionsgrafiken,
               Teil C – Schritt 01: Produktionsgrafiken);

%export_to_rtf(teilC_Schritt_02_ClusterPlotVertrieb,
               teilC_Schritt_02_ClusterPlotVertrieb,
               Teil C – Schritt 02: Cluster Vertrieb);

%export_to_rtf(teilC_Schritt_03_Wartungsgrafiken,
               teilC_Schritt_03_Wartungsgrafiken,
               Teil C – Schritt 03: Wartungsgrafiken);

%export_to_rtf(teilC_Schritt_04_AusreißerVisualisierung,
               teilC_Schritt_04_AusreißerVisualisierung,
               Teil C – Schritt 04: Ausreißer-Visualisierung);

%export_to_rtf(teilC_Schritt_05_VerkaufsentwicklungTrendplotsHistorischerDaten,
               teilC_Schritt_05_VerkaufsentwicklungTrendplotsHistorischerDaten,
               Teil C – Schritt 05: Verkaufsentwicklung historischer Daten);

%export_to_rtf(teilC_Schritt_06_FrüherkennungDifferenzgrafik,
               teilC_Schritt_06_FrüherkennungDifferenzgrafik,
               Teil C – Schritt 06: Differenzgrafik Früherkennung);

%export_to_rtf(teilC_Schritt_07_ClusterAnalyseWartung,
               teilC_Schritt_07_ClusterAnalyseWartung,
               Teil C – Schritt 07: Wartung Clusteranalyse);