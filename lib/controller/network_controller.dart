import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../core/api/api_retry_manager.dart';
import '../view/widget/show_custom_toast.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      _checkConnection();
    });
    Connectivity().onConnectivityChanged.listen((_) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    bool hasInternet = await InternetConnection().hasInternetAccess;
    if (!hasInternet && isConnected.value) {
      isConnected.value = false;
      showCustomToast('No internet connection');
    } else if (hasInternet && !isConnected.value) {
      showCustomToast('Back online');
      isConnected.value = true;
      apiRetryManager.retryPending();
      Get.back();
    }
  }

  void _retryConnection() async {
    _checkConnection();
  }
}
