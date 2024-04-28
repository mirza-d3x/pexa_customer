import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SingleProductShimmer extends StatelessWidget {
  const SingleProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
              child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 16,
              height: 8,
              color: Colors.white,
            ),
          )),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            color: const Color(0xFFececec),
            // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 60,
                  height: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
