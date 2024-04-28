import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/splash_controller.dart';
import 'package:shoppe_customer/data/repository/authApi.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/auth/widget/edit_round_button.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/location/locationScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  final String? phone;
  OTPScreen({super.key, required this.phone, this.pid});
  String? pid;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var authController = Get.find<AuthFactorsController>();
  TextEditingController pinController = TextEditingController();
  final addressController = Get.find<AddressControllerFile>();

  @override
  void dispose() {
    // pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final number = widget.phone;
    return Scaffold(
        appBar:
            GetPlatform.isMobile ? null : CustomAppBarWeb(title: 'Verify OTP'),
        body: Get.find<ConnectivityController>().status
            ? GetBuilder<AuthFactorsController>(builder: (controller) {
                return Stack(
                  alignment:Alignment.center,
                  children: [
                    Container(
                      height: double.maxFinite,
                    width: double.maxFinite,
                    color: Colors.white,
                    /*  decoration: BoxDecoration(
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
                              /*Image.asset(
                                'assets/carSpa/latestlogo.png',
                                width: 100,
                                height: 100,
                              ),*/
                             /* Image.asset(
                                'assets/carSpa/pexaNameOnly.png',
                                color: Colors.white,
                                width: 70,
                              ),*/
                              // Text(
                              //   'PEXA',
                              //   style: superLargeBoldFont(Colors.white),
                              // ),
                              Text(
                                'Verification\nCode',
                                style: superLargeBoldFont(Colors.black),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'We have sent the verification code to your phone number',
                                style: mediumFont(Colors.black54),
                              ),
                             /* Text(
                                'Enter the OTP code send to',
                                style: smallFontW600(Colors.white),
                              ),*/
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(number!,
                                          style: mediumFont(Colors.black54)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const RoundEditButton()
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: ResponsiveHelper.isMobile(context)
                                    ? Get.width
                                    : Get.width * 0.4,
                                child: PinCodeTextField(
                                    appContext: context,
                                    boxShadows: const [
                                      BoxShadow(
                                        offset: Offset(0, 1),
                                        color: Colors.white,
                                        blurRadius: 3,
                                      )
                                    ],
                                    controller: pinController,
                                    textStyle: const TextStyle(color: Colors.black),
                                    length: 6,
                                    keyboardType: TextInputType.number,
                                    cursorColor: Colors.black,
                                    autoFocus: true,
                                    textInputAction: TextInputAction.done,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    enablePinAutofill: true,
                                    enableActiveFill: true,
                                    /*obscureText: false,*/
                                    /*obscuringWidget: Icon(
                                      Icons.circle,
                                      size: 16,
                                    ),*/
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(20),
                                      fieldHeight: 50,
                                      fieldWidth: 50,
                                      activeColor: Colors.yellow,
                                      activeFillColor: Colors.white,
                                      inactiveFillColor: Colors.white,
                                      inactiveColor: Colors.grey[400],
                                      selectedColor: Colors.grey[400],
                                      selectedFillColor: Colors.white,
                                      disabledColor: Colors.white,
                                    ),
                                    onChanged: (value) {},
                                    onCompleted: (pin) {
                                      controller
                                          .verifyOTP(phone: number, otp: pin)
                                          .then((value) {
                                        if (value['status'] == 'OK') {
                                          if (controller.passwordState.value ==
                                              '') {
                                            Get.offAll(LocationScreen());
                                          /*  Get.find<SplashController>()
                                                .route(productId: widget.pid);*/
                                          }
                                        } else {
                                          showCustomSnackBar(value['message'],
                                              title: 'Error', isError: true);
                                        }
                                      });
                                      // }
                                      // }
                                    }),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Get.width,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Don\'t receive OTP? ',
                                          style: mediumFont(Colors.black54)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Bouncing(
                                          onPress: controller.timeStarted.value
                                              ? null
                                              : () {
                                            pinController.clear();
                                                  controller.startTimer();
                                                  controller
                                                      .updateLoadingStatus(
                                                          false);
                                                  AuthApi(apiClient: Get.find())
                                                      .login(phone: number);
                                                  showCustomSnackBar(
                                                      'We had send you the OTP',
                                                      isError: false);
                                                },
                                          child: Text('Resend',
                                              style: mediumFont(
                                                  controller.timeStarted.value
                                                      ? Colors.grey
                                                      : Colors.black54)))
                                    ],
                                  ),
                                ),
                              ),
                              controller.timeStarted.value
                                  ? Center(
                                    child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Try after ${controller.timerCount.value} seconds',
                                            style: smallFontW600(Colors.black54),
                                          )
                                        ],
                                      ),
                                  )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              Bouncing(
                                  onPress: () {
                                    if (controller.loaderHelper.isLoading ==
                                        false) {
                                      if (pinController.text.trim() != '') {
                                        if (controller.otpVerified.value) {
                                          Get.find<SplashController>()
                                              .route(productId: widget.pid);
                                        } else {
                                          controller
                                              .verifyOTP(
                                                  phone: number,
                                                  otp: pinController.text)
                                              .then((value) {
                                            if (value['status'] == 'OK') {
                                              print("onpress!!!! :${Get.find<AuthFactorsController>().isLoggedIn.value}");
                                              if (controller
                                                      .passwordState.value ==
                                                  '') {
                                                Get.find<SplashController>()
                                                    .route(
                                                        productId: widget.pid);
                                              }
                                            } else {
                                              showCustomSnackBar(
                                                  value['message'],
                                                  title: 'Error',
                                                  isError: true);
                                            }
                                          });
                                        }
                                      } else {
                                        showCustomSnackBar('No OTP Found..!',
                                            title: 'Warning', isError: true);
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 50,
                                      width: ResponsiveHelper.isMobile(context)
                                          ? Get.width * .65
                                          : Get.width * 0.2,
                                      decoration: BoxDecoration(
                                        color: botAppBarColor,
                                        borderRadius:
                                            const BorderRadius.all(Radius.circular(30)),
                                      ),
                                      child: Center(
                                        child: controller.loaderHelper.isLoading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text(
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
                                  controller.timerReset();
                                  Get.back();
                                  // Get.off(RouteHelper.getSignInRoute(
                                  //     page: Get.currentRoute,
                                  //     productId: widget.pid));
                                },
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: mediumFont(Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(bottom: 10,
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
