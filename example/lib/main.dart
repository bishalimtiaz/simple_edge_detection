import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/doc_scanner.dart';
import 'package:simple_edge_detection_example/app/views/my_scan.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await DocScanner.initializeScanner();

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
      home: const MyScan(),
    );
  }
}