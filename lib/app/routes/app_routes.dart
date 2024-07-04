    import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
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
      page: () => const AddClientView(),
      binding: AddClientBinding(),
    ),
   ];
}
