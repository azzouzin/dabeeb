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
      title: 'Error 403',
      message: "Mot de passe incorrect ou utilisateur inexistant",
    );
  }

  static handel404Error(ApiException apiException) {
    String message = apiException.response!.data['message'];
    CustomSnackBar.showCustomErrorSnackBar(
      title: 'Error 404',
      message: apiException.message ?? 'Error',
    );
  }

  static handel500Error(ApiException apiException) {
    apiException.message = apiException.message.contains("Failed host lookup")
        ? "Verifié votre connexion"
        : apiException.message;
    String message = apiException.message;

    CustomSnackBar.showCustomErrorSnackBar(
        title: "Impossible d'accéder au serveur", message: message ?? 'Error');
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
