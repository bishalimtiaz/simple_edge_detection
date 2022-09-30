import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';
import 'package:simple_edge_detection_example/app/controllers/my_scan_controller.dart';
import 'package:simple_edge_detection_example/app/views/preview_image.dart';
import 'package:simple_edge_detection_example/app/widget/camera_footer.dart';
import 'package:simple_edge_detection_example/app/widget/camera_header.dart';
import 'package:simple_edge_detection_example/app/widget/camera_view.dart';

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
              onTapBackButton: () {},
              onTapFlashButton: () {},
              onTapMoreButton: () {},
            ),
            Flexible(
              flex: 8,
              child: _getCameraView(),
            ),
            Flexible(
              flex: 2,
              child: CameraFooter(
                onTapCaptureButton: _captureImage,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _captureImage() async {
    // Ensure that the camera is initialized.
    await _controller.initializeControllerFuture;

    String? imagePath = await _controller.takePicture();

    if (!mounted || imagePath == null) return;

    // If the picture was taken, display it on a new screen.
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PreviewImage(
          imagePath: imagePath,
        ),
      ),
    );
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
}
