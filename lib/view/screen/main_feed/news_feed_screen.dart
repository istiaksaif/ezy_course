import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_image.dart';
import '../../../core/utils/app_text.dart';
import '../../dilaog/logout_dialog.dart';
import '../../widget/custom_app_bar.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround,
      appBar: CustomAppBar(
        bgColor: AppColor.darkCyan,
        preferredHeight: 156,
        titleWidget: Row(
          spacing: 10.w,
          children: [
            SvgPicture.asset(AppImage.icMenu),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  AppText.pythonDevCommunity,
                  style: figTreeSemiBold,
                ),
                Text(
                  '#General',
                  style: figTreeMedium.copyWith(
                      fontSize: 14.sp,
                      color: AppColor.white.withValues(alpha: .7)),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 72.h,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              offset: Offset(0, -8),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customNavItem(
              AppText.community,
              AppImage.icCommunity,
            ),
            customNavItem(
              AppText.logout,
              AppImage.icLogout,
              onTap: () {
                Get.dialog(LogoutDialog(),
                    barrierColor: AppColor.logoutText.withValues(alpha: 0.6));
              },
              textColor: AppColor.logoutText,
            ),
          ],
        ),
      ),
    );
  }

  Widget customNavItem(String name, String icon,
      {Function? onTap, Color? textColor}) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Column(
        spacing: 4.h,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          Text(
            name,
            style: figTreeBold.copyWith(color: textColor),
          )
        ],
      ),
    );
  }
}
