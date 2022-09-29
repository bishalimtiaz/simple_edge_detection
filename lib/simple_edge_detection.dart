
import 'simple_edge_detection_platform_interface.dart';

class SimpleEdgeDetection {
  Future<String?> getPlatformVersion() {
    return SimpleEdgeDetectionPlatform.instance.getPlatformVersion();
  }
}
