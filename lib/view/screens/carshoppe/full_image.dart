import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:photo_view/photo_view.dart';

class FullImage extends StatelessWidget {
  const FullImage({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      body: Center(
        child: Container(
            child: PhotoView(
          minScale: PhotoViewComputedScale.contained * 0.8,
          backgroundDecoration: const BoxDecoration(color: Colors.white),
          imageProvider: NetworkImage(path),
        )),
      ),
    );
  }
}
