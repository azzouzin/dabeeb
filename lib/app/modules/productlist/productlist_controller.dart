import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/data/remote/error_handler.dart';
import 'package:getx_skeleton/app/modules/login/login_controller.dart';
import 'package:logger/logger.dart';

import '../../../../utils/constants.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/base_client.dart';
import '../../routes/routes.dart';

class ProductlistController extends GetxController {
  // hold data coming from api
  List<ProductModel> products = [];
  ProductModel? product;
  LoginController loginController = Get.put(LoginController());
  TextEditingController searchController = TextEditingController();
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  int pageIndicator = 0;
  bool isFinished = false;

  Future getProductByBarCode(String barCode) async {
    barCode = "1000000000122";
    await BaseClient.safeApiCall(
      "${Constants.codeBareProduct}?barcode=$barCode",
      RequestType.get,
      headers: {'Authorization': loginController.accessToken},
      onSuccess: (response) {
        final ProductModel product = ProductModel.fromJson(response.data);
        Logger().i(product.toJson());
        update();
        Get.toNamed(Routes.PRODUCTDETAILS, arguments: {"product": product});
      },
      onError: (p0) {
        ErrorHandler.handelError(p0);
      },
    );
  }

  // getting data from api
  Future getData(String keyword) async {
    // apiCallStatus = ApiCallStatus.loading;
    // update();
    Logger().wtf("$keyword $pageIndicator");
    await BaseClient.safeApiCall(
      "${Constants.products}?keyword=$keyword&page=$pageIndicator&size=10&sort=product.designation,dateExpiration,asc&idProduct=0&deleted=false&hasQte=0",
      RequestType.get,
      headers: {'Authorization': loginController.accessToken},
      onSuccess: (response) {
        for (var element in response.data['content']) {
          products.add(ProductModel.fromJson(element));
          Logger().wtf(element);
          Logger().i(products.last.toJson());
        }
        pageIndicator++;
        if (response.data['last'] == true) {
          isFinished = true;
          update();
        }
        update();
      },
      onError: (p0) {
        ErrorHandler.handelError(p0);
      },
    );
    apiCallStatus = ApiCallStatus.success;
    update();
  }

  void searchWordChanged(String keyword) {
    pageIndicator = 0;
    isFinished = false;
    products.clear();
    getData(keyword);
  }

  void onProductTapped(ProductModel product) {
    this.product = product;
    Get.toNamed(Routes.PRODUCTDETAILS, arguments: {"product": product});
  }

  @override
  void onInit() {
    getData("");
    super.onInit();
  }
}
