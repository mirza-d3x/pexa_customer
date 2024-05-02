import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/splash_controller.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class LocationScreen extends StatefulWidget {
  final String? pid;
  const LocationScreen({super.key, this.pid});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            GetPlatform.isMobile ? null : CustomAppBarWeb(title: 'Verify OTP'),
        body: Get.find<ConnectivityController>().status
            ? GetBuilder<AuthFactorsController>(builder: (controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/carSpa/icon-location.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Text(
                              'Enable precise location',
                              style: superLargeBoldFont(Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Your location will be used to show our nearest service',
                              style: mediumFont(Colors.black54),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Bouncing(
                                onPress: () {
                                  Get.find<locationPermissionController>()
                                      .checkLocationStatus()
                                      .then((value) {
                                    Get.find<locationPermissionController>()
                                        .getUserLocation(isForAddress: false);
                                    Get.find<SplashController>()
                                        .route(productId: widget.pid);
                                  });
                                },
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: ResponsiveHelper.isMobile(context)
                                        ? Get.width * .65
                                        : Get.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: botAppBarColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                    child: Center(
                                      child: /*controller.loaderHelper.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          :*/
                                          Text(
                                        'Confirm',
                                        style: mediumBoldFont(Colors.black),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Bouncing(
                                onPress: () {
                                  Get.find<SplashController>()
                                      .route(productId: widget.pid);
                                },
                                child: Center(
                                  child: Container(
                                    height: 50,
                                    width: ResponsiveHelper.isMobile(context)
                                        ? Get.width * .65
                                        : Get.width * 0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30)),
                                    ),
                                    child: Center(
                                      child: /*controller.loaderHelper.isLoading
                                          ? CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : */
                                          Text(
                                        'Remind me later',
                                        style: mediumBoldFont(Colors.black),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Text(
                        'By  Continuing  you agree to our Terms of service and privacy policy \n copyright 2024 Pexa',
                        style: verySmallFont(Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              })
            : const NoInternetScreenView());
  }
}
