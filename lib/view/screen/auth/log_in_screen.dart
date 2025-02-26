import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import '../../../controller/auth_controller.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_image.dart';
import '../../../core/utils/app_layout.dart';
import '../../../core/utils/app_text.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    AppLayout.systemStatusColor(colors: Colors.transparent);
    return Stack(
      children: [
        SvgPicture.asset(
          AppImage.loginBg,
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).viewInsets.bottom > 0 ? 80.h : 138.h,
                  0,
                  MediaQuery.of(context).viewInsets.bottom > 0 ? 50.h : 0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 23.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.02),
                  borderRadius: BorderRadius.circular(10.r),
                  border:
                      Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.86.h,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 11.86.w,
                      children: [
                        SvgPicture.asset(
                          AppImage.appLogo,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: SvgPicture.asset(
                            AppImage.appName,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      AppText.appSlogan,
                      style: figTreeSemiBold.copyWith(
                          fontSize: 19.sp,
                          height: 1.47,
                          color: AppColor.yellow),
                    )
                  ],
                ),
              ),
              Flexible(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.fromLTRB(24.h, 35.h, 24.w, 0),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                    border: Border(
                      top: BorderSide(
                        width: 4.h,
                        color: AppColor.darkCyan,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 7.h,
                      children: [
                        Center(
                          child: Text(
                            AppText.signIn,
                            style: figTreeSemiBold.copyWith(fontSize: 38.sp),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          AppText.email,
                          style: figTreeMedium,
                        ),
                        Obx(() {
                          return CustomTextField(
                            hintText: AppText.email,
                            controller: authController.textEmailController,
                            focusNode: authController.emailFocus,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r"[a-zA-Z0-9@._-]"),
                              ),
                            ],
                            errorText: authController.errorEmail.value,
                            textInputAction: TextInputAction.next,
                          );
                        }),
                        SizedBox(
                          height: 14.h,
                        ),
                        Text(
                          AppText.password,
                          style: figTreeMedium,
                        ),
                        Obx(() {
                          return CustomTextField(
                            hintText: AppText.password,
                            password: true,
                            controller: authController.textPasswordController,
                            focusNode: authController.passwordFocus,
                            errorText: authController.errorPassword.value,
                          );
                        }),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          spacing: 6.w,
                          children: [
                            Obx(() {
                              return InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  authController.isAgree.value =
                                      !authController.isAgree.value;
                                },
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    border: Border.all(
                                      color: AppColor.lightWhite,
                                      width:
                                          authController.isAgree.value ? 0 : 1,
                                    ),
                                    color: authController.isAgree.value
                                        ? AppColor.white
                                        : Colors.transparent,
                                  ),
                                  child: authController.isAgree.value
                                      ? Icon(
                                          Icons.check,
                                          color: AppColor.darkCyan,
                                          size: 12,
                                        )
                                      : null,
                                ),
                              );
                            }),
                            Text(
                              AppText.rememberMe,
                              style: figTreeReg.copyWith(
                                  fontSize: 18.sp, color: AppColor.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Obx(() {
                          return CustomButton(
                            title: AppText.login,
                            isLoading: authController.isLoading.value,
                            onTap: () {
                              authController.login();
                            },
                          );
                        }),
                        SizedBox(
                          height: 65.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
