import 'dart:convert';
import 'package:ezy_course/model/community_feed_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../core/api/api_retry_manager.dart';
import '../model/comment_model.dart';

class CommunityFeedController extends GetxController {
  final ApiClient apiClient;

  CommunityFeedController({required this.apiClient});

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommunityFeed();
  }

  var listOfFeed = <CommunityFeedModel>[].obs;

  Future<void> fetchCommunityFeed({bool isReload = false}) async {
    isLoading.value = true;
    if (isReload) {
      listOfFeed.clear();
    }
    try {
      var body = {
        'community_id': '2914',
        'space_id': '5883',
      };
      Response response = await apiClient
          .postData(ApiConfig.getFeedUrl, body, query: {'status': 'feed'});

      if (response.statusCode == 200) {
        listOfFeed.value = communityFeedModelFromJson(response.body);
      }
    } catch (_) {
      apiRetryManager.addRequest(() {
        fetchCommunityFeed();
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateReaction(int? feedId, String type, int? userId) async {
    if (feedId == null) {
      return;
    }
    try {
      var body = {
        'feed_id': feedId,
        'reaction_type': type,
        'action': 'deleteOrCreate',
        'reactionSource': 'COMMUNITY'
      };
      Response response = await apiClient.postData(
        ApiConfig.createLikeUrl,
        body,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        int index = listOfFeed.indexWhere((feed) => feed.id == feedId);
        if (index != -1) {
          var updatedFeed = listOfFeed[index];

          updatedFeed.likeType = (responseData['likeType'] as List)
              .map((e) => LikeType.fromJson(e))
              .toList();
          updatedFeed.likeCount = responseData['total_reactions'];
          String? reactionType = updatedFeed.likeType!.isNotEmpty
              ? updatedFeed.likeType?.last.reactionType
              : null;
          updatedFeed.like = Like(reactionType: reactionType, userId: userId);

          listOfFeed[index] = updatedFeed;
          listOfFeed.refresh();
        }
      }
    } catch (_) {
    } finally {}
  }

  var textCommentController = TextEditingController();

  var isSending = false.obs;
  var parentId = (-1).obs;

  Future<void> createComment(int? feedId, int? feedUserId) async {
    if (textCommentController.text.isEmpty) {
      return;
    }
    isSending.value = true;
    try {
      var body = {
        'feed_id': feedId,
        'feed_user_id': feedUserId,
        'comment_txt': textCommentController.text.toString(),
        'commentSource': 'COMMUNITY',
        if (parentId.value > (-1)) 'parrent_id': parentId.value.toString()
      };
      Response response = await apiClient.postData(
        ApiConfig.createCommentUrl,
        body,
      );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        CommentModel newComment = CommentModel.fromJson(responseData);

        if (parentId.value > -1) {
          int parentIndex = listOfComment.indexWhere((comment) => comment.id == parentId.value);
          if (parentIndex != -1) {
            var parentComment = listOfComment[parentIndex];

            parentComment.replies = (parentComment.replies ?? [])
              ..add(newComment);
            listOfComment[parentIndex] = parentComment;
          } else {
            listOfComment.insert(0, newComment);
          }
          parentId.value = -1;
        } else {
          listOfComment.insert(0, newComment);
          int index = listOfFeed.indexWhere((feed) => feed.id == feedId);
          if (index != -1) {
            var updatedFeed = listOfFeed[index];
            updatedFeed.commentCount = (updatedFeed.commentCount ?? 0) + 1;
            listOfFeed[index] = updatedFeed;
            listOfFeed.refresh();
          }
        }
        listOfComment.refresh();
        textCommentController.clear();
      }
    } catch (_) {
    } finally {
      isSending.value = false;
    }
  }

  var listOfComment = <CommentModel>[].obs;
  var commentFetching = false.obs;

  Future<void> fetchComment(int? feedId) async {
    parentId.value = -1;
    commentFetching.value = true;
    listOfComment.clear();

    if (feedId == null) {
      commentFetching.value = false;
      return;
    }
    try {
      Response? response = await apiClient.getData(
        '${ApiConfig.getCommentUrl}/$feedId',
      );
      if (response.statusCode == 200) {
        listOfComment.value = commentModelFromJson(response.body);
        for (var comment in listOfComment) {
          if ((comment.replyCount ?? 0) > 0) {
            comment.replies = await fetchReply(comment.id);
          } else {
            comment.replies = [];
          }
        }
        listOfComment.refresh();
      }
    } catch (_) {
    } finally {
      commentFetching.value = false;
    }
  }

  Future<List<CommentModel>> fetchReply(int? commentId) async {
    if (commentId == null) return [];

    try {
      Response? response =
      await apiClient.getData('${ApiConfig.getReplyUrl}/$commentId');

      if (response.statusCode == 200) {
        List<CommentModel> replies = commentModelFromJson(response.body);

        for (var reply in replies) {
          if (reply.replyCount != null && reply.replyCount! > 0) {
            reply.replies = await fetchReply(reply.id);
          } else {
            reply.replies = [];
          }
        }
        return replies;
      }
    } catch (_) {
    }

    return [];
  }

  void _addReplyToParentComment(CommentModel parentComment, CommentModel newReply) {
    parentComment.replies ??= [];
    parentComment.replies!.add(newReply);

    int parentIndex = listOfComment.indexWhere((comment) => comment.id == parentComment.id);
    if (parentIndex != -1) {
      listOfComment[parentIndex] = parentComment;
    }
  }

  void _addTopLevelComment(int? feedId, CommentModel newComment) {
    listOfComment.insert(0, newComment);

    int index = listOfFeed.indexWhere((feed) => feed.id == feedId);
    if (index != -1) {
      var updatedFeed = listOfFeed[index];
      updatedFeed.commentCount = (updatedFeed.commentCount ?? 0) + 1;
      listOfFeed[index] = updatedFeed;
      listOfFeed.refresh();
    }
  }

}
