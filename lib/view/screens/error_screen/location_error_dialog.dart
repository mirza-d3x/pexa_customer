import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/custom_loader.dart';

LocationErrorDialog(
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
    required String buttonText,
    bool isLoading = false,
    VoidCallback? onPressed}) {
  return Column(
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
      ElevatedButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18),
          )),
    ],
  );
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
