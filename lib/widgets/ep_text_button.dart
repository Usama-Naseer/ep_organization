import 'package:flutter/material.dart';

import '../utils/ep_colors.dart';

class EPTextButton extends StatelessWidget {
  const EPTextButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        style: const TextStyle(
          color: EPColors.kSecondaryColor,
        ),
      ),
    );
  }
}
