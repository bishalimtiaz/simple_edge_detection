import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/dimens.dart';
import 'package:simple_edge_detection_example/app/constants/enums.dart';
import 'package:simple_edge_detection_example/app/controllers/flash_mode_controller.dart';

import 'package:simple_edge_detection_example/app/controllers/scanner_camera_settings_controller.dart';

class CameraHeader extends StatelessWidget {
  final Function() onTapBackButton;

  final FlashModeController flashModeController;
  final ScannerCameraSettingsController scannerCameraSettingsController;

  const CameraHeader({
    required this.flashModeController,
    required this.onTapBackButton,
    Key? key,
    required this.scannerCameraSettingsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.dimen_16, horizontal: Dimens.dimen_20),
      child: Row(
        children: [
          ValueListenableBuilder<ScannerCameraSettings>(
              valueListenable:
                  scannerCameraSettingsController.scannerCameraSettings,
              builder: (context, ScannerCameraSettings value, _) {
                return _getPrefixWidget(value == ScannerCameraSettings.none);
              }),
          const Spacer(),
          ValueListenableBuilder<FlashMode>(
            valueListenable: flashModeController.flashMode,
            builder: (context, FlashMode value, _) {
              return InkWell(
                onTap: () async {
                  scannerCameraSettingsController
                      .setScannerCameraSettings(ScannerCameraSettings.flash);
                },
                child: Icon(
                  _getIcon(value),
                  color: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(width: Dimens.dimen_20),
          InkWell(
            onTap: () async {
              scannerCameraSettingsController
                  .setScannerCameraSettings(ScannerCameraSettings.more);
            },
            child: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getPrefixWidget(bool isBackButton) {
    return InkWell(
      onTap: () async {
        if (isBackButton) {
          onTapBackButton.call();
        } else {
          scannerCameraSettingsController.hideSettings();
        }
      },
      child: Icon(
        isBackButton ? Icons.arrow_back : Icons.close,
        color: Colors.white,
      ),
    );
  }

  IconData _getIcon(FlashMode mode) {
    if (mode == FlashMode.always) {
      return Icons.flash_on;
    } else if (mode == FlashMode.auto) {
      return Icons.flash_auto;
    } else if (mode == FlashMode.torch) {
      return Icons.highlight;
    } else {
      return Icons.flash_off;
    }
  }
}
