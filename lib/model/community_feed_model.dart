import 'dart:convert';

List<CommunityFeedModel> communityFeedModelFromJson(String str) =>
    List<CommunityFeedModel>.from(
        json.decode(str).map((x) => CommunityFeedModel.fromJson(x)));

String communityFeedModelToJson(List<CommunityFeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommunityFeedModel {
  final int? id;
  final int? schoolId;
  final int? userId;
  final dynamic courseId;
  final int? communityId;
  final dynamic groupId;
  final String? feedTxt;
  final String? status;
  final String? slug;
  final String? title;
  final String? activityType;
  final int? isPinned;
  final String? fileType;
  final List<dynamic>? files;
  int? likeCount;
  int? commentCount;
  final int? shareCount;
  final int? shareId;
  final MetaDataClass? metaData;
  final String? createdAt;
  final String? updatedAt;
  final String? feedPrivacy;
  final int? isBackground;
  final String? bgColor;
  final dynamic pollId;
  final dynamic lessonId;
  final int? spaceId;
  final dynamic videoId;
  final dynamic streamId;
  final dynamic blogId;
  final dynamic scheduleDate;
  final dynamic timezone;
  final dynamic isAnonymous;
  final dynamic meetingId;
  final dynamic sellerId;
  final DateTime? publishDate;
  final bool? isFeedEdit;
  final String? name;
  final String? pic;
  final int? uid;
  final int? isPrivateChat;
  final dynamic group;
  final User? user;
  Like? like;
  List<LikeType>? likeType;
  final dynamic poll;
  final dynamic savedPosts;
  final dynamic follow;
  final List<dynamic>? comments;
  final PurpleMeta? meta;

  CommunityFeedModel({
    this.id,
    this.schoolId,
    this.userId,
    this.courseId,
    this.communityId,
    this.groupId,
    this.feedTxt,
    this.status,
    this.slug,
    this.title,
    this.activityType,
    this.isPinned,
    this.fileType,
    this.files,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.shareId,
    this.metaData,
    this.createdAt,
    this.updatedAt,
    this.feedPrivacy,
    this.isBackground,
    this.bgColor,
    this.pollId,
    this.lessonId,
    this.spaceId,
    this.videoId,
    this.streamId,
    this.blogId,
    this.scheduleDate,
    this.timezone,
    this.isAnonymous,
    this.meetingId,
    this.sellerId,
    this.publishDate,
    this.isFeedEdit,
    this.name,
    this.pic,
    this.uid,
    this.isPrivateChat,
    this.group,
    this.user,
    this.like,
    this.likeType,
    this.poll,
    this.savedPosts,
    this.follow,
    this.comments,
    this.meta,
  });

  factory CommunityFeedModel.fromJson(Map<String, dynamic> json) =>
      CommunityFeedModel(
        id: json["id"],
        schoolId: json["school_id"],
        userId: json["user_id"],
        courseId: json["course_id"],
        communityId: json["community_id"],
        groupId: json["group_id"],
        feedTxt: json["feed_txt"],
        status: json["status"],
        slug: json["slug"],
        title: json["title"],
        activityType: json["activity_type"],
        isPinned: json["is_pinned"],
        fileType: json["file_type"],
        files: json["files"] == null
            ? []
            : List<dynamic>.from(json["files"]!.map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        shareCount: json["share_count"],
        shareId: json["share_id"],
        metaData: json["meta_data"] == null
            ? null
            : MetaDataClass.fromJson(json["meta_data"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        feedPrivacy: json["feed_privacy"],
        isBackground: json["is_background"],
        bgColor: json["bg_color"],
        pollId: json["poll_id"],
        lessonId: json["lesson_id"],
        spaceId: json["space_id"],
        videoId: json["video_id"],
        streamId: json["stream_id"],
        blogId: json["blog_id"],
        scheduleDate: json["schedule_date"],
        timezone: json["timezone"],
        isAnonymous: json["is_anonymous"],
        meetingId: json["meeting_id"],
        sellerId: json["seller_id"],
        publishDate: json["publish_date"] == null
            ? null
            : DateTime.parse(json["publish_date"]),
        isFeedEdit: json["is_feed_edit"],
        name: json["name"],
        pic: json["pic"],
        uid: json["uid"],
        isPrivateChat: json["is_private_chat"],
        group: json["group"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        like: json["like"] == null ? null : Like.fromJson(json["like"]),
        likeType: json["likeType"] == null
            ? []
            : List<LikeType>.from(
                json["likeType"]!.map((x) => LikeType.fromJson(x))),
        poll: json["poll"],
        savedPosts: json["savedPosts"],
        follow: json["follow"],
        comments: json["comments"] == null
            ? []
            : List<dynamic>.from(json["comments"]!.map((x) => x)),
        meta: json["meta"] == null ? null : PurpleMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "user_id": userId,
        "course_id": courseId,
        "community_id": communityId,
        "group_id": groupId,
        "feed_txt": feedTxt,
        "status": status,
        "slug": slug,
        "title": title,
        "activity_type": activityType,
        "is_pinned": isPinned,
        "file_type": fileType,
        "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "share_count": shareCount,
        "share_id": shareId,
        "meta_data": metaData?.toJson(),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "feed_privacy": feedPrivacy,
        "is_background": isBackground,
        "bg_color": bgColor,
        "poll_id": pollId,
        "lesson_id": lessonId,
        "space_id": spaceId,
        "video_id": videoId,
        "stream_id": streamId,
        "blog_id": blogId,
        "schedule_date": scheduleDate,
        "timezone": timezone,
        "is_anonymous": isAnonymous,
        "meeting_id": meetingId,
        "seller_id": sellerId,
        "publish_date": publishDate?.toIso8601String(),
        "is_feed_edit": isFeedEdit,
        "name": name,
        "pic": pic,
        "uid": uid,
        "is_private_chat": isPrivateChat,
        "group": group,
        "user": user?.toJson(),
        "like": like?.toJson(),
        "likeType": likeType == null
            ? []
            : List<dynamic>.from(likeType!.map((x) => x.toJson())),
        "poll": poll,
        "savedPosts": savedPosts,
        "follow": follow,
        "comments":
            comments == null ? [] : List<dynamic>.from(comments!.map((x) => x)),
        "meta": meta?.toJson(),
      };
}

class Like {
  final int? id;
  final int? feedId;
  final int? userId;
  final String? reactionType;
  final String? createdAt;
  final String? updatedAt;
  final int? isAnonymous;
  final MetaDataClass? meta;

  Like({
    this.id,
    this.feedId,
    this.userId,
    this.reactionType,
    this.createdAt,
    this.updatedAt,
    this.isAnonymous,
    this.meta,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        id: json["id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        reactionType: json["reaction_type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isAnonymous: json["is_anonymous"],
        meta:
            json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feed_id": feedId,
        "user_id": userId,
        "reaction_type": reactionType,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_anonymous": isAnonymous,
        "meta": meta?.toJson(),
      };
}

class MetaDataClass {
  MetaDataClass();

  factory MetaDataClass.fromJson(Map<String, dynamic> json) => MetaDataClass();

  Map<String, dynamic> toJson() => {};
}

class LikeType {
  final String? reactionType;
  final int? feedId;
  final MetaDataClass? meta;

  LikeType({
    this.reactionType,
    this.feedId,
    this.meta,
  });

  factory LikeType.fromJson(Map<String, dynamic> json) => LikeType(
        reactionType: json["reaction_type"],
        feedId: json["feed_id"],
        meta:
            json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "reaction_type": reactionType,
        "feed_id": feedId,
        "meta": meta?.toJson(),
      };
}

class PurpleMeta {
  final int? views;

  PurpleMeta({
    this.views,
  });

  factory PurpleMeta.fromJson(Map<String, dynamic> json) => PurpleMeta(
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "views": views,
      };
}

class User {
  final int? id;
  final String? fullName;
  final String? profilePic;
  final int? isPrivateChat;
  final dynamic expireDate;
  final String? status;
  final dynamic pauseDate;
  final String? userType;
  final MetaDataClass? meta;

  User({
    this.id,
    this.fullName,
    this.profilePic,
    this.isPrivateChat,
    this.expireDate,
    this.status,
    this.pauseDate,
    this.userType,
    this.meta,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fullName: json["full_name"],
        profilePic: json["profile_pic"],
        isPrivateChat: json["is_private_chat"],
        expireDate: json["expire_date"],
        status: json["status"],
        pauseDate: json["pause_date"],
        userType: json["user_type"],
        meta:
            json["meta"] == null ? null : MetaDataClass.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "is_private_chat": isPrivateChat,
        "expire_date": expireDate,
        "status": status,
        "pause_date": pauseDate,
        "user_type": userType,
        "meta": meta?.toJson(),
      };
}
