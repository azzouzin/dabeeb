import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './barcodescanner_controller.dart';

class BarCodeScannerView extends GetView<BarCodeScannerController> {
  const BarCodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BarCodeScannerController>(
        builder: (controller) {
         return const Center(child: Text("barCodeScannerView"));
        },
      ),
    );
  }
}
    