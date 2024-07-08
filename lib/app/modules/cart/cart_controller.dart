import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/base_client.dart';

class CartController extends GetxController {
  // hold data coming from api
  List<dynamic>? data;

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  // getting data from api

  @override
  void onInit() {
    super.onInit();
  }
}
