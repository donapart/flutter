# Detaillierte Dokumentation zur Edge AR App

Diese Dokumentation beschreibt die Projektstruktur, zentrale Komponenten und die geplante Funktionsweise der Edge-AR-Mobilanwendung. Das Projekt ist ein minimaler Prototyp, der eine Flutter-basierte Oberfläche für AR-gestützte Erkennungsfunktionen bereitstellt.

## Inhaltsverzeichnis
1. [Projektüberblick](#projektueberblick)
2. [Datei- und Ordnerstruktur](#struktur)
3. [Hauptbestandteile](#hauptbestandteile)
   - [main.dart](#maindart)
   - [DetectionService](#detectionservice)
   - [EdgeMenu](#edgemenu)
4. [Ausführen des Projekts](#ausfuehren)
5. [Erweiterungsmöglichkeiten](#erweiterungen)

<a name="projektueberblick"></a>
## 1. Projektüberblick
Die Anwendung demonstriert, wie eine mobile AR-App mit menügesteuerten Erkennungsfunktionen aufgebaut sein kann. Sie nutzt Flutter, Provider und einfache Animationscontroller, um ein seitliches Menüsystem zu realisieren. Die eigentlichen Erkennungsfunktionen (Objekterkennung, QR-Code-Scan, Texterkennung und Gesichtserkennung) sind als Platzhalter implementiert.

<a name="struktur"></a>
## 2. Datei- und Ordnerstruktur
```
.
├── README.md            – Kurze Projektbeschreibung
├── pubspec.yaml         – Flutter-Paketkonfiguration
├── lib/
│   ├── main.dart        – Einstiegspunkt der App
│   ├── services/
│   │   └── detection_service.dart – Logik der Erkennungsfunktionen
│   └── widgets/
│       └── edge_menu.dart – Widget für einblendbare Seitenmenüs
└── docs/
    └── DOKUMENTATION.md – (diese Datei)
```

<a name="hauptbestandteile"></a>
## 3. Hauptbestandteile

<a name="maindart"></a>
### 3.1 main.dart
Der Einstiegspunkt der App erstellt ein `MaterialApp` mit dunklem Theme und lädt `MainPage`. Innerhalb von `MainPage` werden zwei `AnimationController` instanziiert, um linke und rechte Seitenmenüs einzublenden. Über `Provider` wird eine Instanz des `DetectionService` bereitgestellt.

`MainPage` besteht aus:
- einem Platzhalter für das Kamerabild bzw. die AR-Ansicht
- dem linken Navigationsmenü (Karte, Einstellungen, Objekterkennung)
- dem rechten Kontextmenü (Barcode-Scan, Text-OCR, Gesichtserkennung)
- einer oberen Titelleiste mit Menü-Buttons
- einer unteren Statusleiste für Meldungen des `DetectionService`

Die Menü-Buttons lösen die Methoden `_toggleLeftMenu` und `_toggleRightMenu` aus, die die zugehörigen `AnimationController` starten oder stoppen.

<a name="detectionservice"></a>
### 3.2 DetectionService
`DetectionService` ist eine `ChangeNotifier`-Klasse und simuliert die Steuerung aller Erkennungsfunktionen. Für jede Funktion (Objekterkennung, Barcode-Scan, Text-OCR, Gesichtserkennung) gibt es einen booleschen Schalter. Änderungen werden über `notifyListeners()` an die UI gemeldet.

Wird die Texterkennung aktiviert, startet ein `Timer`, der alle 5 Sekunden einen hypothetischen OCR-Lauf ausführt und anschließend den Status aktualisiert. Beim Deaktivieren oder Beenden der App wird der Timer gestoppt.

<a name="edgemenu"></a>
### 3.3 EdgeMenu
Das Widget `EdgeMenu` erhält eine Ausrichtung (`Alignment`), einen `AnimationController`, eine feste Breite und das einzublendende Widget. Der Menüinhalt wird in einen `SlideTransition` verpackt und gleitet so von links oder rechts in das Bild. Die Position wird über den angegebenen `AnimationController` gesteuert.

<a name="ausfuehren"></a>
## 4. Ausführen des Projekts
Zum Starten der App ist Flutter lokal erforderlich. Folgende Schritte sind nötig:

```bash
flutter pub get
flutter run
```

Die App öffnet die Kamera (Platzhalter) und zeigt die einblendbaren Menüs. Über die Schalter können die jeweiligen Erkennungsfunktionen aktiviert werden. Da es sich um einen Prototypen handelt, gibt es keine echte AR- oder Kamera-Implementierung.

<a name="erweiterungen"></a>
## 5. Erweiterungsmöglichkeiten
- **Echte AR-Funktionen:** Integration von `google_mlkit` oder vergleichbaren Bibliotheken für Objekterkennung, Barcode-Scan, Texterkennung und Gesichtserkennung.
- **Kameraeinbindung:** Nutzung des `camera`-Pakets oder Plattformkanälen für ein echtes Kamerabild.
- **Persistente Einstellungen:** Speichern des Status (z.B. über `SharedPreferences` oder eine lokale Datenbank).
- **Weitere Menüs:** Erweiterung des Menüsystems um zusätzliche Funktionen oder Untermenüs.
- **Unit- und Widget-Tests:** Automatisierte Tests zur Sicherstellung der korrekten Funktionsweise.

---
Diese Dokumentation soll einen Überblick geben, wie das Projekt strukturiert ist und an welchen Stellen Erweiterungen vorgesehen sind. Sie dient als Ausgangspunkt für eine detailliertere Planung oder Weiterentwicklung.
