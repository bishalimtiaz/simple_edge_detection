import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:simple_edge_detection_example/app/constants/enums.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';
import 'package:simple_edge_detection_example/app/controllers/my_scan_controller.dart';
import 'package:simple_edge_detection_example/app/views/preview_image.dart';
import 'package:simple_edge_detection_example/app/widget/camera_footer.dart';
import 'package:simple_edge_detection_example/app/widget/camera_header.dart';
import 'package:simple_edge_detection_example/app/widget/camera_view.dart';
import 'package:simple_edge_detection_example/app/widget/falsh_mode_settings.dart';
import 'package:simple_edge_detection_example/edge_detector.dart';

class MyScan extends StatefulWidget {
  const MyScan({Key? key}) : super(key: key);

  @override
  State<MyScan> createState() {
    return _MyScanState();
  }
}

class _MyScanState extends State<MyScan> {
  late final MyScanController _controller;

  @override
  void initState() {
    _controller = MyScanController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScannerColor.cameraViewBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CameraHeader(
              flashModeController: _controller.flashModeController,
              scannerCameraSettingsController:
                  _controller.scannerCameraSettingsController,
              onTapBackButton: () {},
            ),
            _getMainView(),
            Flexible(
              flex: 2,
              child: CameraFooter(
                onTapGalleryButton: _onTapGalleryButton,
                onTapCaptureButton: _captureImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMainView() {
    return Flexible(
      flex: 8,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(child: _getCameraView()),
          ValueListenableBuilder<ScannerCameraSettings>(
              valueListenable: _controller
                  .scannerCameraSettingsController.scannerCameraSettings,
              builder: (context, ScannerCameraSettings value, _) {
                return Visibility(
                  visible: value == ScannerCameraSettings.flash,
                  child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: FlashModeSetting(
                      flashModeController: _controller.flashModeController,
                      onChangeFlashMode: (FlashMode mode) {
                        _controller.setFlashMode(mode);
                      },
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  void _captureImage() async {
    // Ensure that the camera is initialized.
    await _controller.initializeControllerFuture;

    String? imagePath = await _controller.takePicture();
    EdgeDetectionResult result = await EdgeDetector().detectEdges(imagePath);
    // await EdgeDetector().processImage(imagePath, result);

    _navigateToPreviewImageScreen(imagePath,result);
  }

  Widget _getCameraView() {
    return FutureBuilder<void>(
      future: _controller.initializeControllerFuture,
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraView(
            controller: _controller.cameraController,
          );
        } else {
          // Otherwise, display a loading indicator.
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _onTapGalleryButton() async{
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    _navigateToPreviewImageScreen(image?.path,null);

    // final List<XFile>? images = await _picker.pickMultiImage();

  }

  void _navigateToPreviewImageScreen(String? imagePath, EdgeDetectionResult? result) async{
    if (!mounted || imagePath == null) return;

    // If the picture was taken, display it on a new screen.
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewImage(
          imagePath: imagePath,
          edgeDetectionResult: result,
        ),
      ),
    );
  }
}
