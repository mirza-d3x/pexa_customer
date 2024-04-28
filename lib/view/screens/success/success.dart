import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed('/');
          return false;
        },
        child: (Get.find<ConnectivityController>().status)
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.1),
                          child: Center(
                            child: Column(
                              children: [
                                Image(
                                  image: const AssetImage('assets/image/OrderSuccess.png'),
                                  height: Get.height * 0.12,
                                ),
                                const SizedBox(height: 20),
                                Text("Thank You",style: mediumBoldFont(Colors.black),),
                                const SizedBox(height: 10,),
                                Text(
                                  'Your Booking\nIs Confirmed',
                                  textAlign: TextAlign.start,
                                  style: largeFontBold(Colors.black),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.offAllNamed(RouteHelper.initial);
                              },
                              child: Container(
                                height: 40,
                                width: 270,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                                  color: botAppBarColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child:
                                  Text('Track Your Order', style: mediumFont(Colors.black)),
                                ),
                              ),
                            ),
                           /* CustomButton(
                              width: Get.width * 0.4,
                              radius: 10,
                              buttonText: "Track Your Order",
                              fontColor: Colors.black,
                              onPressed: () {
                                Get.offAllNamed(RouteHelper.initial);
                              },
                            ),*/
                            // Bouncing(
                            //   onPress: () {
                            //     Get.offAllNamed('/');
                            //   },
                            //   child: Container(
                            //     height: 40,
                            //     width: 150,
                            //     child: Center(
                            //         child: Text(
                            //       'Go Home',
                            //       style: mediumFont(Colors.black),
                            //     )),
                            //     decoration: BoxDecoration(
                            //         color: botAppBarColor,
                            //         borderRadius: BorderRadius.circular(10)),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const Scaffold(
                body: NoInternetScreenView(),
              ));
  }
}
