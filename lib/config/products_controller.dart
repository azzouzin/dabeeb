import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../app/data/models/product_model.dart';
import '../utils/app_data.dart';

class ProductController extends GetxController {
  List<ProductModel> allProducts = AppData.products;
  RxList<ProductModel> filteredProducts = AppData.products.obs;
  RxList<ProductModel> cartProducts = <ProductModel>[].obs;
  RxInt totalPrice = 0.obs;

  void isFavorite(int index) {
    filteredProducts[index].isFavorite = !filteredProducts[index].isFavorite;
    update();
  }

  void addToCart(ProductModel product) {
    product.quantity++;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);
    calculateTotalPrice();
  }

  void increaseItemQuantity(ProductModel product) {
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(ProductModel product) {
    product.quantity--;
    calculateTotalPrice();
    update();
  }

  bool isPriceOff(ProductModel product) => product.off != null;

  bool get isEmptyCart => allProducts.isEmpty;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      if (isPriceOff(element)) {
        totalPrice.value += element.quantity * element.off!;
      } else {
        totalPrice.value += element.quantity * element.price;
      }
    }
  }

  getFavoriteItems() {
    filteredProducts.assignAll(
      allProducts.where((item) => item.isFavorite),
    );
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
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
