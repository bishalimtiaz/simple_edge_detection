import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_edge_detection/simple_edge_detection_method_channel.dart';

void main() {
  MethodChannelSimpleEdgeDetection platform = MethodChannelSimpleEdgeDetection();
  const MethodChannel channel = MethodChannel('simple_edge_detection');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
