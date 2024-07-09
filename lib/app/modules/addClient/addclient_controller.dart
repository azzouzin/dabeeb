import 'package:dio/dio.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:getx_skeleton/app/data/local/shared_pref.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/data/remote/base_client.dart';
import 'package:getx_skeleton/app/modules/login/login_controller.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import '../../../utils/constants.dart';
import '../../data/models/price_category_model.dart';
import '../../data/remote/api_call_status.dart';
import '../../data/remote/error_handler.dart';

class AddClientController extends GetxController {
  ApiCallStatus apiCallStatus = ApiCallStatus.loading;
  LoginController loginController = Get.put(LoginController());

  List<PriceModel> pricesCatorgies = [];
  PriceModel? selectedPriceCategory;
  void getThePriceCategory() async {
    apiCallStatus = ApiCallStatus.loading;
    update();
    await BaseClient.safeApiCall(
      Constants.priceCategory,
      RequestType.get,
      headers: {
        'Authorization': loginController.accessToken,
      },
      onSuccess: (response) {
        for (var element in response.data) {
          pricesCatorgies.add(PriceModel.fromJson(element));
        }
        update();
      },
      onError: (p0) {
        ErrorHandler.handelError(p0);
      },
    );
    apiCallStatus = ApiCallStatus.success;
    update();
  }

  void addClient(String name, String adresse, int category) async {
    final Map<String, dynamic> headers = {
      "Authorization": SharedPref.getAuthorizationToken(),
    };

    ClientModel client =
        ClientModel(societe: name, adresse: adresse, category: category,);
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

  void changeValue(PriceModel value) {
    selectedPriceCategory = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getThePriceCategory();
  }
}
