import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:simple_edge_detection_example/app/constants/enums.dart';
import 'package:simple_edge_detection_example/app/doc_scanner.dart';

class MyScanController {
  MyScanController() {
    _init();
  }

  final CameraType _cameraType = CameraType.BACK;
  late CameraController cameraController;

  late Future<void> initializeControllerFuture;

  void _init() {
    CameraDescription camera = _getCamera();

    cameraController = CameraController(
      camera,
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );

    initializeControllerFuture = cameraController.initialize();
    cameraController.setFlashMode(FlashMode.auto);
  }

  CameraDescription _getCamera() {
    List<CameraDescription> cameras = DocScanner.cameras;
    if (cameras.isEmpty) {
      throw Exception('No camera found in the device');
    }
    switch (_cameraType) {
      case CameraType.FRONT:
        return cameras.last;
      case CameraType.BACK:
        return cameras.first;
    }
  }

  Future<String?> takePicture() async{

    try{
      if (!cameraController.value.isInitialized) {
        log('Error: select a camera first.');
        return null;
      }
      if (cameraController.value.isTakingPicture) {
        return null;
      }
      XFile image = await cameraController.takePicture();
      return image.path;
    } catch (e){
      log("Error: $e");
    }
    return null;
  }

  void disposeController() {
    cameraController.dispose();
  }
}
