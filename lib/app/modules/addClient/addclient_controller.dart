import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:getx_skeleton/app/data/local/shared_pref.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:logger/logger.dart';

import '../../../utils/constants.dart';
import '../../data/remote/error_handler.dart';

class AddClientController extends GetxController {
  void addClient(String name, String adresse, int category) async {
    final Map<String, dynamic> headers = {
      "Authorization": SharedPref.getAuthorizationToken(),
    };

    ClientModel client =
        ClientModel(societe: name, adresse: adresse, category: category);
    await BaseClient.safeApiCall(
      Constants.addclient,
      RequestType.post,
      headers: headers,
      data: client.toJson(),
      onSuccess: (response) => addedClientSeccssful(response),
      onError: (p0) => ErrorHandler.handelError(p0),
    );
  }

  void addedClientSeccssful(Response response) {
    final ClientModel myclient = ClientModel.fromJson(response.data);
    Get.toNamed(Routes.BARCODESCANNER, arguments: {"client": myclient});
  }

  @override
  void onInit() {
    super.onInit();
  }
}
