import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../core/utils/app_text.dart';
import '../core/utils/session_manager.dart';
import '../model/login_model.dart';
import '../route/app_routes.dart';
import '../transition/fade_transition.dart';
import '../view/widget/show_custom_toast.dart';

class AuthController extends GetxController {
  final ApiClient apiClient;

  AuthController({required this.apiClient});

  @override
  void onInit() {
    super.onInit();
    textEmailController.addListener(_checkProfileNotEmpty);
    textPasswordController.addListener(_checkProfileNotEmpty);
    textEmailController.text = SessionManager.getValue(kEmail, value: '');
    textPasswordController.text = SessionManager.getValue(kPassword, value: '');
    isAgree.value = SessionManager.getValue(kRemember, value: false);
  }

  void _checkProfileNotEmpty() {
    if (textEmailController.text.isNotEmpty) {
      errorEmail.value = '';
    }
    if (textPasswordController.text.isNotEmpty) {
      errorPassword.value = '';
    }
  }

  var isAgree = false.obs;
  var isLoading = false.obs;
  var textEmailController = TextEditingController();
  var textPasswordController = TextEditingController();

  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();

  void unFocus() {
    emailFocus.unfocus();
    passwordFocus.unfocus();
  }

  Future<void> login() async {
    unFocus();
    isLoading.value = true;
    bool isValid = await validation();
    if (!isValid) {
      isLoading.value = false;
      return;
    }

    try {
      var body = {
        "email": textEmailController.text.toString(),
        "password": textPasswordController.text.toString(),
        "app_token": '',
      };
      Response response = await apiClient.postData(ApiConfig.loginUrl, body);
      LoginModel loginModel = loginModelFromJson(response.body);
      if (response.statusCode == 200) {
        apiClient.updateHeader(token: loginModel.token);
        SessionManager.setValue(kToken, loginModel.token);
        SessionManager.setValue(kIsLOGIN, true);
        if (isAgree.value) {
          SessionManager.setValue(kRemember, true);
          SessionManager.setValue(kEmail, textEmailController.text);
          SessionManager.setValue(kPassword, textPasswordController.text);
        } else {
          SessionManager.setValue(kRemember, false);
          SessionManager.setValue(kEmail, '');
          SessionManager.setValue(kPassword, '');
        }
        const FadeScreenTransition(
          replace: true,
          routeName: Routes.newsFeedRoute,
        ).navigate();
      } else {
        showCustomToast(loginModel.msg ?? 'Something went wrong!');
      }
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }

  var errorEmail = ''.obs;
  var errorPassword = ''.obs;

  Future<bool> validation() async {
    bool isValid = true;

    if (textEmailController.text.trim().isEmpty) {
      errorEmail.value = AppText.enterYourEmail;
      isValid = false;
    } else {
      errorEmail.value = '';
    }

    if (textPasswordController.text.trim().isEmpty) {
      errorPassword.value = AppText.errorPasswordMsg;
      isValid = false;
    } else {
      errorPassword.value = '';
    }

    return isValid;
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      Response response = await apiClient.postData(
        ApiConfig.logoutUrl,
        {},
      );
      if (response.statusCode == 200) {
        Get.back();
        SessionManager.logout();
        apiClient.removeToken();
        const FadeScreenTransition(
          routeName: Routes.loginRoute,
          replace: true,
        ).navigate();
      } else {
        LoginModel responseModel = loginModelFromJson(response.body);
        showCustomToast(responseModel.msg ?? 'Something went wrong!');
      }
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }
}
