import 'dart:io';

import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';
import 'package:simple_edge_detection_example/app/controllers/preview_image_controller.dart';
import 'package:simple_edge_detection_example/app/widget/preview_image_footer.dart';
import 'package:simple_edge_detection_example/app/widget/preview_image_header.dart';

class PreviewImage extends StatefulWidget {
  final String imagePath;

  const PreviewImage({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  late final PreviewImageController _controller;

  @override
  void initState() {
    _controller = PreviewImageController();
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
          children: [
            PreviewImageHeader(onTapBackButton: () {}),
            Flexible(
              flex: 8,
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            const Flexible(
              flex: 2,
              child: PreviewImageFooter(),
            ),
          ],
        ),
      ),
    );
  }
}
