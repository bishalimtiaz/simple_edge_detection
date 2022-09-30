import 'package:camera/camera.dart';

abstract class DocScanner{
  static late final List<CameraDescription> cameras;

  static Future<void> initializeScanner() async{
    cameras = await availableCameras();
  }
}