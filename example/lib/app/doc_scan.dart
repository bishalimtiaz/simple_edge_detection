import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:simple_edge_detection_example/app/display_doc.dart';
import 'package:simple_edge_detection_example/cropping_preview.dart';
import 'package:simple_edge_detection_example/edge_detector.dart';
import 'package:simple_edge_detection_example/image_view.dart';

class DocScan extends StatefulWidget {
  const DocScan({Key? key}) : super(key: key);

  @override
  State<DocScan> createState() => _DocScanState();
}

class _DocScanState extends State<DocScan> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  String? imagePath;
  String? croppedImagePath;
  bool isInit = false;
  EdgeDetectionResult? edgeDetectionResult;

  @override
  void initState() {
    super.initState();
    checkForCameras().then((value) {
      initialiseCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isInit
          ? Column(
              children: [
                Expanded(
                  child: _getMainWidget(),
                ),
                SizedBox(
                  height: 42,
                  child: _getBottomBar(),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> checkForCameras() async {
    cameras = await availableCameras();
  }

  void initialiseCamera() async {
    checkForCameras();
    if (cameras.isEmpty) {
      log('No cameras detected');
      return;
    }
    controller = CameraController(cameras[0], ResolutionPreset.medium,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInit = true;
      });
    });
  }

  Widget _getBottomBar() {
    if (imagePath != null) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: () {
            if (croppedImagePath == null) {
              _processImage(imagePath, edgeDetectionResult!);
            }

            setState(() {
              imagePath = null;
              edgeDetectionResult = null;
              croppedImagePath = null;
            });
          },
        ),
      );
    }
    if (croppedImagePath != null) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            setState((){
              imagePath=null;
              croppedImagePath=null;
            });
          },
        ),
      );
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: onTakePictureButtonPressed,
        child: const Icon(Icons.camera_alt),
      ),
      const SizedBox(width: 16),
      FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: _onGalleryButtonPressed,
        child: const Icon(Icons.image),
      ),
    ]);
  }
  Future _processImage(
      String? filePath, EdgeDetectionResult edgeDetectionResult) async {
    if (!mounted || filePath == null) {
      return;
    }

    bool result =
    await EdgeDetector().processImage(filePath, edgeDetectionResult);

    if (result == false) {
      return;
    }

    setState(() {
      croppedImagePath = filePath;
      imageCache.clearLiveImages();
      imageCache.clear();
    });
  }
  Widget _getMainWidget() {
    if (croppedImagePath != null) {
      return ImageView(imagePath: croppedImagePath!);
    }
    if (imagePath == null && edgeDetectionResult == null) {
      return CameraPreview( controller);
    }

    return ImagePreview(
      imagePath: imagePath!,
      edgeDetectionResult: edgeDetectionResult!,
    );
  }
  void onTakePictureButtonPressed() async {
    final file = await controller.takePicture();
     imagePath= file.path;

    log('Picture saved to $imagePath');

    await _detectEdges(imagePath);
    // final image = await controller.takePicture();
    //
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => DocDisplayScreen(
    //       // Pass the automatically generated path to
    //       // the DisplayPictureScreen widget.
    //       imagePath: image.path,
    //     ),
    //   ),
    // );

  }

  Future _detectEdges(String? filePath) async {
    if (!mounted || filePath == null) {
      return;
    }

    setState(() {
      imagePath = filePath;
    });

    EdgeDetectionResult result = await EdgeDetector().detectEdges(filePath);

    setState(() {
      edgeDetectionResult = result;
    });
  }

  void _onGalleryButtonPressed() async {
    // ImagePicker picker = ImagePicker();
    // PickedFile? pickedFile = await picker.getImage(source: ImageSource.gallery);
    // final filePath = pickedFile!.path;
    //
    // log('Picture saved to $filePath');
    //
    // _detectEdges(filePath);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }
}
