import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_layout.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Function? onBackPressed;
  final Color? bgColor;
  final Color? leadingIconColor;
  final String? type;
  final String? leadingIcon;
  final bool? isNotSvg;
  final double? leadingIconSize;
  final double? leadingWidth;
  final TextStyle? textStyle;
  final Widget? action;
  final Widget? flexWidget;
  final double? preferredHeight;
  final bool centerTitle;

  const CustomAppBar(
      {super.key,
      this.title,
      this.onBackPressed,
      this.bgColor,
      this.type,
      this.textStyle,
      this.leadingIconColor,
      this.leadingIcon,
      this.action,
      this.preferredHeight,
      this.flexWidget,
      this.leadingWidth,
      this.leadingIconSize,
      this.titleWidget,
      this.isNotSvg = false,
      this.centerTitle = false,
      });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: bgColor ?? AppColor.backGround,
        statusBarIconBrightness:
            AppLayout.isColorLight(bgColor ?? AppColor.backGround)
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarIconBrightness:
            AppLayout.isColorLight(bgColor ?? AppColor.backGround)
                ? Brightness.dark
                : Brightness.light,
        systemNavigationBarColor: bgColor ?? AppColor.backGround,
      ),
      title: titleWidget ??
          Text(title ?? '',
              style: textStyle ?? figTreeReg.copyWith(fontSize: 24.sp)),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      toolbarHeight: (preferredHeight ?? 60).h,
      leading: leadingIcon != null
          ? Center(
              child: SvgPicture.asset(
                leadingIcon!,
                width: leadingIconSize ?? 22.5,
              ),
            )
          : const SizedBox(),
      backgroundColor: bgColor ?? Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leadingWidth: leadingIcon != null ? leadingWidth ?? 40 : 0,
      actions: [if (action != null) action!],
      flexibleSpace: flexWidget,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, (preferredHeight ?? 60).h);
}
