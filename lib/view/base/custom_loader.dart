import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/util/dimensions.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      alignment: Alignment.center,
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF4B4B4D),
        rightDotColor: const Color(0xFFf7d417),
        size: 50,
      ),
    ));
  }
}
