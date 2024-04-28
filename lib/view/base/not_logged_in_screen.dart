import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            Images.guest,
            width: MediaQuery.of(context).size.height * 0.25,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'sorry',
            style: largeFont(Colors.black),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'you_are_not_logged_in',
            style: mediumFont(Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          SizedBox(
            width: 200,
            child: Bouncing(
              onPress: () {
                // Get.to(()=>LoginPage());
                Get.toNamed(RouteHelper.login);
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: blackPrimary),
                child: Center(
                  child: Text(
                    'Login to Continue',
                    style: mediumFont(Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
