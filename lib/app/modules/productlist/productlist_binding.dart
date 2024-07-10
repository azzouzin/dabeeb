import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';

import './productlist_controller.dart';

class ProductlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductlistController>(
      () => ProductlistController(),
    );
    Get.put<CartController>(
      CartController(),
    );
  }
}
