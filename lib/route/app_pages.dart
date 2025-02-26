import 'package:get/route_manager.dart';
import '../view/screen/auth/log_in_screen.dart';
import '../view/screen/main_feed/news_feed_screen.dart';
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
      name: Routes.newsFeedRoute,
      page: () => const NewsFeedScreen(),
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
