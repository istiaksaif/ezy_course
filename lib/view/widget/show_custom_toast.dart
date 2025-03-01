import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/utils/app_image.dart';
import '../../main.dart';

void showCustomToast(String message, {int duration = 2}) {
  FToast fToast = FToast();
  fToast.init(navigatorKey.currentState!.overlay!.context);

  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    margin: EdgeInsets.symmetric(horizontal: 30.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: const Color(0xFF1C2243),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppImage.appLogo,
          height: 14.h,
        ),
        SizedBox(width: 12.w),
        Flexible(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: figTreeReg.copyWith(fontSize: 16.sp),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: duration),
  );
}
