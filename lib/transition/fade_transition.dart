import 'package:get/route_manager.dart';

class FadeScreenTransition {
  final String routeName;
  final dynamic arguments;
  final Map<String, String>? params;
  final bool? replace;
  final bool? removeCurrentScreen;

  const FadeScreenTransition({
    required this.routeName,
    this.arguments,
    this.params,
    this.replace,
    this.removeCurrentScreen,
  });

  void navigate() {
    if (replace ?? false) {
      Get.offAllNamed(
        routeName,
        arguments: arguments,
        parameters: params,
      );
    } else if (removeCurrentScreen ?? false) {
      Get.offAndToNamed(
        routeName,
        arguments: arguments,
        parameters: params,
      );
    } else {
      Get.toNamed(
        routeName,
        arguments: arguments,
        parameters: params,
      );
    }
  }
}

