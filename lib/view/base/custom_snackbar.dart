import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String? message,
    {String title = "", bool isError = false}) {
  if (!Get.isSnackbarOpen) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : primaryColor1,
      titleText: title != "" ? Text(title) : const SizedBox(),
      messageText: Text(
        message!,
        style: TextStyle(color: isError ? Colors.white : Colors.black),
      ),
      icon: isError
          ? const Icon(
              Icons.warning,
              color: Colors.white,
            )
          : const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
      maxWidth:
          GetPlatform.isMobile ? Dimensions.WEB_MAX_WIDTH : Get.width * 0.4,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      borderRadius: Dimensions.RADIUS_SMALL,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}

// void customSnackBar(context, message, {bool isError = false}) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(
//       message,
//       style: TextStyle(color: Colors.white),
//     ),
//     elevation: 0,
//     behavior: SnackBarBehavior.floating,
//     backgroundColor: isError ? Colors.red.withOpacity(1) : Colors.green,
//     duration: Duration(seconds: 2),
//     margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//   ));
// }
