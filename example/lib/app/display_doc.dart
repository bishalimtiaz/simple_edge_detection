
import 'dart:io';

import 'package:flutter/material.dart';

class DocDisplayScreen extends StatelessWidget {
  final String imagePath;
  const DocDisplayScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body:Column(
        children: [
          Expanded(child: Image.file(File(imagePath))),
          SizedBox(
            height: 48,
            child:  Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed: () {
                  // if (croppedImagePath == null) {
                  //   _processImage(imagePath, edgeDetectionResult!);
                  // }
                  //
                  // setState(() {
                  //   imagePath = null;
                  //   edgeDetectionResult = null;
                  //   croppedImagePath = null;
                  // });
                },
              ),
            ),
          )
        ],
      )
      //Image.file(File(imagePath)),
    );
  }
}
