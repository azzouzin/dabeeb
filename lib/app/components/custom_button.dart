import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/theme/light_theme_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final double high;
  final double width;
  final Color color;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.width,
    required this.color,
    this.iconColor,
    required this.high,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 24),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 56),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25)))),
        icon: Icon(
          CupertinoIcons.arrow_right,
          color: iconColor ?? Colors.white,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: LightThemeColors.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}
