import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_image.dart';
import 'custom_cache_manager.dart';

class ImageLoader extends StatelessWidget {
  final String url;
  final double? width, height, radius, size;
  final BoxFit? boxFit;
  final Color? bgColor;
  final bool isProfile;

  const ImageLoader(
      {super.key,
      required this.url,
      this.width,
      this.height,
      this.boxFit,
      this.radius,
      this.bgColor,
      this.size,
      this.isProfile = false});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0),
      child: Container(
        color: bgColor,
        child: CachedNetworkImage(
          key: UniqueKey(),
          imageUrl: url,
          cacheManager: CustomCacheManager.instance,
          fit: boxFit ?? BoxFit.fill,
          width: size ?? width,
          height: size ?? height,
          progressIndicatorBuilder: (BuildContext context, String child,
              DownloadProgress? loadingProgress) {
            if (loadingProgress == null) {
              return const SizedBox();
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.downloaded /
                      (loadingProgress.totalSize ?? 1),
                  color: AppColor.textColor.withValues(alpha: 0.1),
                ),
              );
            }
          },
          errorListener: (_) {},
          errorWidget: (BuildContext context, String s, Object error) {
            return isProfile
                ? Image.asset(
                    AppImage.profileAvatar,
                    width: size ?? width,
                    height: size ?? height,
                  )
                : Container(
                    width: size ?? width,
                    height: size ?? height,
                    color: AppColor.shimmerBase,
                  );
          },
        ),
      ),
    );
  }
}
