import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import '../../../controller/create_post_controller.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_text.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_text_field.dart';
import 'gradient_color_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  List<List<int>> rgbColors = [
    [255, 255, 255, 255, 255, 255],
    [250, 40, 40, 255, 36, 200],
    [194, 250, 40, 83, 162, 30],
    [247, 250, 40, 207, 92, 16],
    [255, 164, 129, 203, 0, 3],
    [40, 250, 222, 16, 108, 207],
  ];
  late CreatePostController createPostController;

  @override
  void initState() {
    super.initState();
    createPostController = Get.find<CreatePostController>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColor.backGround,
          appBar: CustomAppBar(
            bgColor: AppColor.backGround,
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppText.close,
                      style: figTreeReg.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.closeColor.withValues(alpha: .7),
                          height: 1.22.h),
                    ),
                  ),
                ),
                Text(
                  AppText.createPost,
                  style: figTreeReg.copyWith(
                      fontSize: 18.sp, color: Colors.black, height: 1.22.h),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    createPostController.createPost();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppText.create,
                      style: figTreeMedium.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.purple,
                          height: 1.22.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              spacing: 20.h,
              children: [
                CustomTextField(
                  controller: createPostController.textPostController,
                  hintText: AppText.createPostHint,
                  maxLines: 6,
                  borderColor: Color(0xFFE1E1E1),
                  bgColor: AppColor.white,
                  hintStyle: figTreeReg.copyWith(
                      fontSize: 16.sp,
                      color: Color(0xFF181534).withValues(alpha: .7),
                      height: 1.22.h),
                  paddingHor: 20.w,
                  paddingVertical: 20.w,
                  textStyle: figTreeReg.copyWith(
                    fontSize: 16.sp,
                    color: Color(0xFF181534),
                  ),
                ),
                GradientColorPicker(
                  rgbColors: rgbColors,
                  tapResult: (index) {
                    createPostController.selectedColorIndex.value = index;
                  },
                )
              ],
            ),
          ),
        ),
        Obx(() {
          return createPostController.isLoading.value
              ? Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.darkCyan1,
                    ),
                  ),
                )
              : SizedBox.shrink();
        })
      ],
    );
  }
}
