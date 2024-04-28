import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/helper/fonts.dart';

class NoDataErrorScreen extends StatelessWidget {
  const NoDataErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xfffbecea),
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
                )
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
                  flex: 4,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.no_data_icon,
                        height: height * 0.22,
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Text(
                        "No data found",
                        style: defaultFont(
                            color: Colors.black,
                            size: 20,
                            weight: FontWeight.w500),
                      ),
                      Text(
                        "Look like there is no data to show",
                        style: defaultFont(
                            color: Colors.black,
                            size: 15,
                            weight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      InkWell(
                        onTap: () {
                          Get.offAllNamed(RouteHelper.initial);
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
                              'Home',
                              style: mediumFont(Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;
    final path = Path();

    path.moveTo(0, h);
    path.lineTo(0, h * 0.5);
    path.quadraticBezierTo(w * 0.5, h * 0.3, w, h * 0.5);
    path.lineTo(w, h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
