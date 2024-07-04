import 'package:get/get.dart';

import './addclient_controller.dart';

class AddClientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClientController>(
      () => AddClientController(),
    );
  }
}
