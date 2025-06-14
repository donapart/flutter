Flutter AR-Mobilanwendung mit Edge-basierter Benutzeroberfläche
Projektübersicht
Entwicklung einer plattformübergreifenden (iOS und Android) Flutter-Anwendung mit AR-Funktionen, Echtzeit-Kamera-Feed und einem intuitiven Edge-basierten UI-System.

Kernfunktionen
Kamera- und AR-Integration
Live-Kamera-Feed läuft im Hintergrund
AR-Overlay-System
Echtzeit-Objekterkennung und Oberflächenerkennung
Integration mit Surreal DB
Geolokalisierungsverfolgung und Visualisierung
Edge-basiertes UI-System
Versteckte Menüfelder
Linker Rand : Navigationsmenü (Karte, Einstellungen, Dashboard)
Rechter Rand : Kontextmenü (Filter, Ebenen)
Unterer Rand : Informationsleiste / Statusanzeige
Oberer Rand : Titelleiste mit automatischer Vervollständigung der Menüadressen (z. B. „System:FreY“) und Navigationssteuerung
Alle Bedienfelder sind zunächst ausgeblendet und können wie folgt aktiviert werden:

Kantenberührungserkennung
Wischbewegungen
Objekterkennung und -detektion
Realobjekterkennung

Farb- und formbasierte Analyse
Warnschilderkennung (rote Objekte)
Vegetationserkennung (grüne Objekte)
Oberflächenerkennung
Scannen von Barcodes/QR-Codes mithilfe der nativen Browser-API
OCR (Texterkennung)

Implementierung der nativen Browser-Texterkennungs-API
Tesseract.js Fallback-Integration
Deutschsprachige Unterstützung
Echtzeit-Texterkennung (5-Sekunden-Intervalle)
Gesichtserkennung

Browsernative Gesichtserkennungs-API-Integration
Personenverfolgung mit Begrenzungsrahmen
Datenschutzorientierte lokale Verarbeitung
Steuerungsfunktionen
Individuelle Kippschalter für jede Erkennungsfunktion
Leistungsoptimierung durch selektive Feature-Aktivierung
Touch-optimierte mobile Benutzeroberfläche
Batteriesparende Erkennungsintervalle
Reaktionsschnelles AR-Overlay-System
Technische Voraussetzungen
Unterstützung mobiler Plattformen
iOS-Kompatibilität
Android-Kompatibilität
Überlegungen zur Leistung
Optimierung der Hintergrundkameraverarbeitung
Optimierung der Batterienutzung
Reibungslose, kantenbasierte UI-Interaktionen
Effizientes AR-Overlay-Rendering
Integrationsanforderungen
SurrealDB-Integration
Geolokalisierungsdienste
AR-Framework-Kompatibilität
Nativer API-Zugriff für verschiedene Erkennungsfunktionen
Entwicklungsrichtlinien
Implementieren Sie ein minimalistisches, intuitives UI-Design
Sorgen Sie für reibungslose Edge-basierte Interaktionen
Optimieren Sie den Akkuverbrauch für die kontinuierliche Nutzung der Kamera
Implementieren Sie datenschutzorientierte lokale Verarbeitung für sensible Funktionen
Sorgen Sie für ein responsives Design für verschiedene Bildschirmgrößen
Erhalten Sie die Leistung mit mehreren aktiven Erkennungsfunktionen
Datenschutz & Sicherheit
Lokale Verarbeitung von Gesichtserkennungsdaten
Sicherer Umgang mit Geolokalisierungsdaten
Einhaltung der Datenschutzrichtlinien für mobile Plattformen
Prüfanforderungen
Edge-UI-Interaktionstests
Testen der Genauigkeit der Erkennungsfunktion
Überprüfung der plattformübergreifenden Kompatibilität
Überwachung des Batterieverbrauchs
Leistungsbenchmarking
