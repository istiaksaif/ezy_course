import 'dart:convert';

import 'community_feed_model.dart';

List<CommentModel> commentModelFromJson(String str) => List<CommentModel>.from(
    json.decode(str).map((x) => CommentModel.fromJson(x)));

String commentModelToJson(List<CommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommentModel {
  final int? id;
  final int? schoolId;
  final int? feedId;
  final int? userId;
  final int? replyCount;
  final int? likeCount;
  final String? commentTxt;
  final dynamic parrentId;
  final DateTime? createdAt;
  final String? updatedAt;
  final dynamic file;
  final dynamic privateUserId;
  final dynamic isAuthorAndAnonymous;
  final dynamic gift;
  final dynamic sellerId;
  final dynamic giftedCoins;
  List<CommentModel>? replies;
  final dynamic privateUser;
  final dynamic commentlike;
  final List<dynamic>? reactionTypes;
  final User? user;
  final List<dynamic>? totalLikes;

  CommentModel({
    this.id,
    this.schoolId,
    this.feedId,
    this.userId,
    this.replyCount,
    this.likeCount,
    this.commentTxt,
    this.parrentId,
    this.createdAt,
    this.updatedAt,
    this.file,
    this.privateUserId,
    this.isAuthorAndAnonymous,
    this.gift,
    this.sellerId,
    this.giftedCoins,
    this.replies,
    this.privateUser,
    this.commentlike,
    this.reactionTypes,
    this.user,
    this.totalLikes,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json["id"],
        schoolId: json["school_id"],
        feedId: json["feed_id"],
        userId: json["user_id"],
        replyCount: json["reply_count"],
        likeCount: json["like_count"],
        commentTxt: json["comment_txt"],
        parrentId: json["parrent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        file: json["file"],
        privateUserId: json["private_user_id"],
        isAuthorAndAnonymous: json["is_author_and_anonymous"],
        gift: json["gift"],
        sellerId: json["seller_id"],
        giftedCoins: json["gifted_coins"],
        replies: json["replies"] == null
            ? []
            : List<CommentModel>.from(
                json["replies"].map((x) => CommentModel.fromJson(x)),
              ),
        privateUser: json["private_user"],
        commentlike: json["commentlike"],
        reactionTypes: json["reaction_types"] == null
            ? []
            : List<dynamic>.from(json["reaction_types"]!.map((x) => x)),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        totalLikes: json["totalLikes"] == null
            ? []
            : List<dynamic>.from(json["totalLikes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "school_id": schoolId,
        "feed_id": feedId,
        "user_id": userId,
        "reply_count": replyCount,
        "like_count": likeCount,
        "comment_txt": commentTxt,
        "parrent_id": parrentId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "file": file,
        "private_user_id": privateUserId,
        "is_author_and_anonymous": isAuthorAndAnonymous,
        "gift": gift,
        "seller_id": sellerId,
        "gifted_coins": giftedCoins,
        "replies": replies == null
            ? []
            : List<CommentModel>.from(replies!.map((x) => x)),
        "private_user": privateUser,
        "commentlike": commentlike,
        "reaction_types": reactionTypes == null
            ? []
            : List<dynamic>.from(reactionTypes!.map((x) => x)),
        "user": user?.toJson(),
        "totalLikes": totalLikes == null
            ? []
            : List<dynamic>.from(totalLikes!.map((x) => x)),
      };
}
