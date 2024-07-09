import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../app/data/models/product_model.dart';
import '../utils/app_data.dart';

class ProductController extends GetxController {
  List<ProductModel> allProducts = [];
  RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxInt totalPrice = 0.obs;

  void addToCart(ProductModel product) {
    product.quantity = product.quantity! + 1;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);
    calculateTotalPrice();
  }

  void increaseItemQuantity(ProductModel product) {
    product.quantity = product.quantity! + 1;

    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(ProductModel product) {
    product.quantity = product.quantity! - 1;

    calculateTotalPrice();
    update();
  }

  bool get isEmptyCart => allProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      totalPrice.value += element.quantity! * element.prixVente!;
    }
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity! > 0),
    );
  }

  getAllItems() {
    filteredProducts.assignAll(allProducts);
  }

  @override
  void onInit() {
    for (var element in allProducts) {
      cartProducts.add(element);
    }
    super.onInit();
  }
}
