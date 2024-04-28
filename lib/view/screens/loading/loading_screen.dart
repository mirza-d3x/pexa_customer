import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: const Color(0xFF4B4B4D),
        rightDotColor: const Color(0xFFf7d417),
        size: 50,
      ),
    );
  }
}
