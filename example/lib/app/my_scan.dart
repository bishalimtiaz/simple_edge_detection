
import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/controllers/my_scan_controller.dart';
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
      backgroundColor: Colors.black,
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
                onTapCaptureButton: () {},
              ),
            ),
          ],
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
