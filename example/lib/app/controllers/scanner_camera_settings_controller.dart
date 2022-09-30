import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/enums.dart';

class ScannerCameraSettingsController {
  final ValueNotifier<ScannerCameraSettings> scannerCameraSettings =
      ValueNotifier(ScannerCameraSettings.none);

  void setScannerCameraSettings(ScannerCameraSettings settings) {
    scannerCameraSettings.value == settings
        ? scannerCameraSettings.value = ScannerCameraSettings.none
        : scannerCameraSettings.value = settings;
  }

  void hideSettings() {
    scannerCameraSettings.value = ScannerCameraSettings.none;
  }

  void disposeController() {
    scannerCameraSettings.dispose();
  }
}
