import 'package:ezy_course/view/widget/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../controller/community_feed_controller.dart';
import '../../core/utils/_constant.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_fonts.dart';
import '../../core/utils/app_image.dart';
import '../../core/utils/app_text.dart';
import '../../core/utils/image_loader.dart';
import '../../model/comment_model.dart';
import '../../model/community_feed_model.dart';
import '../widget/custom_button.dart';

class CommentBottomSheet extends StatefulWidget {
  final CommunityFeedModel feedItem;
  final List<String> uniqueReactions;

  const CommentBottomSheet(
      {super.key, required this.feedItem, required this.uniqueReactions});

  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  late CommunityFeedController communityFeedController;

  @override
  void initState() {
    super.initState();
    communityFeedController = Get.find<CommunityFeedController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: widget.uniqueReactions.map((reactionType) {
                    return SvgPicture.asset(
                      Constant.getReactionAsset(reactionType),
                      height: 18.h,
                    );
                  }).toList(),
                ),
                SizedBox(width: 4),
                Text(
                  widget.feedItem.user?.id == widget.feedItem.like?.userId
                      ? (widget.feedItem.likeCount == 1
                          ? 'You'
                          : 'You and ${widget.feedItem.likeCount} other${(widget.feedItem.likeCount ?? 0) > 1 ? 's' : ''}')
                      : '${widget.feedItem.likeCount} other${(widget.feedItem.likeCount ?? 0) > 1 ? 's' : ''}',
                  style: figTreeSemiBold.copyWith(
                      fontSize: 14.sp,
                      height: 1.09,
                      color: AppColor.textColor2),
                ),
              ],
            ),
            SizedBox(
              height: 35.h,
            ),
            //comment tree
            Obx(() {
              return _buildCommentTree(communityFeedController.listOfComment);
            }),
            ClipRRect(
              borderRadius: BorderRadius.circular(90.r),
              child: Container(
                height: 60.h,
                padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
                color: AppColor.commentCardBg,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    ImageLoader(
                      url: '',
                      isProfile: true,
                      size: 44.h,
                      radius: 44.r,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: CustomTextField(
                          controller:
                              communityFeedController.textCommentController,
                          paddingHor: 13.w,
                          paddingVertical: 0,
                          borderWidth: 0,
                          bgColor: Colors.transparent,
                          textStyle: figTreeReg.copyWith(
                              fontSize: 18.sp, color: AppColor.textColor),
                          hintText: AppText.writeComment,
                          hintStyle: figTreeReg.copyWith(
                              fontSize: 18.sp, color: AppColor.hintTextColor),
                        ),
                      ),
                    ),
                    CustomButton(
                      radius: 0,
                      svgIcon: AppImage.icSent,
                      width: 63.w,
                      height: 60.h,
                      bgColor: AppColor.darkCyan1,
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        communityFeedController.createComment(
                            widget.feedItem.id, widget.feedItem.userId);
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentTree(List<CommentModel> comments) {
    return Expanded(
      child: ListView.builder(
        itemCount: comments.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          CommentModel comment = comments[index];
          return _buildCommentItem(
              commentModel: comment, replies: comment.replies ?? []);
        },
      ),
    );
  }

  Widget _buildCommentItem(
      {required CommentModel commentModel,
      required List<CommentModel> replies,
      bool isReply = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15.h,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageLoader(
              url: commentModel.user?.profilePic ?? '',
              isProfile: true,
              size: (isReply ? 36 : 54).w,
              radius: (isReply ? 36 : 54).r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColor.commentCardBg,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 7.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commentModel.user?.fullName ?? '',
                            style: figTreeSemiBold.copyWith(
                              fontSize: 16.sp,
                              height: 0.96,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            commentModel.commentTxt ?? '',
                            style: figTreeReg.copyWith(
                              fontSize: 16.sp,
                              height: 0.96,
                              color: AppColor.commentText.withValues(alpha: .9),
                            ),
                          ),
                          SizedBox(
                            height: 1,
                          )
                        ],
                      ),
                    ),
                    Transform.rotate(
                      angle: 3.1416 * 1.5,
                      child: SvgPicture.asset(
                        AppImage.icDotMenu,
                        height: 22.h,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: (isReply ? 64 : 84).w, bottom: 15.h),
          child: Row(
            children: [
              Text(
                Constant.getTimeAgoShort(commentModel.createdAt),
                style: figTreeReg.copyWith(
                  fontSize: 14.sp,
                  height: 1.09,
                  color: AppColor.commentText,
                ),
              ),
              SizedBox(width: 22.w),
              Text(
                "Like",
                style: figTreeMedium.copyWith(
                  fontSize: 14.sp,
                  height: 1.09,
                  color: (commentModel.likeCount ?? 0) > 0
                      ? AppColor.purple
                      : AppColor.commentText,
                ),
              ),
              SizedBox(width: 22.w),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  if (communityFeedController.parentId.value ==
                      commentModel.id) {
                    communityFeedController.parentId.value = -1;
                  } else {
                    communityFeedController.parentId.value = commentModel.id!;
                  }
                },
                child: Obx(() {
                  return Text(
                    "Reply",
                    style: figTreeReg.copyWith(
                      fontSize: 14.sp,
                      height: 1.09,
                      color: (communityFeedController.parentId.value ==
                              commentModel.id)
                          ? AppColor.purple
                          : AppColor.commentText,
                    ),
                  );
                }),
              ),
              Spacer(),
              if ((commentModel.likeCount ?? 0) > 0)
                Row(
                  spacing: 6.w,
                  children: [
                    Text(
                      (commentModel.likeCount ?? 0).toString(),
                      style: figTreeSemiBold.copyWith(
                        fontSize: 18.sp,
                        height: 1.09,
                        color: AppColor.commentText,
                      ),
                    ),
                    SvgPicture.asset(AppImage.icLike, height: 16.h),
                  ],
                ),
            ],
          ),
        ),
        if (replies.isNotEmpty)
          ListView.builder(
            itemCount: replies.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 50.w),
            itemBuilder: (context, index) {
              CommentModel comment = replies[index];
              return _buildCommentItem(
                  commentModel: comment,
                  replies: comment.replies ?? [],
                  isReply: true);
            },
          )
      ],
    );
  }
}
