import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/imageCacheController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({
    super.key,
    this.controller,
  });

  final AuthFactorsController? controller;
  final carModelController = Get.find<CarModelController>();
  final imageCacheController = Get.put(ImageCacheController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 325,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(Images.home_banner)),
                //color: Color(0XFFf7d417),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GetBuilder<AuthFactorsController>(
                        builder: (authController) {
                      return Row(
                        children: [
                          Text(
                            (authController.userDetails != null &&
                                    authController.userDetails!.name != '')
                                ? authController.userDetails!.name!.toUpperCase()
                                : authController.userPhone != null
                                    ? Get.find<AuthFactorsController>()
                                        .userPhone
                                        .toString()
                                    : 'Not Logged In',
                            style: defaultFont(
                                color: Colors.black,
                                size: 20,
                                weight: FontWeight.bold),
                          ),
                          const Spacer(),
                          //
                          Stack(children: [
                            Opacity(
                                opacity: 0.5,
                                child: Image.asset(
                                    "assets/carSpa/latestlogo.png",
                                    height: 50,
                                    width: 50,
                                    color: Colors.black)),
                            ClipRect(
                                child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 2.0, sigmaY: 4.0),
                                    child: Image.asset(
                                      "assets/carSpa/latestlogo.png",
                                      height: 50,
                                      width: 50,
                                    )))
                          ])
                        ],
                      );
                    }),
                    const Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Get.find<AuthFactorsController>().userDetails !=
                                null
                            ? Get.find<AuthFactorsController>()
                                .userDetails!
                                .phone
                                .toString()
                            : ' '),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Images.car_ico,
                              width: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Get.find<CarModelController>().carModelName !=
                                        null &&
                                    Get.find<CarModelController>()
                                        .carModelName!
                                        .isNotEmpty
                                ? SizedBox(
                                    width: 100,
                                    child: Text(
                                        " ${Get.find<CarModelController>().carBrandName}"
                                        " ${Get.find<CarModelController>().carModelName}",
                                        maxLines: 2,
                                        style: defaultFont(
                                          size: 15,
                                          weight: FontWeight.w400,
                                        )),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/image/drawer/home.png',
                          width: 20, color: Colors.black),
                      const SizedBox(width: 5),
                      Text('Home',
                          style: defaultFont(
                              size: 18,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  onTap: () {
                    Get.find<NavigationDrawerController>().closeDrawer();
                    Get.offAllNamed('/');
                  },
                ),
                GetBuilder<AuthFactorsController>(builder: (authController) {
                  return ListTile(
                    title: Row(
                      children: [
                        Image.asset('assets/image/drawer/profile.png',
                            width: 20, color: Colors.black),
                        const SizedBox(width: 5),
                        Text('Profile',
                            style: defaultFont(
                                size: 18,
                                weight: FontWeight.w400,
                                color: Colors.black)),
                      ],
                    ),
                    onTap: () {
                      if (authController.isLoggedIn.value) {
                        Get.toNamed(RouteHelper.getProfileRoute());
                      } else {
                        Get.toNamed(RouteHelper.login);
                      }
                    },
                  );
                }),
                // ListTile(
                //   title: Row(
                //     children: [
                //       Icon(
                //         Icons.dark_mode_outlined,
                //         color: Colors.black,
                //         size: 20,
                //       ),
                //       SizedBox(width: 5),
                //       Text('Enable Dark Theme',
                //           style: defaultFont(
                //               size: 18,
                //               weight: FontWeight.w400,
                //               color: Colors.black)),
                //     ],
                //   ),
                //   trailing: Switch(
                //     value: Get.isDarkMode,
                //     onChanged: (bool isActive) =>
                //         Get.find<ThemeController>().toggleTheme(),
                //     activeColor: Theme.of(context).primaryColor,
                //     activeTrackColor:
                //         Theme.of(context).primaryColor.withOpacity(0.5),
                //   ),
                //   onTap: () => Get.find<ThemeController>().toggleTheme(),
                // ),
                ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/image/drawer/help.png',
                          width: 20, color: Colors.black),
                      const SizedBox(width: 5),
                      Text('Help & Support',
                          style: defaultFont(
                              size: 18,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed(RouteHelper.getSupportRoute());
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/image/drawer/about.png',
                          width: 20, color: Colors.black),
                      const SizedBox(width: 5),
                      Text('About Us',
                          style: defaultFont(
                              size: 18,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  onTap: () async {
                    if (GetPlatform.isMobile) {
                      Get.toNamed(RouteHelper.getInfoPage('About Us'));
                    } else {
                      if (!await launchUrlString(
                          'https://carclenx.com/car-washing-car-detailing-shop-car-parts-mobile/')) {
                        throw 'Could not launch https://carclenx.com/car-washing-car-detailing-shop-car-parts-mobile/';
                      }
                      // html.window.open(
                      //     'https://carclenx.com/car-washing-car-detailing-shop-car-parts-mobile/',
                      //     "_blank",
                      //     'location=yes');
                    }
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/image/drawer/privacy.png',
                          width: 20, color: Colors.black),
                      const SizedBox(width: 5),
                      Text('Privacy Policy',
                          style: defaultFont(
                              size: 18,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  onTap: () async {
                    if (GetPlatform.isMobile) {
                      Get.toNamed(
                          RouteHelper.getInfoPage('Privacy and Policy'));
                    } else {
                      if (!await launchUrlString(
                          'https://carclenx.com/privacy-policy')) {
                        throw 'Could not launch https://carclenx.com/privacy-policy';
                      }
                      // html.window.open('https://carclenx.com/privacy-policy',
                      //     "_blank", 'location=yes');
                    }
                  },
                ),
                ListTile(
                  title: Row(
                    children: [
                      Image.asset('assets/image/drawer/terms.png',
                          width: 20, color: Colors.black),
                      const SizedBox(width: 5),
                      Text('Terms & Conditions',
                          style: defaultFont(
                              size: 18,
                              weight: FontWeight.w400,
                              color: Colors.black)),
                    ],
                  ),
                  onTap: () {
                    Get.toNamed(
                        RouteHelper.getInfoPage('Terms and Conditions'));
                  },
                ),
                Get.find<AuthFactorsController>().isLoggedIn.value
                    ? ListTile(
                        title: Row(
                          children: [
                            Image.asset('assets/image/drawer/logout.png',
                                width: 20, color: Colors.black),
                            const SizedBox(width: 5),
                            Text('Logout',
                                style: defaultFont(
                                    size: 18,
                                    weight: FontWeight.w400,
                                    color: Colors.black)),
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          if (Get.find<AuthFactorsController>()
                              .isLoggedIn
                              .value) {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Alert..!',
                                    style: largeFont(Colors.red),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          'Are you sure to logout?',
                                          style: mediumFont(Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Yes',
                                        style: largeFont(Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        imageCacheController.clearCache();
                                        controller!.logOut().then((value) =>
                                            // Get.off(LoginPage())
                                            Get.offNamed(
                                                RouteHelper.getSignInRoute(
                                                    page: Get.currentRoute)));
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            imageCacheController.clearCache();
                            // controller.deleteGuestData().then((value) =>
                            //     Get.find<GuestController>().guestLogout(
                            //         Get.find<AuthFactorsController>()
                            //             .phoneNumber
                            //             .value));
                            // Get.off(LoginPage());
                            Get.offAndToNamed(RouteHelper.login);
                          }
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
