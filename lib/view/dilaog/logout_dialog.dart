import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../controller/auth_controller.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_text.dart';
import '../widget/custom_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 26.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      backgroundColor: AppColor.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 27.h, 20.w, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppText.logout,
              style: figTreeBold.copyWith(
                  fontSize: 28.sp, color: AppColor.navyBlue, height: 1.2.h),
            ),
            SizedBox(height: 13.h),
            Text(
              "Are you sure, you want to log\nout?",
              textAlign: TextAlign.center,
              style: figTreeMedium.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.lightNavyBlue,
                  height: 1.2.h),
            ),
            SizedBox(height: 34.h),
            Divider(
              thickness: 1,
              color: AppColor.lineColor,
              height: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return CustomButton(
                      title: AppText.yes,
                      isLoading: Get.find<AuthController>().isLoading.value,
                      titleStyle: figTreeMedium.copyWith(
                          fontSize: 20.sp,
                          color: AppColor.purpleBlue,
                          height: 1.2.h),
                      onTap: () {
                        Get.find<AuthController>().logout();
                      },
                      bgColor: Colors.transparent,
                      radius: 0,
                    );
                  }),
                ),
                Container(width: 1, height: 70.h, color: AppColor.lineColor),
                Expanded(
                  child: CustomButton(
                    title: AppText.no,
                    titleStyle: figTreeMedium.copyWith(
                        fontSize: 20.sp, color: AppColor.grey, height: 1.2.h),
                    onTap: () {
                      Get.back();
                    },
                    bgColor: Colors.transparent,
                    radius: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
