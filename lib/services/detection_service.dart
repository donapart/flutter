import 'dart:async';
import 'package:flutter/foundation.dart';

/// Placeholder service that would handle AR related detections.
/// In a real app this would connect to packages like google_mlkit_* and camera.
class DetectionService extends ChangeNotifier {
  bool objectDetection = false;
  bool barcodeScanning = false;
  bool textRecognition = false;
  bool faceDetection = false;

  String statusMessage = 'Bereit';

  Timer? _ocrTimer;

  void toggleObjectDetection(bool value) {
    objectDetection = value;
    _updateStatus('Objekterkennung ${value ? 'aktiviert' : 'deaktiviert'}');
  }

  void toggleBarcodeScanning(bool value) {
    barcodeScanning = value;
    _updateStatus('Barcode Scan ${value ? 'aktiviert' : 'deaktiviert'}');
  }

  void toggleTextRecognition(bool value) {
    textRecognition = value;
    _updateStatus('Text OCR ${value ? 'aktiviert' : 'deaktiviert'}');
    _ocrTimer?.cancel();
    if (textRecognition) {
      _ocrTimer = Timer.periodic(const Duration(seconds: 5), (_) {
        // Perform text recognition here
        _updateStatus('OCR Durchlauf abgeschlossen');
      });
    }
  }

  void toggleFaceDetection(bool value) {
    faceDetection = value;
    _updateStatus('Gesichtserkennung ${value ? 'aktiviert' : 'deaktiviert'}');
  }

  void _updateStatus(String message) {
    statusMessage = message;
    notifyListeners();
  }

  @override
  void dispose() {
    _ocrTimer?.cancel();
    super.dispose();
  }
}
