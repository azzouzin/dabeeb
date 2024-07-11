import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ZoomImagesView extends StatelessWidget {
  ZoomImagesView({super.key, required this.image});
  String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightThemeColors.primaryColor,
      body: SafeArea(
        child: Zoom(
          initTotalZoomOut: true,
          canvasColor: Colors.black,
          backgroundColor: Colors.black,
          child: Image.memory(
            base64Decode(image.split(',').last),
            width: Get.width,
            height: Get.height,
          ).animate().slideX(
                duration: const Duration(milliseconds: 300),
                begin: 1,
                curve: Curves.easeInSine,
              ),
        ),
      ),
    );
  }
}
