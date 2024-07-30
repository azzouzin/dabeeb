import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';
import 'package:getx_skeleton/app/modules/productlist/productlist_controller.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:logger/logger.dart';
import '../../../utils/constants.dart';
import '../../data/local/shared_pref.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/error_handler.dart';
import 'dart:convert';

class ProductDetailsController extends GetxController {
  // hold data coming from api
  List<dynamic>? data;
  String descreption = "No Description";
  TextEditingController qtyController = TextEditingController(text: '1');
  ProductlistController productlistController =
      Get.put(ProductlistController());
  CartController cartController = Get.put(CartController());
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  List<String> image = [];
  void changeQty(double qty) {
    if (qtyController.text != '0' || qty > 0) {
      qtyController.text = (double.parse(qtyController.text) + qty).toString();
    }
    update();
  }

  void getProductImages(int id) async {
    String? token = SharedPref.getAuthorizationToken();
    await BaseClient.safeApiCall(
      "${Constants.productImage}?idproduct=$id",
      RequestType.get,
      headers: {"Authorization": token!},
      onSuccess: (response) {
        for (var element in response.data) {
          image.add(utf8.decode(base64Url.decode(element["image"])));
          descreption = element["product"]["description"] ?? "No Description";
        }

        Logger().i(image);
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      onError: (p0) {
        ErrorHandler.handelError(p0);
      },
    );
  }

  void onAddToCartPressed(ProductModel product) {
    product.quantity = double.parse(qtyController.text);
    product.qtyController!.text = qtyController.text;
    product.priceController!.text = product.prixVente.toString();
    product.images = image;
    cartController.cartProducts
                .firstWhereOrNull((element) => element.id == product.id) ==
            null
        ? cartController.addToCart(product)
        : null;
    Get.offNamed(Routes.CART);
  }

  @override
  void onInit() {
    super.onInit();
    getProductImages(productlistController.product!.product!.id!);
  }
}
