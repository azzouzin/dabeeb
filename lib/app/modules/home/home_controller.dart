import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/modules/login/login_controller.dart';
import 'package:logger/logger.dart';

import '../../../utils/constants.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/error_handler.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  int pageIndicator = 1;
  TextEditingController searchController = TextEditingController();
  // hold data coming from api
  List<ClientModel> clients = List.generate(
    10,
    (i) => ClientModel(
      id: i + 1,
      societe: 'name $i',
      mobileId: i,
      adresse: 'address $i',
      email: 'email $i',
    ),
  );

  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  // getting data from api
  void getClients(String keyword, int page) async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    BaseClient.safeApiCall(
      "${Constants.clients}/?keyword=$keyword&page=$page&size=15&sort=id,desc&idRegion=0&idLivreur=0&credit=0&echaience=false&idActivity=0",
      RequestType.get,
      headers: {
        'Authorization': loginController.accessToken,
      },
      onSuccess: (response) {
        for (var element in response.data['content']) {
          clients.add(ClientModel.fromJson(element));
          Logger().i(clients.last.societe);
        }
        pageIndicator++;
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
    clients.clear();
    getClients(keyword, pageIndicator);
  }

  @override
  void onInit() {
    super.onInit();
    getClients("", pageIndicator);
  }
}
