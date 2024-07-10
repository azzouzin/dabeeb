import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import '../../data/remote/api_call_status.dart';

class CartController extends GetxController {
  // hold data coming from api
  // List<ProductModel> cartProducts = [];

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  // List<ProductModel> allProducts = [];
  // RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxDouble totalPrice = 0.0.obs;

  void addToCart(ProductModel product) {
    if (!cartProducts.contains(product)) {
      product.quantity = product.quantity! + 1;
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
      totalPrice.value +=
          element.quantity! * double.parse(element.priceController!.text);
      print(
          "Total Price is = ${totalPrice.value} = ${element.quantity!}* ${element.prixVente2!}");
    }
  }
}
