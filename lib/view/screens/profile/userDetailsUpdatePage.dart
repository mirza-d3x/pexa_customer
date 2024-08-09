import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/searchLocationController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class UserDetailsUpdate extends StatefulWidget {
  UserDetailsUpdate({super.key, this.isEdit, this.productId});
  final bool? isEdit;
  String? productId;

  @override
  State<UserDetailsUpdate> createState() => _UserDetailsUpdateState();
}

class _UserDetailsUpdateState extends State<UserDetailsUpdate> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  bool validateEmail(String emailId) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailId);
    return emailValid;
  }

  showMessage(String title, String body, Color bgColor, Color textColor) {
    Get.snackbar(title, body,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: bgColor,
        colorText: textColor,
        snackStyle: SnackStyle.FLOATING);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isEdit!) {
      setState(() {
        userNameController.text =
            Get.find<AuthFactorsController>().userDetails!.name!;
        emailController.text =
            Get.find<AuthFactorsController>().userDetails!.email!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isEdit!
          ? AppBar(
              title: Text("User Details", style: mediumFont(Colors.black)),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 15,
                ),
                color: Theme.of(context).textTheme.bodyLarge!.color,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Theme.of(context).cardColor,
              elevation: 0,
            )
          : null,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: Image.asset(
                    'assets/carSpa/latestlogo.png',
                    height: 100,
                  ))),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: widget.isEdit!
                          ? Text(
                              'Update the Profile',
                              style: largeFont(Colors.black),
                            )
                          : Text(
                              'Complete the Profile',
                              style: largeFont(Colors.black),
                            ))),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Full Name*',
                style: mediumFont(Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: userNameController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Enter the Name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Email Id*',
                style: mediumFont(Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: emailController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Enter the Email Id'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Bouncing(
                    onPress: () {
                     
                      if ((emailController.text.trim() != '') &&
                          (userNameController.text.trim() != '')) {
                        if (validateEmail(
                            emailController.text.trim().toString())) {
                          Get.find<AuthFactorsController>()
                              .updateUserDetails(
                            emailController.text.trim().toString(),
                            userNameController.text.trim().toString(),
                          )
                              .then((value) {
                            // if (value) {
                            //   print("OK");
                            if (value != null && value != false) {
                              if (widget.productId != null) {
                                Get.offAllNamed(RouteHelper.getInitialRoute(
                                    page: RouteHelper.userDetailsUpdate,
                                    productId: widget.productId));
                                Future.delayed(const Duration(seconds: 2), (() {
                                  Get.find<locationPermissionController>()
                                      .checkLocationStatus();
                                }));
                              } else {
                                Get.offAllNamed(RouteHelper.getInitialRoute(
                                  page: RouteHelper.userDetailsUpdate,
                                ));
                                Future.delayed(const Duration(seconds: 2), (() {
                                  Get.find<locationPermissionController>()
                                      .checkLocationStatus();
                                }));
                              }

                              // Get.offAllNamed('/');
                            }
                            // } else {
                            print("NOT OK");
                            // }
                          });
                        } else {
                          showCustomSnackBar('Enter a valid Email Id...!',
                              title: 'Warning', isError: true);
                        }
                      } else {
                        showCustomSnackBar('Enter all Details...!',
                            title: 'Warning', isError: true);
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: botAppBarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          widget.isEdit! ? 'Update' : 'Save',
                          style: mediumFont(Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
