import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shimmer/shimmer.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? placeholder;
  final double radius;

  CustomImage(
      {super.key, required this.image,
      this.height,
      this.width,
      this.fit = BoxFit.cover,
      this.radius = 0,
      this.placeholder});

  final CacheManager cacheManager = CacheManager(Config('images_Key',
      maxNrOfCacheObjects: 200, stalePeriod: const Duration(days: 1)));

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: cacheManager,
      imageUrl: image!,
      height: height,
      width: width,
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: fit,
              alignment: Alignment.center,
              scale: 1,
              filterQuality: FilterQuality.high),
          // borderRadius: BorderRadius.all(
          //   Radius.circular(radius),
          // ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
          ),
        ),
      ),
      // placeholder: (context, url) => Center(
      //   child: Shimmer.fromColors(
      //     child: Container(
      //       width: MediaQuery.of(context).size.width,
      //       color: Colors.white,
      //     ),
      //     baseColor: Colors.grey[300],
      //     highlightColor: Colors.grey[100],
      //   ),
      // ),
      errorWidget: (context, url, error) => Center(
        child: SizedBox(
          height: height,
          width: width,
          child: Image.asset(
            Images.placeholder,
            fit: BoxFit.fill,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
