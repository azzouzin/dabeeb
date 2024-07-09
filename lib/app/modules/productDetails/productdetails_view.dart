import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';

import './productdetails_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({super.key});
  ProductModel product = Get.arguments["product"];
  @override
  Widget build(BuildContext context) {
    print(product.product!.designation);
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
        builder: (controller) {
          return const Center(child: Text("productDetailsView"));
        },
      ),
    );
  }
}
