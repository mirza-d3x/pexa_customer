import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
      ),
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
              Text(
                'Full Name',
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
                child: Center(
                  child: Text(
                    Get.find<AuthFactorsController>().userDetails!.name!,
                    style: largeFont(Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Email Id',
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
                child: Center(
                  child: Text(
                    Get.find<AuthFactorsController>().userDetails!.email!,
                    style: largeFont(Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Phone Number',
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
                child: Center(
                  child: Text(
                    Get.find<AuthFactorsController>()
                        .phoneNumber
                        .value
                        .toString(),
                    style: largeFont(Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.userDetailsUpdate, arguments: {
                        'isEdit': true,
                      });
                    },
                    buttonText: 'Edit',
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
