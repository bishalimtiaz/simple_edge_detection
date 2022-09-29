import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/doc_scan.dart';

import 'scan.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const EdgeDetectionApp());
}

class EdgeDetectionApp extends StatelessWidget {
  const EdgeDetectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      DocScan(),
      //Scan(),
    );
  }
}