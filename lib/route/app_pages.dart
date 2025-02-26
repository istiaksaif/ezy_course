import 'package:get/route_manager.dart';
import '../view/auth/log_in_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.loginRoute,
      page: () => const LogInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.homeRoute,
      page: () => const LogInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.addPostRoute,
      page: () => const LogInScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
