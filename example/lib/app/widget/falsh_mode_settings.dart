import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/dimens.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_color.dart';
import 'package:simple_edge_detection_example/app/constants/scanner_text.dart';
import 'package:simple_edge_detection_example/app/controllers/flash_mode_controller.dart';

class FlashModeSetting extends StatelessWidget {
  // final ValueNotifier<FlashMode> flashMode;
  final FlashModeController flashModeController;
  final Function(FlashMode mode) onChangeFlashMode;

  const FlashModeSetting({
    required this.onChangeFlashMode,
    required this.flashModeController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ScannerColor.cameraViewBackgroundColor.withOpacity(0.7),
      padding: const EdgeInsets.symmetric(
        vertical: Dimens.dimen_8,
        horizontal: Dimens.dimen_4,
      ),
      child: ValueListenableBuilder<FlashMode>(
          valueListenable: flashModeController.flashMode,
          builder: (context, FlashMode value, _) {
            return Row(
              children: [
                Expanded(
                  child: _getFlashModeTextView(
                    mode: FlashMode.always,
                    isSelected: value == FlashMode.always,
                  ),
                ),
                Expanded(
                  child: _getFlashModeTextView(
                    mode: FlashMode.off,
                    isSelected: value == FlashMode.off,
                  ),
                ),
                Expanded(
                  child: _getFlashModeTextView(
                    mode: FlashMode.auto,
                    isSelected: value == FlashMode.auto,
                  ),
                ),
                Expanded(
                  child: _getFlashModeTextView(
                      mode: FlashMode.torch,
                      isSelected: value == FlashMode.torch),
                ),
              ],
            );
          }),
    );
  }

  Widget _getFlashModeTextView({
    required FlashMode mode,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () async {
        onChangeFlashMode.call(mode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.dimen_10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black54 : null,
          borderRadius: const BorderRadius.all(Radius.circular(Dimens.dimen_4)),
        ),
        child: Text(
          _getText(mode),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? ScannerColor.scannerPrimaryColor : Colors.white,
          ),
        ),
      ),
    );
  }

  String _getText(FlashMode mode) {
    if (mode == FlashMode.always) {
      return ScannerText.on;
    } else if (mode == FlashMode.auto) {
      return ScannerText.auto;
    } else if (mode == FlashMode.torch) {
      return ScannerText.torch;
    } else {
      return ScannerText.off;
    }
  }
}
