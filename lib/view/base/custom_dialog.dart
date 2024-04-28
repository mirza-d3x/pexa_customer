import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/base/custom_loader.dart';

CustomDialog(
    {String title = "Loading",
    String descriptions = "Please wait...",
    bool isLoading = false,
    bool isCompleted = false,
    String buttonText = "Continue",
    VoidCallback? onPressed}) async {
  showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(
              context: Get.context,
              buttonText: buttonText,
              descriptions: descriptions,
              title: title,
              isLoading: isLoading,
              onPressed: onPressed),
        );
      });
  if (isCompleted) {
    Navigator.of(Get.context!).pop();
  }
}

contentBox(
    {BuildContext? context,
    required String title,
    required String descriptions,
    String? buttonText,
    bool isLoading = false,
    VoidCallback? onPressed}) {
  return Stack(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(
            left: Constants.padding,
            top: Constants.avatarRadius + Constants.padding,
            right: Constants.padding,
            bottom: Constants.padding),
        margin: const EdgeInsets.only(top: Constants.avatarRadius),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              descriptions,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            const CustomLoader(),
            const SizedBox(
              height: 22,
            ),
            onPressed.isBlank!
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(
                          buttonText!,
                          style: const TextStyle(fontSize: 18),
                        )),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      // bottom part
      Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset(Images.logo)),
          )), // top part
    ],
  );
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
