import 'package:flutter_test/flutter_test.dart';
import 'package:simple_edge_detection/simple_edge_detection.dart';
import 'package:simple_edge_detection/simple_edge_detection_platform_interface.dart';
import 'package:simple_edge_detection/simple_edge_detection_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSimpleEdgeDetectionPlatform
    with MockPlatformInterfaceMixin
    implements SimpleEdgeDetectionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SimpleEdgeDetectionPlatform initialPlatform = SimpleEdgeDetectionPlatform.instance;

  test('$MethodChannelSimpleEdgeDetection is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSimpleEdgeDetection>());
  });

  test('getPlatformVersion', () async {
    SimpleEdgeDetection simpleEdgeDetectionPlugin = SimpleEdgeDetection();
    MockSimpleEdgeDetectionPlatform fakePlatform = MockSimpleEdgeDetectionPlatform();
    SimpleEdgeDetectionPlatform.instance = fakePlatform;

    expect(await simpleEdgeDetectionPlugin.getPlatformVersion(), '42');
  });
}
