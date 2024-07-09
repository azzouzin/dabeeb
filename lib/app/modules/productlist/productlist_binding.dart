import 'package:get/get.dart';

import './productlist_controller.dart';

class ProductlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductlistController>(
      () => ProductlistController(),
    );
  }
}
