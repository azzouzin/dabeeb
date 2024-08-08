import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/data/remote/error_handler.dart';
import 'package:getx_skeleton/app/modules/login/login_controller.dart';
import 'package:logger/logger.dart';

import '../../../../utils/constants.dart';
import '../../components/custom_snackbar.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/base_client.dart';
import '../../routes/routes.dart';
import '../cart/cart_controller.dart';

class ProductlistController extends GetxController {
  // hold data coming from api
  List<ProductModel> products = [];
  ProductModel? product;
  LoginController loginController = Get.put(LoginController());
  CartController cartController = Get.put(CartController());
  TextEditingController searchController = TextEditingController();
  String clientType = "";
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  int pageIndicator = 0;
  bool isFinished = false;

  Future getProductByBarCode(String barCode) async {
    // barCode = "00000000139";
    await BaseClient.safeApiCall(
      "${Constants.codeBareProduct}?barcode=$barCode",
      RequestType.get,
      headers: {'Authorization': loginController.accessToken},
      onSuccess: (response) {
        final ProductModel product =
            ProductModel.fromJson(response.data, clientType);
        Logger().i(product.toJson());
        update();
        Get.toNamed(Routes.PRODUCTDETAILS, arguments: {"product": product});
      },
      onError: (p0) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: "Produit inexistant",
            message: "Veuillez scanner un produit existant");
      },
    );
  }

  // getting data from api
  Future getData(String keyword, String type) async {
    // apiCallStatus = ApiCallStatus.loading;
    // update();
    Logger().wtf("$keyword $pageIndicator");
    await BaseClient.safeApiCall(
      "${Constants.products}?keyword=$keyword&page=$pageIndicator&size=10&sort=product.designation,dateExpiration,asc&idProduct=0&deleted=false&hasQte=qte>0",
      RequestType.get,
      headers: {'Authorization': loginController.accessToken},
      onSuccess: (response) {
        for (var element in response.data['content']) {
          products.firstWhereOrNull((e) =>
                      ProductModel.fromJson(element, clientType).id == e.id) !=
                  null
              ? null
              : products.add(ProductModel.fromJson(element, clientType));
        }
        for (var element in products) {
          print(element.barcode + element.product!.designation);
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

  void clearSearch() {
    searchController.clear();
    pageIndicator = 0;
    isFinished = false;
    products.clear();
    getData("", clientType);
  }

  void searchWordChanged(String keyword) {
    if (searchController.text.length % 3 == 0) {
      pageIndicator = 0;
      isFinished = false;
      products.clear();
      getData(keyword, clientType);
    }
  }

  void onProductTapped(ProductModel clickedproduct) {
    product = clickedproduct;

    Get.toNamed(Routes.PRODUCTDETAILS, arguments: {"product": product});
  }

  @override
  void onInit() {
    clientType = cartController.selctedClient!.category!.toString();
    clientType = clientType == "1" ? "" : clientType;
    print(clientType);
    getData("", clientType);

    super.onInit();
  }
}
