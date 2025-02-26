import 'package:get/state_manager.dart';

import '../core/api/api_client.dart';

class AuthController extends GetxController {
  final ApiClient? apiClient;

  AuthController({required this.apiClient});

}