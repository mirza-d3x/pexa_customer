import 'package:get/get.dart';
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/infoPage/widgets/pnp.dart';
import 'package:shoppe_customer/view/screens/infoPage/widgets/tnc.dart';
import 'package:shoppe_customer/view/screens/infoPage/widgets/aboutUs.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key, required this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        // appBar: AppBar(
        //   title: Text(title,
        //       style: mediumFont(Colors.black),
        //   ),
        //   centerTitle: true,
        //   leading: IconButton(
        //     icon: Icon(Icons.arrow_back_ios,size: 15,),
        //     color: Theme.of(context).textTheme.bodyText1.color,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        //   backgroundColor: Theme.of(context).cardColor,
        //   elevation: 0,
        // ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.home_banner),
                  fit: BoxFit.cover,
                ),
              ),
              height: Get.height * 0.25,
              child: Column(children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  title: Text(
                    title!,
                    style: defaultFont(
                      color: Colors.black,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                  ),
                  centerTitle: true,
                  // actions: [
                  //   IconButton(
                  //     icon: Image.network(
                  //       'https://res.cloudinary.com/carclenx-pvt-ltd/image/upload/v1650608062/Icons/Home/P_Search_80-removebg-preview_etr5jn.png',
                  //       width: 25,
                  //     ),
                  //     onPressed: () {
                  //       // Get.to(() => NewSearchScreen()).then((value) =>
                  //       //     Get.find<PexaSearchController>().isLoad.value =
                  //       // false);
                  //       // Get.to(SearchScreen());
                  //     },
                  //   ),
                  //   IconButton(
                  //     icon: Image.network(
                  //       'https://res.cloudinary.com/carclenx-pvt-ltd/image/upload/v1650606101/Icons/Home/P_Bell_80_vkc8dk.png',
                  //       width: 25,
                  //     ),
                  //     onPressed: () {
                  //       // Get.to(CartScreen());
                  //     },
                  //   ),
                  // ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      height: Get.height * 0.1,
                      width: Get.width,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/carSpa/latestlogo.png",
                            height: 80,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'PEXA',
                            style: defaultFont(
                              color: Colors.black,
                              size: 50,
                              weight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                AppConstants.APP_VERSION,
                                style: defaultFont(
                                  color: Colors.black,
                                  size: 20,
                                  weight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                )
              ]),
            ),
            title == 'About Us'
                ? const AboutUs()
                : title == 'Privacy and Policy'
                    ? const PrivacyAndPolicy()
                    : title == 'Terms and Conditions'
                        ? const Terms()
                        : const SizedBox()
          ]),
        ));
  }
}
