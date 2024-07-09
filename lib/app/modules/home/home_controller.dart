import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/modules/cart/view/cart_view.dart';
import 'package:getx_skeleton/app/modules/login/login_controller.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../utils/constants.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/error_handler.dart';

class HomeController extends GetxController {
  LoginController loginController = Get.put(LoginController());
  int pageIndicator = 0;
  TextEditingController searchController = TextEditingController();
  // hold data coming from api
  List<ClientModel> clients = [];
  final PagingController<int, ClientModel> paginationController =
      PagingController(firstPageKey: 0);

  bool isFinished = false;
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.success;

  // getting data from api
  Future getClients(String keyword, int page) async {
    // apiCallStatus = ApiCallStatus.loading;
    // update();
    Logger().wtf("$keyword $page");
    await BaseClient.safeApiCall(
        "${Constants.clients}/?keyword=$keyword&page=$page&size=15&sort=id,desc&idRegion=0&idLivreur=0&credit=0&echaience=false&idActivity=0",
        RequestType.get,
        headers: {
          'Authorization': loginController.accessToken
        }, onSuccess: (response) {
      for (var element in response.data['content']) {
        clients.add(ClientModel.fromJson(element));
      }
      pageIndicator++;
      if (response.data['content'].isEmpty) {
        isFinished = true;
      }
      update();
    }, onError: (p0) {
      ErrorHandler.handelError(p0);
    });
    apiCallStatus = ApiCallStatus.success;
    update();
  }

  void searchWordChanged(String keyword) {
    pageIndicator = 0;
    isFinished = false;
    clients.clear();
    getClients(keyword, pageIndicator);
  }

  Future fetchClients() async {
    isFinished = false;
    pageIndicator = 0;
    clients.clear();
    await getClients(searchController.text, pageIndicator);
  }

  @override
  void onInit() {
    // getClients("", pageIndicator);
    paginationController.addPageRequestListener((pageKey) {
      getClients(searchController.text, pageKey);
    });
    super.onInit();
  }
}
