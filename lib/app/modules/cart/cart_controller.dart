import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/custom_snackbar.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/data/remote/error_handler.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:getx_skeleton/utils/constants.dart';
import 'package:logger/logger.dart';
import '../../data/local/pdf_print.dart';
import '../../data/local/shared_pref.dart';
import '../../data/remote/api_call_status.dart';

class CartController extends GetxController {
  // hold data coming from api
  // List<ProductModel> cartProducts = [];

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.success;
  // List<ProductModel> allProducts = [];
  // RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxDouble totalPrice = 0.0.obs;
  ClientModel? selctedClient;
  String logo = "";
  String name = "";
  String phone = "";
  String adresse = "";

  void setClient(ClientModel client) {
    selctedClient = client;
  }

  void addToCart(ProductModel product) {
    if (!cartProducts.contains(product)) {
      product.quantity = product.quantity!;
      cartProducts.add(product);
      calculateTotalPrice();
    } else {
      cartProducts.where((element) => element.id == product.id).first.quantity =
          product.quantity;
      cartProducts
          .where((element) => element.id == product.id)
          .first
          .qtyController = product.qtyController;
      cartProducts
          .where((element) => element.id == product.id)
          .first
          .priceController = product.priceController;
      calculateTotalPrice();
    }
  }

  void removeProduct(ProductModel product) {
    cartProducts.remove(product);
    calculateTotalPrice();
    Get.forceAppUpdate();
  }

  void changeQty(String qty, int producID) {
    qty = qty.isEmpty ? "0" : qty;
    cartProducts.where((element) => element.id == producID).first.quantity =
        double.parse(qty);

    calculateTotalPrice();
    update();
  }

  void increaseItemQuantity(ProductModel product) {
    product.quantity = product.quantity! + 1;
    product.qtyController!.text = product.quantity!.toString();

    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(ProductModel product) {
    product.quantity = product.quantity! - 1;
    product.qtyController!.text = product.quantity!.toString();
    calculateTotalPrice();
    update();
  }

  bool get isEmptyCart => cartProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      if (!element.priceController!.text.contains(".")) {
        element.priceController!.text = element.priceController!.text + ".0";
      }
      totalPrice.value +=
          element.quantity! * double.parse(element.priceController!.text);
      print(
          "Total Price is = ${totalPrice.value} = ${element.quantity!}* ${element.prixVente2!}");
    }
  }

  void createOrder() async {
    if (cartProducts.isNotEmpty) {
      apiCallStatus = ApiCallStatus.loading;
      update();
      List<Map<String, dynamic>> lines = [];

      for (var element in cartProducts) {
        lines.add({
          "lot": {"id": element.id},
          "prixVente": element.priceController!.text,
          "qte": double.parse(element.qtyController!.text) *
              (element.qteUniteMesure ?? 1.0),
        });
      }
      Map<String, dynamic> data = {
        "client": {"id": selctedClient!.id},
        "lines": lines,
      };
      await BaseClient.safeApiCall(
        Constants.createOrder,
        headers: {"Authorization": SharedPref.getAuthorizationToken()!},
        RequestType.post,
        data: data,
        onSuccess: (response) async {
          apiCallStatus = ApiCallStatus.success;

          update();

          await Facture().generateAndPrintArabicPdf(
            date: DateTime.now().toString().substring(0, 16),
            client: selctedClient!,
            total: totalPrice.value.toString(),
            numBon: response.data["code"].toString(),
            logo: logo,
            name: name,
            adresse: adresse,
            phone: phone,
          );
          Get.offAllNamed(Routes.HOME);
          CustomSnackBar.showCustomSnackBar(
              title: "Merci", message: "Votre panier est validée");
        },
        onError: (p0) {
          ErrorHandler.handelError(p0);
          apiCallStatus = ApiCallStatus.success;
          update();
        },
      );
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
          title: "Panier vide",
          message: "Veuillez ajouter au moins un article");
    }
  }

  void getLogo() async {
    String? token = SharedPref.getAuthorizationToken();
    await BaseClient.safeApiCall(
      "${Constants.enterprise}",
      RequestType.get,
      headers: {"Authorization": token!},
      onSuccess: (response) {
        logo = utf8.decode(base64Url.decode(response.data["image"]));
        name = response.data["name"];
        phone = response.data["telephone"];
        adresse = response.data["adresse"];
        apiCallStatus = ApiCallStatus.success;
        update();
        Logger().i(response.data);
      },
      // onError: (p0) {
      // //  ErrorHandler.handelError(p0);
      // },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getLogo();
  }
}
