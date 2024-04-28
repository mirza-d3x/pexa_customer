import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String description;
  final Function onOkPressed;
  const CustomAlertDialog({super.key, required this.description, required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_LARGE,
            vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.info, size: 80, color: Theme.of(context).primaryColor),
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
          CustomButton(
            buttonText: 'ok'.tr,
            onPressed: onOkPressed,
            height: 40,
          ),
        ]),
      ),
    );
  }
}
