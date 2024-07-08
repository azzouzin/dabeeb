import 'package:getx_skeleton/app/components/custom_snackbar.dart';
import 'package:getx_skeleton/app/data/remote/api_exceptions.dart';
import 'package:logger/logger.dart';

class ErrorHandler {
  static handelError(ApiException apiException) {
    Logger().e(apiException.message.toString());
    switch (apiException.statusCode) {
      case 401:
        handel404Error(apiException);
      case 403:
        handel403Error(apiException);
        break;
      case 404:
        handel404Error(apiException);
        break;
      case 422:
        handel422Error(apiException);
      case 500:
        handel500Error(apiException);
        break;
      default:
        handel500Error(apiException);
    }
  }

  static handel403Error(ApiException apiException) {
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'خطا 403',
      message: "كلمة المرور او اسم المستخدم غير صحيحة",
    );
  }

  static handel404Error(ApiException apiException) {
    String message = apiException.response!.data['message'];
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'خطا',
      message: apiException.message ?? 'خطا',
    );
  }

  static handel500Error(ApiException apiException) {
    print(apiException.response!.data['message']);
    print("Handeling 500 error");
    String message = apiException.response!.data['message'];
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'خطا',
      message: message ?? 'خطا',
    );
  }

/*
  static handel422Error(ApiException apiException) {
    String message = "Error";
    Map<String, dynamic> response = apiException.response!.data;
    if (response['errors'].containsKey("email")) {
      message = response['errors']['email'][0];
    }
    if (response['errors'].containsKey("password")) {
      message = response['errors']['password'][0];
    }
    CustomSnackBar.showErrorDialog(message);
  }*/
  static handel422Error(ApiException apiException) {
    String message = 'R';
    apiException.response!.data['errors'] != null
        ? apiException.response!.data['errors'].forEach((key, value) {
            message = value[0];
          })
        : message = apiException.response!.data['message'];

    CustomSnackBar.showCustomErrorSnackBar(
      title: 'خطا',
      message: message,
    );
  }
  // Todo handel 422 + 401
}
