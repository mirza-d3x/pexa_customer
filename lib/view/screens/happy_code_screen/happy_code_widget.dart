import 'package:flutter/material.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';

class HappyCodeWidget extends StatelessWidget {
  HappyCodeWidget({super.key, this.happyCode});
  String? happyCode;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Happy Code ",
            style: robotoRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        happyCode != null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Give this code to service provider to complete the order.",
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).disabledColor),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : const SizedBox(),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              happyCode != null ? happyCode! : "No code Generated",
              style: robotoRegular.copyWith(
                  color: happyCode != null
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor,
                  fontSize: happyCode != null ? 40 : 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Divider(
          color: Theme.of(context).disabledColor,
          thickness: 1,
        ),
      ],
    );
  }
}
