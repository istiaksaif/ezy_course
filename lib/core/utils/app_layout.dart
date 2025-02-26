import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_color.dart';

class AppLayout {

  static getStatusBarHeight(BuildContext context,[dynamic extra]) {
    dynamic extraHeight =0;
    if(extra!=null){
      extraHeight = extra;
    }
    return MediaQuery.of(context).padding.top+extraHeight;
  }

  static screenPortrait(BuildContext context,{Color? colors}) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    systemStatusColor(context:context,colors:colors??Colors.transparent);
  }

  static systemStatusColor({BuildContext? context, Color? colors,Color? bottomColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colors??AppColor.backGround,
      statusBarIconBrightness: isColorLight(AppColor.backGround)?Brightness.dark:Brightness.light,
      systemNavigationBarIconBrightness: isColorLight(AppColor.backGround)?Brightness.dark:Brightness.light,
      systemNavigationBarColor:bottomColor??
          AppColor.backGround,
    ));
  }

  static bool isColorLight(Color colors) {
    double luminance = colors.computeLuminance();
    return luminance > 0.5;
  }

}
