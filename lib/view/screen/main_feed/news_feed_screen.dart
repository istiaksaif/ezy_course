import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:ezy_course/core/utils/app_layout.dart';
import 'package:ezy_course/transition/fade_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../controller/community_feed_controller.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_image.dart';
import '../../../core/utils/app_text.dart';
import '../../../core/utils/image_loader.dart';
import '../../../model/community_feed_model.dart';
import '../../../route/app_routes.dart';
import '../../dilaog/logout_dialog.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/home/post_card.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  late CommunityFeedController communityFeedController;

  @override
  void initState() {
    super.initState();
    communityFeedController = Get.find<CommunityFeedController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backGround,
      appBar: CustomAppBar(
        bgColor: AppColor.darkCyan,
        preferredHeight: (156.0 - AppLayout.getStatusBarHeight(context)),
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
      body: RefreshIndicator(
        onRefresh: () async {
          return await communityFeedController.fetchCommunityFeed(
              isReload: true);
        },
        backgroundColor: AppColor.backGround,
        color: AppColor.darkCyan,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  const FadeScreenTransition(
                    routeName: Routes.addPostRoute,
                  ).navigate();
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(25.w, 18.h, 25.w, 30.h),
                  padding: EdgeInsets.fromLTRB(12.w, 12.h, 20.w, 12.h),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColor.darkCyan1.withValues(alpha: .2),
                    ),
                  ),
                  child: Row(
                    spacing: 14.w,
                    children: [
                      ImageLoader(
                        url: '',
                        height: 60.h,
                        width: 54.w,
                        isProfile: true,
                        radius: 4.r,
                      ),
                      Expanded(
                        child: Text(
                          AppText.writeSomething,
                          style: figTreeReg.copyWith(
                            fontSize: 18.sp,
                            height: 1.22,
                            color: AppColor.hintTextColor,
                          ),
                        ),
                      ),
                      CustomButton(
                        title: 'Post',
                        titleStyle: figTreeSemiBold.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.white,
                          height: 1.43.h,
                        ),
                        radius: 4.r,
                        bgColor: AppColor.darkCyan1,
                        borderColor: AppColor.darkCyan1,
                        height: 36.h,
                        width: 60.w,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Skeletonizer(
                  enabled: communityFeedController.listOfFeed.isEmpty,
                  enableSwitchAnimation: true,
                  ignorePointers: false,
                  effect: PulseEffect(
                    from: Colors.grey[350]!,
                    to: Colors.grey[100]!,
                    duration: const Duration(seconds: 1),
                  ),
                  child: ListView.builder(
                    // controller: myPostController.scrollController.value,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: communityFeedController.listOfFeed.isNotEmpty
                        ? communityFeedController.listOfFeed.length
                        : 4,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    itemBuilder: (context, index) {
                      CommunityFeedModel feedItem = CommunityFeedModel();
                      if (communityFeedController.listOfFeed.isNotEmpty) {
                        feedItem = communityFeedController.listOfFeed[index];
                      }
                      return PostCard(
                        feedItem: feedItem,
                        tapReaction: (type){
                          communityFeedController.updateReaction(feedItem.id, type,feedItem.userId);
                        },
                        tapComment: (){
                          communityFeedController.fetchComment(feedItem.id);
                        },
                      );
                    },
                  ),
                );
              }),
            ],
          ),
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
