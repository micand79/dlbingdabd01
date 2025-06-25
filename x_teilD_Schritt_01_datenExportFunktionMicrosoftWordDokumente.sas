/* Teil d) Daten Export

Schritt 01: Daten Export Funktion Microsoft Word Dokumente */

/* 1. ODS RTF starten */
ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilA_Schritt_02_datenSichtenUndVorbereiten_export.rtf" style=journal;
title "Teil A – Schritt 02: Datensichten und Vorbereitung";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_01_produktionsvolumenUndJoinAufbauen_export.rtf" style=journal;
title "Teil B – Schritt 01: Produktionsvolumen & Join aufbauen";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_02_bestandsmengeJePumpentypUndStandortClustern_export.rtf" style=journal;
title "Teil B – Schritt 02: Bestandsmenge je Pumpentyp und Standort clustern";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_03_analyseÜberPumpentypUndWerk_export.rtf" style=journal;
title "Teil B – Schritt 03: Aggregation von Produktion und Lagerdaten über Pumpentyp + Werk";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_04_teil1QualitätsverbesserungProduktion_export.rtf" style=journal;
title "Teil B – Schritt 04: Teil 1 - Qualitätsverbesserung (Produktion)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_05_teil2KundenUndMarktsegmentierungVertrieb_export.rtf" style=journal;
title "Teil B – Schritt 05: Teil 2 - Kunden-/Marktsegmentierung (Vertrieb)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_06_teil3EffizienzsteigerungWartungUndService_export.rtf" style=journal;
title "Teil B – Schritt 06: Teil 3 - Effizienzsteigerung (Wartung & Service)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_07_teil4FrüherkennungVonFehlentwicklungenProduktion_export.rtf" style=journal;
title "Teil B – Schritt 07: Teil 4 - Früherkennung von Fehlentwicklungen (Produktion)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilB_Schritt_08_teil5ProduktentwicklungUndInnovationProduktion_export.rtf" style=journal;
title "Teil B – Schritt 08: Teil 5 - Produktentwicklung & Innovation (Produktion)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_01_Produktionsgrafiken_export.rtf" style=journal;
title "Teil C – Schritt 01: Produktionsgrafiken";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_02_ClusterPlotVertrieb_export.rtf" style=journal;
title "Teil C – Schritt 02: Vetriebsdaten - Regionale & preisliche Verteilung";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_03_Wartungsgrafiken_export.rtf" style=journal;
title "Teil C – Schritt 03: Wartungsgrafiken";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_04_AusreißerVisualisierung_export.rtf" style=journal;
title "Teil C – Schritt 04: Ausreißer-Visualisierung";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_05_VerkaufsentwicklungTrendplotsHistorischerDaten_export.rtf" style=journal;
title "Teil C – Schritt 05: Verkaufsentwicklung (Trendplots historischer Daten)";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_06_FrüherkennungDifferenzgrafik_export.rtf" style=journal;
title "Teil C – Schritt 06: Früherkennung - Differenzgrafik";

ods rtf file="/home/u64226650/DLBINGDABD01/rtf/teilC_Schritt_07_ClusterAnalyseWartung_export.rtf" style=journal;
title "Teil C – Schritt 07: Clusteranalyse Wartung";

/* 2. Include der Original-SAS-Dateien */
%include "/home/u64226650/DLBINGDABD01/teilA_Schritt_02_datenSichtenUndVorbereiten.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_01_produktionsvolumenUndJoinAufbauen.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_02_bestandsmengeJePumpentypUndStandortClustern.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_03_analyseÜberPumpentypUndWerk.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_04_teil1QualitätsverbesserungProduktion.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_05_teil2KundenUndMarktsegmentierungVertrieb.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_06_teil3EffizienzsteigerungWartungUndService.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_07_teil4FrüherkennungVonFehlentwicklungenProduktion.sas";

%include "/home/u64226650/DLBINGDABD01/teilB_Schritt_08_teil5ProduktentwicklungUndInnovationProduktion.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_01_Produktionsgrafiken.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_02_ClusterPlotVertrieb.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_03_Wartungsgrafiken.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_04_AusreißerVisualisierung.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_05_VerkaufsentwicklungTrendplotsHistorischerDaten.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_06_FrüherkennungDifferenzgrafik.sas";

%include "/home/u64226650/DLBINGDABD01/teilC_Schritt_07_ClusterAnalyseWartung.sas";

/* 3. ODS RTF schließen */
ods rtf close;