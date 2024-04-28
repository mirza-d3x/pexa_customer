import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/support/widget/support_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SupportScreen extends StatelessWidget {
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;

  const SupportScreen({
    super.key,
    this.showNotification = true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
  });

  final bool showSearch;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: (GetPlatform.isMobile
          ? CustomAppBar(
              onBackPressed: () {
                Navigator.pop(context);
              },
              title: "Help & Support",
            )
          : CustomAppBarWeb(title: 'Help & Support')) as PreferredSizeWidget?,*/
      body: Column(children: [
        AppBar(
          backgroundColor: const Color(0xcfff7d417),
          elevation: 2,

          title: Row(
            children: [
              Expanded(
                flex: 40,
                child: InkWell(
                  onTap: () {
                    // Get.find<locationPermissionController>()
                    //     .determinePosition();
                    // Get.find<SearchLocationController>().resetSearch();
                    Get.toNamed(RouteHelper.locationSearch, arguments: {
                      'page': Get.currentRoute,
                      'isForAddress': false
                    });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Expanded(child:
                            GetBuilder<locationPermissionController>(
                                builder: (currentLocationController) {
                          return currentLocationController.userLocationString
                                  .toString()
                                  .contains(',')
                              ? Text(
                                  ('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController
                                                      .userLocationString!
                                                      .split(',')[1]}')
                                              .length >
                                          20
                                      ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController
                                                      .userLocationString!
                                                      .split(',')[1]}')
                                              .substring(0, 19)}...'
                                      : currentLocationController.userLocationString!.split(',')[0] == '' &&
                                              currentLocationController.userLocationString!
                                                      .split(',').isEmpty
                                          ? 'Unknown Place'
                                          : '${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}',
                                  style: smallFont(Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )
                              : Text(
                                  currentLocationController.userLocationString
                                              .toString()
                                              .length >
                                          20
                                      ? currentLocationController
                                          .userLocationString
                                          .toString()
                                          .substring(0, 10)
                                      : currentLocationController
                                          .userLocationString
                                          .toString(),
                                  style: smallFont(Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                        })),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GetBuilder<CarModelController>(builder: (carModelController) {
                return Expanded(
                  flex: 60,
                  child: Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          print('Clicked on car icon');
                          //carBrandBottomSheet(context);
                          carModelController.isMakeSearch.value = false;
                          if (carModelController.brandList!.isNotEmpty &&
                              carModelController.brandList!.isNotEmpty) {
                            if (!Get.isBottomSheetOpen!) {
                              Get.bottomSheet(carBrandBottomSheet(context),
                                  isScrollControlled: true);
                            }
                          } else {
                            carModelController.fetchData().then((value) {
                              if (!Get.isBottomSheetOpen!) {
                                Get.bottomSheet(carBrandBottomSheet(context),
                                    isScrollControlled: true);
                              }
                            });
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Images.car_ico,
                              width: 25,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                                child: Text(
                                    " ${carModelController.carBrandName}"
                                    " ${carModelController.carModelName}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: defaultFont(
                                        size: 12,
                                        weight: FontWeight.w400,
                                        color: Colors.black))),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    showSearch
                        ? backgroundColor != null &&
                                backgroundColor == Colors.transparent &&
                                !isMain
                            ? Center(
                                child: InkWell(
                                  onTap: () {
                                    Get.find<ShoppeSearchController>()
                                        .clearList();
                                    Get.toNamed(RouteHelper.search);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(50)),
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 25,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  iconSize: 25,
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  onPressed: () {
                                    Get.find<ShoppeSearchController>()
                                        .clearList();
                                    Get.toNamed(RouteHelper.search);
                                  },
                                ),
                              )
                        : const SizedBox(),
                    showNotification
                        ? backgroundColor != null &&
                                backgroundColor == Colors.transparent &&
                                !isMain
                            ? SizedBox(
                                width: 30,
                                child: InkWell(
                                  onTap: () =>
                                      Get.toNamed(RouteHelper.notification),
                                  child: GetBuilder<NotificationController>(
                                      builder: (notificationController) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      padding: const EdgeInsets.all(3),
                                      alignment: Alignment.center,
                                      // padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.7),
                                      ),
                                      child: NotificationIcon(
                                        backgroundColor: backgroundColor,
                                        hasNotification: notificationController
                                            .hasNotification,
                                      ),
                                    );
                                  }),
                                ),
                              )
                            : SizedBox(
                                width: 30,
                                child: InkWell(
                                  child: GetBuilder<NotificationController>(
                                      builder: (notificationController) {
                                    return Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: NotificationIcon(
                                        backgroundColor: backgroundColor,
                                        hasNotification: notificationController
                                            .hasNotification,
                                        isHome: isMain,
                                      ),
                                    );
                                  }),
                                  onTap: () =>
                                      Get.toNamed(RouteHelper.notification),
                                ),
                              )
                        : const SizedBox(),
                    SizedBox(
                      width: 20,
                      child: IconButton(
                          onPressed: () {
                            Get.find<CartControllerFile>().getCartDetails(true);
                            Get.toNamed(RouteHelper.cart, arguments: {
                              'fromNav': !isMain,
                              'fromMain': isMain,
                              'prodId': ""
                            });
                          },
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 18,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(width: 10,),
                  ]),
                );
              }),
            ],
          ),
        ),
        // SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
        const SizedBox(
          height: 40,
        ),
        Image.asset(
          "assets/image/menu/customercare.png",
          scale: 4,
        ),
        /*CustomImage(
          image:
              'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fhelp%20logo%2Fsupport_image.png?alt=media&token=b84c3d0c-e8d7-4063-8f8e-f1bd11776471',
          height: GetPlatform.isMobile ? 110 : Get.height * 0.3,
          fit: BoxFit.contain,
        ),*/
        const SizedBox(height: 30),
        Text(
          "How Can We Help You ?",
          style: largeFontBold(Colors.black),
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () async {
            const url = "https://wa.me/9745401234";
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              throw 'Could not launch $url';
            }

          /*  const url = "mailto:support@pexaapp.in";
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              throw 'Could not launch $url';
            }*/
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              height: 58,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: const Color(0xcfffbe77d),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 30,
                        child: Image.asset(
                          "assets/image/menu/customercare.png",
                          color: Colors.black,
                        )),
                    Text(
                      "Contact us via whatsapp",
                      style: smallFontNew(Colors.black),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        /*SupportButton(
          icon: Icons.call,
          title: 'Contact with us',
          info: '+91 9745 40 1234',
          onTap: () async {
            const url = "tel:+919745401234";
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),*/
        const SizedBox(height: 20),
        Text(
          "Customer care number",
          style: mediumBoldFont(Colors.black),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 70,
          width: 70,
          child: IconButton(
              onPressed: () async {
                const url = "tel:+919745401234";
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              icon: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xcfffbe77d),
                  child: Icon(
                    Icons.call,
                    color: Colors.black,
                  ))),
        ),
        const SizedBox(height: 20),

        /*SupportButton(
          icon: Icons.call,
          title: 'Customer Care',
          info: '1800 1214 150',
          onTap: () async {
            const url = "tel:18001214150";
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),*/
        Text(
          "Contact us via mail",
          style: mediumBoldFont(Colors.black),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 70,
          width: 70,
          child: IconButton(
              onPressed: () async {
                const url = "mailto:support@pexaapp.in";
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }
                /* const url = "tel:18001214150";
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url);
                } else {
                  throw 'Could not launch $url';
                }*/
              },
              icon: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(0xcfffbe77d),
                  child: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ))),
        ),
        const SizedBox(height: 20),
        Text(
          "Carclenx Pvt.Ltd\nTrivandrum, Kerala",
          textAlign: TextAlign.center,
          style: mediumFont(Colors.black),
        ),
        /* SupportButton(
          icon: Icons.location_on,
          title: 'Address',
          info:
              'Carclenx Pvt.Ltd, Mariyam Tower, Mamam, Attingal, Trivandrum, Kerala',
          onTap: () {},
        ),*/
        /*SupportButton(
          icon: Icons.mail_outline, title: 'Email Us',
          //info: Get.find<SplashController>().configModel.email,
          info: 'support@pexaapp.in',
          onTap: () async {
            const url = "mailto:support@pexaapp.in";
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            } else {
              throw 'Could not launch $url';
            }
            // final Uri emailLaunchUri = Uri(
            //   scheme: 'mailto',
            //   path: Get.find<SplashController>().configModel.email,
            // );
            // launch(emailLaunchUri.toString());
          },
        ),*/
      ]),
    );
  }
}
