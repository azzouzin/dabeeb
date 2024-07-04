import 'package:get/get.dart';

import './barcodescanner_controller.dart';

class BarCodeScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarCodeScannerController>(
      () => BarCodeScannerController(),
    );
  }
}
