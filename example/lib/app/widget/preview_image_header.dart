import 'package:flutter/material.dart';
import 'package:simple_edge_detection_example/app/constants/dimens.dart';

class PreviewImageHeader extends StatelessWidget {
  final Function() onTapBackButton;

  const PreviewImageHeader({
    required this.onTapBackButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.dimen_16, horizontal: Dimens.dimen_20),
      child: Row(
        children: [
          InkWell(
            onTap: onTapBackButton,
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
