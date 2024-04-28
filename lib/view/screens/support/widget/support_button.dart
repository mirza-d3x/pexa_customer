import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String info;

  // final Color color;
  final Function onTap;

  const SupportButton(
      {super.key, required this.icon,
      required this.title,
      required this.info,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xcfffbe77d)
            ),
            child: Icon(icon, color: blackPrimary, size: 20),
          ),
          const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title, style: mediumFont(Colors.black)),
                const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Text(info,
                    style: smallFont(Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ])),
        ]),
      ),
    );
  }
}
