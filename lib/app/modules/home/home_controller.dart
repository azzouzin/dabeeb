import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';

import '../../data/remote/api_call_status.dart';

class HomeController extends GetxController {
  // hold data coming from api
  List<ClientModel> clients = List.generate(
      10,
      (i) => ClientModel(
            id: i + 1,
            name: 'name $i',
            phone: 'phone $i',
            address: 'address $i',
            email: 'email $i',
          ));

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  // getting data from api
  Future<void> getClients() async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    await Future.delayed(Duration(seconds: 2));
    apiCallStatus = ApiCallStatus.success;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getClients();
  }
}
