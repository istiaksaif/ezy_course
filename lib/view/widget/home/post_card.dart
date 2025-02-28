import 'package:ezy_course/core/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/_constant.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/utils/app_image.dart';
import '../../../core/utils/image_loader.dart';
import '../../../model/community_feed_model.dart';
import '../../dilaog/comment_bottom_sheet.dart';

class PostCard extends StatefulWidget {
  final Function tapReaction;
  final Function tapComment;
  final CommunityFeedModel feedItem;

  const PostCard(
      {super.key,
      required this.feedItem,
      required this.tapReaction,
      required this.tapComment});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final List<String> uniqueReactions = (widget.feedItem.likeType != null &&
            widget.feedItem.likeType!.isNotEmpty)
        ? widget.feedItem.likeType!
            .map((reaction) => reaction.reactionType ?? '')
            .toSet()
            .toList()
        : ['like'];

    return Padding(
      padding: EdgeInsets.only(bottom: 35.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ImageLoader(
                url: widget.feedItem.user?.profilePic ?? '',
                radius: 34,
                size: 34,
                isProfile: true,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  spacing: 6.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feedItem.user?.fullName ?? '______ _',
                      style: figTreeSemiBold.copyWith(
                          color: AppColor.textColor1,
                          fontSize: 16.sp,
                          height: 0.96),
                    ),
                    Text(
                      Constant.getTimeAgo(widget.feedItem.publishDate),
                      style: figTreeReg.copyWith(
                          color: AppColor.secTextColor,
                          fontSize: 14.sp,
                          height: 0.914),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                AppImage.icDotMenu,
              )
            ],
          ),
          Divider(
            color: AppColor.cardStockColor,
            height: 18,
            thickness: .64,
          ),
          Linkify(
            onOpen: (link) async {
              if (!await launchUrl(Uri.parse(link.url))) {}
            },
            text: widget.feedItem.feedTxt ?? '____',
            style: figTreeReg.copyWith(
                fontSize: 14.sp, height: 1.63.h, color: AppColor.logoutText),
            linkStyle: figTreeMedium.copyWith(
              fontSize: 14.sp,
              height: 1.63.h,
              color: AppColor.purple,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.purple,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          ImageLoader(
            url: widget.feedItem.pic ?? '',
            width: double.infinity,
            radius: 3.2.r,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Row(
                children: [
                  Row(
                    children: uniqueReactions.map((reactionType) {
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
              Spacer(),
              Row(
                children: [
                  SvgPicture.asset(
                    AppImage.icComment,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "${widget.feedItem.commentCount} Comment${(widget.feedItem.commentCount ?? 0) > 1 ? 's' : ''}",
                    style: figTreeSemiBold.copyWith(
                        fontSize: 14.sp,
                        height: 1.09,
                        color: AppColor.textColor2),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 23.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.tapReaction('LIKE');
                },
                onLongPress: () async {
                  RenderBox box = context.findRenderObject() as RenderBox;
                  Offset position = box.localToGlobal(Offset.zero);

                  Get.dialog(
                    Stack(
                      children: [
                        Positioned(
                          left: position.dx,
                          top: position.dy + 250.h,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              padding: EdgeInsets.all(16.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                spacing: 6.w,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('LIKE');
                                    },
                                    child: SvgPicture.asset(AppImage.icLike),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('LOVE');
                                    },
                                    child: SvgPicture.asset(AppImage.icLove),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('CARE');
                                    },
                                    child: SvgPicture.asset(AppImage.icCare),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('HAHA');
                                    },
                                    child: SvgPicture.asset(AppImage.icHaha),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('WOW');
                                    },
                                    child: SvgPicture.asset(AppImage.icWow),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('SAD');
                                    },
                                    child: SvgPicture.asset(AppImage.icSad),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                      widget.tapReaction('ANGRY');
                                    },
                                    child: SvgPicture.asset(AppImage.icAngry),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  spacing: 6.w,
                  children: [
                    SvgPicture.asset(
                      Constant.getReactionAsset(
                          widget.feedItem.like?.reactionType ?? 'thumb'),
                      height: 18.h,
                    ),
                    Text(
                      widget.feedItem.like?.reactionType ?? 'Like',
                      style: figTreeBold.copyWith(
                        fontSize: 14.sp,
                        color: Constant.getReactionColor(
                            widget.feedItem.like?.reactionType ?? 'thumb'),
                        height: 1.09,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  widget.tapComment();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColor.white,
                    barrierColor: AppColor.logoutText.withValues(alpha: .7),
                    scrollControlDisabledMaxHeightRatio: .8,
                    transitionAnimationController: AnimationController(
                      vsync: this,
                      duration: Duration(milliseconds: 300),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: .85.sh,
                    ),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return CommentBottomSheet(
                        feedItem: widget.feedItem,
                        uniqueReactions: uniqueReactions,
                      );
                    },
                  );
                },
                child: Row(
                  spacing: 6.w,
                  children: [
                    SvgPicture.asset(AppImage.icCommentFill),
                    Text(
                      "Comment",
                      style: figTreeBold.copyWith(
                          fontSize: 14.sp,
                          color: AppColor.textColor3,
                          height: 1.09),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
