import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:simple_edge_detection/edge_detection.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';
import 'package:simple_edge_detection_example/app/controllers/preview_image_controller.dart';
import 'package:simple_edge_detection_example/app/widget/preview_image_footer.dart';
import 'package:simple_edge_detection_example/app/widget/preview_image_header.dart';
import 'package:simple_edge_detection_example/edge_detection_shape/edge_detection_shape.dart';

class PreviewImage extends StatefulWidget {
  final String imagePath;
  EdgeDetectionResult? edgeDetectionResult;

  PreviewImage({
    required this.imagePath,
    this.edgeDetectionResult,
    Key? key,
  }) : super(key: key);

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  GlobalKey imageWidgetKey = GlobalKey();
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
            PreviewImageHeader(
              onTapBackButton: () async {
                Navigator.of(context).pop();
              },
            ),
            Flexible(
              flex: 8,
              child: _getImageProcessedWidget(
                  widget.imagePath, widget.edgeDetectionResult, context),
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

  Widget _getImageProcessedWidget(
    String imagePath,
    EdgeDetectionResult? edgeDetectionResult,
    BuildContext context,
  ) {
    if (edgeDetectionResult == null) {
      return Image.file(
        File(widget.imagePath),
        fit: BoxFit.cover,
      );
    } else {

      return  Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Center(
              child: Text('Loading ...')
          ),
          Image.file(
              File(widget.imagePath),
              fit: BoxFit.contain,
              key: imageWidgetKey
          ),
          FutureBuilder<ui.Image>(
              future: loadUiImage(widget.imagePath),
              builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                return _getEdgePaint(snapshot, context);
              }
          ),
        ],
      );
    }
  }
  Widget _getEdgePaint(AsyncSnapshot<ui.Image> imageSnapshot, BuildContext context) {
    if (imageSnapshot.connectionState == ConnectionState.waiting) {
      return Container();
    }

    if (imageSnapshot.hasError) {
      return Text('Error: ${imageSnapshot.error}');
    }

    if (widget.edgeDetectionResult == null) {
      return Container();
    }

    final keyContext = imageWidgetKey.currentContext;

    if (keyContext == null) {
      return Container();
    }

    final box = keyContext.findRenderObject() as RenderBox;

    return EdgeDetectionShape(
      originalImageSize: Size(
          imageSnapshot.data!.width.toDouble(),
          imageSnapshot.data!.height.toDouble()
      ),
      renderedImageSize: Size(box.size.width, box.size.height),
      edgeDetectionResult: widget.edgeDetectionResult!,
    );
  }

  Future<ui.Image> loadUiImage(String? imageAssetPath) async {
    final Uint8List data = await File(imageAssetPath??"").readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image image) {
      return completer.complete(image);
    });
    return completer.future;
  }
}
