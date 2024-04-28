import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/helper/fonts.dart';

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  final bool? isFromOther;

  const ProfileBgWidget(
      {super.key, required this.mainWidget,
      required this.circularImage,
      required this.backButton,
      required this.isFromOther});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(clipBehavior: Clip.none, children: [
        SizedBox(
          width: Get.width,
          height: 350,
          child: Center(
              child: Image.asset(Images.home_banner,
                  height: 350, width: Get.width, fit: BoxFit.fill)),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          left: 0,
          right: 0,
          child: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: defaultFont(
              color: Colors.black,
              size: 20,
              weight: FontWeight.w400,
            ),
          ),
        ),
        backButton
            ? Positioned(
                top: MediaQuery.of(context).padding.top,
                left: 10,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.black, size: 15),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            : const SizedBox(),
        Positioned(
          // top: 0,
          left: 0,
          right: 0,
          bottom: 10,
          child: circularImage,
        ),
      ]),
      Expanded(
        child: mainWidget,
      ),
    ]);
  }
}
