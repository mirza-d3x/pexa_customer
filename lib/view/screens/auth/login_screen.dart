import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class NewLoginScreen extends StatefulWidget {
  NewLoginScreen({super.key, bool? exitFromApp, this.pid});
  String? pid;
  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* phoneNumberController.text = "8129596582";*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GetPlatform.isMobile ? null : CustomAppBarWeb(title: 'Login'),
        body: Get.find<ConnectivityController>().status
            ? GetBuilder<AuthFactorsController>(builder: (controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: double.maxFinite,
                      color: Colors.white,
                      /*decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/carSpa/login_bg.jpg'),
                              fit: BoxFit.fill)),*/
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/carSpa/latestlogo.png',
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  'assets/carSpa/pexaNameOnly.png',
                                  color: Colors.black,
                                  width: 70,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                'Login',
                                style: superLargeBoldFont(Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Enter phone number to send one time password',
                                style: mediumFont(Colors.black54),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                width: ResponsiveHelper.isMobile(context)
                                    ? Get.width * 0.9
                                    : Get.width * 0.3,
                                child: TextField(
                                  maxLength: 10,
                                  controller: phoneNumberController,
                                  textAlign: TextAlign.center,
                                  style: largeFont(Colors.black),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      counterText: "",
                                      labelText: 'Mobile Number',
                                      labelStyle: mediumFont(Colors.black54),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.black54),
                                        borderRadius: BorderRadius.circular(30),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Bouncing(
                                onPress: () {
                                  controller.loaderHelper.cancelLoader();
                                  if (!controller.loaderHelper.isLoading) {
                                    (phoneNumberController.text.isEmpty)
                                        ? Get.snackbar(
                                            'Error', 'Please enter your phone number',
                                            backgroundColor: Colors.red[700],
                                            colorText: Colors.white)
                                        : (phoneNumberController.text.length !=
                                                10)
                                            ? Get.snackbar(
                                                'Error', 'Please enter a valid phone number',
                                                backgroundColor:
                                                    Colors.red[700],
                                                colorText: Colors.white)
                                            : phoneNumberController.text
                                                    .toString()
                                                    .contains(RegExp(r'[^0-9]'))
                                                ? Get.snackbar(
                                                    'Error', 'Please enter a valid phone number',
                                                    backgroundColor:
                                                        Colors.red[700],
                                                    colorText: Colors.white)
                                                : Get.find<AuthFactorsController>()
                                                        .timeStarted
                                                        .value
                                                    ? Get.snackbar(
                                                        'Warning', 'Login process already started, wait for 30 sec',
                                                        backgroundColor:
                                                            Colors.red[700],
                                                        colorText: Colors.white)
                                                    : Get.find<AuthFactorsController>()
                                                        .login(phone: phoneNumberController.text.toString())
                                                        .then((value) {
                                                        if (controller
                                                                .phoneNumberState
                                                                .value ==
                                                            '') {
                                                          if (widget.pid !=
                                                              null) {
                                                            Get.toNamed(
                                                              RouteHelper
                                                                  .verification,
                                                              arguments: {
                                                                'phone':
                                                                    phoneNumberController
                                                                        .text
                                                                        .trim()
                                                                        .toString(),
                                                                'pid':
                                                                    widget.pid
                                                              },
                                                            );
                                                          } else {
                                                            Get.toNamed(
                                                              RouteHelper
                                                                  .verification,
                                                              arguments: {
                                                                'phone':
                                                                    phoneNumberController
                                                                        .text
                                                                        .trim()
                                                                        .toString()
                                                              },
                                                            );
                                                          }
                                                        } else {
                                                          showCustomSnackBar(
                                                              'Something Went Wrong!',
                                                              isError: true);
                                                        }
                                                      });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: botAppBarColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(30))),
                                  height: 50,
                                  width: ResponsiveHelper.isMobile(context)
                                      ? Get.width * 0.9
                                      : Get.width * 0.3,
                                  child: Center(
                                    child: Text(
                                      'Send OTP',
                                      style: mediumBoldFont(Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     Get.find<GuestController>().guestLogin();
                              //   },
                              //   child: Text(
                              //     'Continue as Guest?',
                              //     style: largeFont(Colors.white),
                              //   ),
                              // ),
                              controller.timeStarted.value
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Try after ${controller.timerCount.value} seconds',
                                          style: smallFontW600(Colors.white),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                            ],
                          ),
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
