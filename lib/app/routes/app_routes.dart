import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/view/home_view.dart';
import 'routes.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/view/login_view.dart';
import 'routes.dart';
import '../modules/barcodescanner/barcodescanner_binding.dart';
import '../modules/barcodescanner/barcodescanner_view.dart';
import 'routes.dart';
import '../modules/addclient/addclient_binding.dart';
import '../modules/addclient/addclient_view.dart';
import 'routes.dart';
import '../modules/cart/cart_binding.dart';
import '../modules/cart/view/cart_view.dart';
import 'routes.dart';
import '../modules/productlist/productlist_binding.dart';
import '../modules/productlist/productlist_view.dart';
import 'routes.dart';
import '../modules/productdetails/productdetails_binding.dart';
import '../modules/productdetails/productdetails_view.dart';
import 'routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.BARCODESCANNER,
      page: () => const BarCodeScannerView(),
      binding: BarCodeScannerBinding(),
    ),
    GetPage(
      name: Routes.ADDCLIENT,
      page: () => AddClientView(),
      binding: AddClientBinding(),
    ),
    GetPage(
      name: Routes.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTLIST,
      page: () => const ProductlistView(),
      binding: ProductlistBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTDETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
  ];
}
