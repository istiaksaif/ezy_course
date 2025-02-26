import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/instance_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'controller/auth_controller.dart';
import 'core/api/api_client.dart';
import 'core/api/api_config.dart';
import 'core/api/api_retry_manager.dart';
import 'core/utils/app_color.dart';
import 'core/utils/app_layout.dart';
import 'core/utils/session_manager.dart';
import 'route/app_pages.dart';
import 'route/app_routes.dart';

final ApiRetryManager apiRetryManager = ApiRetryManager();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await SessionManager.init();

  ApiClient myApiClient = ApiClient(appBaseUrl: ApiConfig.baseUrl);

  Get.lazyPut<AuthController>(() => AuthController(apiClient: myApiClient),
      fenix: true);

  // Get.put(NetworkController());
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    AppLayout.screenPortrait(context, colors: AppColor.backGround);
    bool isLoggedIn = SessionManager.getValue(kIsLOGIN, value: false);

    return ScreenUtilInit(
      designSize: const Size(440, 945),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1)),
          child: GetMaterialApp(
            navigatorKey: navigatorKey,
            builder: FToastBuilder(),
            debugShowCheckedModeBanner: false,
            initialRoute: isLoggedIn ? Routes.newsFeedRoute : Routes.loginRoute,
            getPages: AppPages.routes,
            theme: ThemeData(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColor.darkCyan,
                selectionHandleColor: AppColor.textColor,
                selectionColor: AppColor.btnColor.withValues(alpha: 0.4),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _isBackgrounded = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _isBackgrounded = true;
    } else if (state == AppLifecycleState.detached) {
      if (_isBackgrounded) {
        _restartApp();
      }
      _isBackgrounded = false;
    }
  }

  Future<void> _restartApp() async {
    runApp(const MyApp());
  }
}
