import 'package:flutter/material.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/util/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  final Color? bodyColor;
  final Color? fontColor;
  const CustomButton(
      {super.key, this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.bodyColor,
      this.icon,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : bodyColor ?? Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width! : Dimensions.WEB_MAX_WIDTH,
          height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Center(
        child: SizedBox(
            width: width ?? Dimensions.WEB_MAX_WIDTH,
            child: Padding(
              padding: margin == null ? const EdgeInsets.all(0) : margin!,
              child: TextButton(
                onPressed: onPressed as void Function()?,
                style: flatButtonStyle,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  icon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Icon(icon,
                              color: transparent
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).cardColor),
                        )
                      : const SizedBox(),
                  Text(buttonText ?? '',
                      textAlign: TextAlign.center,
                      style: defaultFont(
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : fontColor ?? Theme.of(context).cardColor,
                          size: fontSize ?? Dimensions.fontSizeLarge,
                          weight: FontWeight.bold)),
                ]),
              ),
            )));
  }
}
