import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/local/shared_pref.dart';
import 'package:getx_skeleton/app/data/remote/error_handler.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import 'package:logger/logger.dart';

import '../../../../utils/constants.dart';
import '../../data/models/user_model.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/base_client.dart';

class LoginController extends GetxController {
  // hold data coming from api
  UserModel? appUser;
  String? accessToken;
  // api call status
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<bool> login() async {
    apiCallStatus = ApiCallStatus.loading;
    bool isSeccssful = false;
    update();
    await BaseClient.safeApiCall(
      Constants.login,
      RequestType.post,
      data: {
        "username": usernameController.text,
        "password": passwordController.text,
      },
      onSuccess: (response) {
        final result = response.headers.map["authorization"]!.first;

        SharedPref.setAuthorizationToken(result);

        setToken(result);

        apiCallStatus = ApiCallStatus.success;
        update();
        isSeccssful = true;
        Get.toNamed(Routes.HOME);
      },
      onError: (p0) {
        p0.message = p0.message.contains("Failed host lookup")
            ? "Verifié votre connexion"
            : p0.message;
        ErrorHandler.handelError(p0);
        isSeccssful = false;
      },
    );
    return isSeccssful;
  }

  void setToken(token) {
    accessToken = token;
  }

  @override
  void onReady() {
    checkTokenAndRedircet();
    super.onReady();
  }

  void checkTokenAndRedircet() async {
    final token = SharedPref.getAuthorizationToken();
    if (token != null) {
      setToken(token);
      Get.toNamed(Routes.HOME);
    }
  }
}
