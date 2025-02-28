import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_image.dart';
import 'app_text.dart';

class Constant {
  static String getTimeAgo(DateTime? createdAt) {
    if (createdAt == null) {
      return 'Date not available';
    }
    DateTime now = DateTime.now();

    Duration difference = now.difference(createdAt);

    if (difference.isNegative) {
      return 'Just now';
    }
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${AppText.second}${difference.inSeconds == 1 ? '' : 's'} ${AppText.ago}';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${AppText.minute}${difference.inMinutes == 1 ? '' : 's'} ${AppText.ago}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${AppText.hour}${difference.inHours == 1 ? '' : 's'} ${AppText.ago}';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${AppText.day}${difference.inDays == 1 ? '' : 's'} ${AppText.ago}';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} ${AppText.month}${((difference.inDays / 30).floor() == 1) ? '' : 's'} ${AppText.ago}';
    } else {
      return '${(difference.inDays / 365).floor()} ${AppText.year}${((difference.inDays / 365).floor() == 1) ? '' : 's'} ${AppText.ago}';
    }
  }

  static String getTimeAgoShort(DateTime? createdAt) {
    if (createdAt == null) {
      return 'N/A';
    }

    DateTime now = DateTime.now();
    Duration difference = now.difference(createdAt);

    if (difference.isNegative) {
      return 'Just now';
    }
    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}w';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}m';
    } else {
      return '${(difference.inDays / 365).floor()}y';
    }
  }


  static String getReactionAsset(String reactionType) {
    switch (reactionType.toLowerCase()) {
      case 'love':
        return AppImage.icLove;
      case 'care':
        return AppImage.icCare;
      case 'haha':
        return AppImage.icHaha;
      case 'wow':
        return AppImage.icWow;
      case 'sad':
        return AppImage.icSad;
      case 'angry':
        return AppImage.icAngry;
      case 'thumb':
        return AppImage.icThumb;
      default:
        return AppImage.icLike;
    }
  }

  static Color getReactionColor(String reactionType) {
    switch (reactionType.toLowerCase()) {
      case 'like':
      case 'thumb':
        return AppColor.purple;
      case 'love':
        return Colors.red;
      case 'care':
        return Colors.orange;
      case 'haha':
      case 'wow':
      case 'sad':
        return Color(0xFFF69B30);
      case 'angry':
        return Colors.deepOrange;
      default:
        return AppColor.textColor3;
    }
  }

  static String formatDate(String? date) {
    return date ?? 'Just now';
  }

}
