import 'package:ezy_course/controller/community_feed_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart';

import '../core/api/api_client.dart';
import '../core/api/api_config.dart';
import '../view/widget/show_custom_toast.dart';

class CreatePostController extends GetxController {
  final ApiClient apiClient;

  CreatePostController({required this.apiClient});

  var isLoading = false.obs;
  var selectedColorIndex = 0.obs;
  var textPostController = TextEditingController();

  Future<void> createPost() async {
    isLoading.value = true;
    if (!textPostController.text.isNotEmpty) {
      showCustomToast('write something!');
      isLoading.value = false;
      return;
    }

    try {
      var body = {
        "feed_txt": textPostController.text.toString(),
        'community_id': '2914',
        'space_id': '5883',
        'uploadType': 'text',
        'activity_type': 'group',
        'is_background': selectedColorIndex.value.toString(),
        'bg_color': selectedColorIndex.value.toString(),
      };
      Response response =
          await apiClient.postData(ApiConfig.createPostUrl, body);
      if (response.statusCode == 200) {
        Get.find<CommunityFeedController>().fetchCommunityFeed();
        Get.back();
      } else {
        showCustomToast('Something went wrong!');
      }
    } catch (_) {
    } finally {
      isLoading.value = false;
    }
  }
}
