import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/splash_controller.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key, this.prductId});
  String? prductId;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SplashController>().route(productId: widget.prductId);
  }

  final addressController = Get.find<AddressControllerFile>();

  @override
  Widget build(BuildContext context) {
    //var locationEnable = LocationEnabledController();

    return Scaffold(
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Get.find<ConnectivityController>().status
            ? Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                        /*image: DecorationImage(
                            image: AssetImage('assets/carSpa/splash_bg.jpg'),
                            fit: BoxFit.fill)*/),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/image/logo.png"))),
                          ),
                          const SizedBox(height: 8,),
                          Text("PEXA",style: largeFontBold(Colors.black),),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Image.asset(
                            //   'assets/carSpa/latestlogo.png',
                            //   width: 150,
                            //   height: 150,
                            // ),
                            // Image.asset(
                            //   'assets/carSpa/pexaNameOnly.png',
                            //   color: Colors.white,
                            //   width: 100,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : NoInternetScreenView(child: SplashScreen());
      }),
    );
  }
}
