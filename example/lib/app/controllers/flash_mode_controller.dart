import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeController{
  final ValueNotifier<FlashMode> flashMode = ValueNotifier(FlashMode.auto);

  void setFlashMode(FlashMode mode, CameraController cameraController) {
    if (flashMode.value == mode) return;

    if (mode == FlashMode.auto) {
      cameraController.setFlashMode(FlashMode.auto);
      flashMode.value = FlashMode.auto;
    } else if (mode == FlashMode.always) {
      cameraController.setFlashMode(FlashMode.always);
      flashMode.value = FlashMode.always;
    } else if (mode == FlashMode.off) {
      cameraController.setFlashMode(FlashMode.off);
      flashMode.value = FlashMode.off;
    } else if (mode == FlashMode.torch) {
      cameraController.setFlashMode(FlashMode.torch);
      flashMode.value = FlashMode.torch;
    }
  }

  void disposeController(){
    flashMode.dispose();
  }
}