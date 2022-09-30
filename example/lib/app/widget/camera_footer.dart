import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/widget/capture_button.dart';
import 'package:simple_edge_detection_example/app/widget/asset_image_view.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_asset.dart';

class CameraFooter extends StatelessWidget {
  final Function() onTapCaptureButton;

  const CameraFooter({
    required this.onTapCaptureButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AssetImageView(
          assetPath: ScannerAsset.icOptions,
          height: 24,
          width: 24,
        ),
        const SizedBox(
          width: 48,
        ),
        CaptureButton(
          captureImage: () {},
        ),
        const SizedBox(
          width: 48,
        ),
        const AssetImageView(
          assetPath: ScannerAsset.icGallery,
          height: 24,
          width: 24,
        ),
      ],
    );
  }
}
