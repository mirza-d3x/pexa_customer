import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/error_screen/shop_error_screen.dart';

class NoInternetScreenView extends StatelessWidget {
  final Widget? child;

  const NoInternetScreenView({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      color: const Color(0xfffbecea),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ClipPath(
                    clipper: CustomClipPath(),
                    child: Container(
                      width: width,
                      height: height * 0.8,
                      margin: EdgeInsets.only(top: height * 0.2),
                      decoration: const BoxDecoration(
                        // borderRadius:
                        //     BorderRadius.vertical(top: Radius.circular(100)),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Image.asset(
                        Images.no_internet_icon,
                        height: height * 0.18,
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Text(
                        "No Internet",
                        style: defaultFont(
                            color: Colors.black,
                            size: 25,
                            weight: FontWeight.bold),
                      ),
                      Text(
                        "Looks like there is no inernet",
                        style: defaultFont(
                            color: Colors.black,
                            size: 15,
                            weight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAndToNamed(RouteHelper.getRoute(child));
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.8,
                          decoration: BoxDecoration(
                            color: botAppBarColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Reload',
                              style: mediumFont(Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
