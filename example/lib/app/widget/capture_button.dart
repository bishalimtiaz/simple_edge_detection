import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/dimens.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';

class CaptureButton extends StatelessWidget {
  final Function() captureImage;

  const CaptureButton({
    required this.captureImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: captureImage,
      child: Container(
        height: Dimens.captureButtonSize,
        width: Dimens.captureButtonSize,
        padding: const EdgeInsets.all(Dimens.dimen_4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: ScannerColor.captureButtonOuterCircleBorderColor,
            width: Dimens.dimen_4,
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: ScannerColor.captureButtonInnerCircleColor,
          ),
        ),
      ),
    );
  }
}
