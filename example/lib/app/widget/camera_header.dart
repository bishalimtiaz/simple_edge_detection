import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/dimens.dart';

class CameraHeader extends StatelessWidget {
  final Function() onTapBackButton;
  final Function() onTapMoreButton;
  final Function() onTapFlashButton;

  const CameraHeader({
    required this.onTapBackButton,
    required this.onTapFlashButton,
    required this.onTapMoreButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.dimen_16, horizontal: Dimens.dimen_20),
      child: Row(
        children: const [
          Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          Spacer(),
          Icon(
            Icons.flash_auto,
            color: Colors.white,
          ),
          SizedBox(width: Dimens.dimen_20),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
