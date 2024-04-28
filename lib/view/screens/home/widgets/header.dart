import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/searchLocationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/appVersionController.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/base/cart_widget.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/service/services_listing.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  Header({
    super.key,
    this.newUser,
    this.showNotification=true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch=true,

  });
  final bool? newUser;
  final carSpaController = Get.find<CarSpaController>();
  final quickHelpController = Get.find<QuickHelpController>();
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AuthFactorsController.getUserModelId();
      // Get.find<ProductCategoryController>().setLocationForProductFetch();
      // Get.find<CurrentLocationController>().getUserLocation();
      if ((Get.find<CarModelController>().carModelName!.isEmpty || newUser!) &&
          !GetPlatform.isWeb) {
        if (Get.find<AuthFactorsController>().isMIdAvailable == false) {
          if (Get.find<CarModelController>().modelList!.isNotEmpty &&
              Get.find<CarModelController>().brandList!.isNotEmpty) {
            if (!Get.isBottomSheetOpen!) {
              Get.bottomSheet(carBrandBottomSheet(context),
                  isScrollControlled: true);
            }
          } else {
            Get.find<CarModelController>().fetchData().then((value) {
              if (!Get.isBottomSheetOpen!) {
                Get.bottomSheet(carBrandBottomSheet(context),
                    isScrollControlled: true);
              }
            });
          }
        }
      }
    });

    return Column(
      children: [
        Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.home_banner),
              fit: BoxFit.cover,
            ),
          ),*/
          // height: Get.height * 0.391,
          child: ResponsiveHelper.isDesktop(context) || GetPlatform.isWeb
              ? webHeader(context)
              : mobileHeader(context),
        ),
        /*Container(
          height: 40,
          // width: Get.width,
          color: Color.fromRGBO(45, 45, 45, 1),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                flex: 1,
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
                        Icon(
                          Icons.location_pin,
                          size: 20,
                          color: Colors.yellow[600],
                        ),
                        SizedBox(width: 5),
                        Expanded(child:
                            GetBuilder<locationPermissionController>(
                                builder: (currentLocationController) {
                          return currentLocationController.userLocationString
                                  .toString()
                                  .contains(',')
                              ? Text(
                                  (currentLocationController.userLocationString!.split(',')[0] +
                                                  ',' +
                                                  currentLocationController
                                                      .userLocationString!
                                                      .split(',')[1])
                                              .length >
                                          20
                                      ? (currentLocationController.userLocationString!.split(',')[0] +
                                                  ',' +
                                                  currentLocationController
                                                      .userLocationString!
                                                      .split(',')[1])
                                              .substring(0, 19) +
                                          '...'
                                      : currentLocationController.userLocationString!.split(',')[0] == '' &&
                                              currentLocationController.userLocationString!
                                                      .split(',')
                                                      .length ==
                                                  0
                                          ? 'Unknown Place'
                                          : currentLocationController.userLocationString!.split(',')[0] +
                                              ',' +
                                              currentLocationController.userLocationString!.split(',')[1],
                                  style: mediumFont(Colors.white),
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
                                  style: mediumFont(Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                        })),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GetBuilder<CarModelController>(builder: (carModelController) {
                return Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      print('Clicked on car icon');
                      //carBrandBottomSheet(context);
                      carModelController.isMakeSearch.value = false;
                      if (carModelController.brandList!.length > 0 &&
                          carModelController.brandList!.length > 0) {
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          Images.car_ico,
                          width: 20,
                          color: Colors.yellow[600],
                        ),
                        SizedBox(width: 5),
                        Flexible(
                            child: Text(
                                " ${carModelController.carBrandName}"
                                " ${carModelController.carModelName}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: defaultFont(
                                    size: 15,
                                    weight: FontWeight.w400,
                                    color: Colors.white))),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        )*/
      ],
    );
  }

  int icon_index = 1;
  _renderWidget() {
    if (icon_index == 0) {
      return Image.asset(
        Images.car_shoppie_ico_New,
        width: 30,
      );
    } else {
      return Image.asset(
        Images.carclenx_ico,
        width: 30,
      );
    }
  }

  Widget mobileHeader(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: const Color(0xcfff7d417),
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                        color: Colors.black
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                          child:
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
                      const Icon(Icons.arrow_drop_down,)
                    ],
                  ),
                ),
              ),

            ),
            const SizedBox(
              width: 10,
            ),
            GetBuilder<CarModelController>(builder: (carModelController) {
              return Expanded(
                flex: 60,
                child: Row(
                  children: [
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
                    const SizedBox(width: 5,),

                    showSearch
                        ? backgroundColor != null &&
                        backgroundColor == Colors.transparent &&
                        !isMain
                        ? Center(
                      child: InkWell(
                        onTap: () {
                          Get.find<ShoppeSearchController>().clearList();
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
                          Get.find<ShoppeSearchController>().clearList();
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
                        onTap: () => Get.toNamed(RouteHelper.notification),
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
                                  hasNotification:
                                  notificationController.hasNotification,
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
                                  hasNotification:
                                  notificationController.hasNotification,
                                  isHome: isMain,
                                ),
                              );
                            }),
                        onTap: () => Get.toNamed(RouteHelper.notification),
                      ),
                    )


              :const SizedBox(),

                    SizedBox(
                      width: 20,
                      child: IconButton(
                          onPressed: () {
                            Get.find<CartControllerFile>()
                                .getCartDetails(true);
                            Get.toNamed(RouteHelper.cart, arguments: {
                              'fromNav': !isMain,
                              'fromMain': isMain,
                              'prodId': ""
                            });
                          },
                          icon: const Icon(Icons.shopping_cart_outlined,size: 18,color: Colors.black,)
                      ),
                    ),
                    const SizedBox(width: 10,),
                  ]
                ),
              );
            }),
          ],
        ),),
      /*  GetBuilder<NavigationDrawerController>(builder: (scaff) {
          return CustomAppBar(
            title: '',
            isMain: true,
            onMenuClick: () {
              scaff.openDrawer();
            },
            backgroundColor: Colors.transparent,
            showCart: GetPlatform.isWeb,
          );
        }),*/
        const SizedBox(height: 18),
        Row(
          children: [
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GetBuilder<AuthFactorsController>(
                        builder: (authController) {
                      return Text(
                          (authController.userName != '' &&
                                  authController.userName != null)
                              ? 'Hello ${authController.userName.toUpperCase()},'
                              : 'Hello User',
                          style:
                              defaultFont(size: 14, weight: FontWeight.w400));
                    })),
              ],
            ),
          ],
        ),
        //SizedBox(height: 5),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Welcome to PEXA',
              style: defaultFont(size: 17, weight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            height: 50,
            // padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    InkWell(
                      onTap: () {
                        if (carSpaController.carSpaCategory.isEmpty) {
                          carSpaController.getAllCarSpaCategory();
                        }
                        Get.toNamed(RouteHelper.serviceListing, arguments: [
                          {
                            'title': 'Mobile Car Wash',
                            'type': 'carSpa',
                            'data': carSpaController.carSpaCategory
                          }
                        ]);
                       /* Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ServiceList(title: 'Mobile Car Wash', type: 'carSpa', data: carSpaController.carSpaCategory)));*/
                      },
                      child: Ink(
                        child: Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black26),

                          ),
                         /* width: ResponsiveHelper.isDesktop(context)
                              ? 150
                              : Get.width / 2,*/
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // AnimatedSwitcher(
                              //   duration: const Duration(seconds: 2),
                              //   child: _renderWidget(),
                              // ),
                               Image.asset(
                                Images.car_spa_ico_New,
                                 width: 25,
                               ),
                              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text('Door step\nCar wash',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: defaultFont(
                                      size: Dimensions.fontSizeDefault,
                                      weight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Get.find<BannerController>().bannerData(
                          'ShoppeListingBanner',
                        );
                        Get.find<ProductCategoryController>()
                            .fetchCategoryData();
                        Get.find<ProductCategoryController>()
                            .fetchAllProductListData('1');
                        Get.toNamed(RouteHelper.getShoppeList());
                      },
                      child: Ink(
                        child: Container(
                          height: 50,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                20),
                            border: Border.all(color: Colors.black26)
                          ),
                         /* width: ResponsiveHelper.isDesktop(context)
                              ? 150
                              : Get.width / 2,*/
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.car_shoppie_ico_New,
                                width: 25,
                              ),
                              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Text('Car Shoppe',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: defaultFont(
                                      size: Dimensions.fontSizeDefault,
                                      weight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*SizedBox(width: 10),*/
                    /*GetBuilder<MechanicalController>(
                        builder: (mechanicalController) {
                      return InkWell(
                        onTap: () {
                          if (mechanicalController
                                  .mechanicalCategoryList.length >
                              0) {
                            Get.toNamed(RouteHelper.serviceListing, arguments: [
                              {
                                'title': 'Mechanical Services',
                                'type': 'mechanical',
                                'data':
                                    mechanicalController.mechanicalCategoryList
                              }
                            ]);
                          } else {
                            mechanicalController.getMechanicalCategory();
                            Get.toNamed(RouteHelper.serviceListing, arguments: [
                              {
                                'title': 'Mechanical Services',
                                'type': 'mechanical',
                                'data':
                                    mechanicalController.mechanicalCategoryList
                              }
                            ]);
                          }
                        },
                        child: Ink(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            width: ResponsiveHelper.isDesktop(context)
                                ? 150
                                : Get.width / 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.mech_serv_ico,
                                  width: 30,
                                ),
                                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Text('Mechanic Services',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: defaultFont(
                                          size: Dimensions.fontSizeDefault,
                                          weight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),*/
                    /*SizedBox(width: 10),*/
                  /*  InkWell(
                      onTap: () {
                        quickHelpController.getQuickHelpCategoryData();
                        Get.toNamed(RouteHelper.serviceListing, arguments: [
                          {
                            'title': 'Roadside Assistance',
                            'type': 'quickHelp',
                            'data': quickHelpController.quickHelpCategoryData,
                          }
                        ]);
                      },
                      child: Ink(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          width: ResponsiveHelper.isDesktop(context)
                              ? 150
                              : Get.width / 5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.road_assis_ico,
                                width: 30,
                              ),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, right: 3.0),
                                child: Text('Roadside Assistance',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: defaultFont(
                                      size: 14,
                                      weight: FontWeight.w700,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),*/
                  ],
                )
              ],
            ),
          ),
        ),
        Get.find<AppVersionController>().isOutDated.value
            ? Bouncing(
                onPress: () async {
                  if (Platform.isAndroid || Platform.isIOS) {
                    final appId = Platform.isAndroid
                        ? 'com.carclenx.motor.shoping'
                        : '1613868591';
                    final url = Uri.parse(
                      Platform.isAndroid
                          ? "market://details?id=$appId"
                          : "https://apps.apple.com/app/pexa-shoppe/id$appId",
                    );
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                  // if (Platform.isAndroid) {
                  //   if (!await launchUrl(Uri.parse(
                  //       'https://play.google.com/store/apps/details?id=com.carclenx.motor.shoping')))
                  //     throw 'Could not launch URL';
                  // } else if (Platform.isIOS) {
                  //   if (!await launchUrl(Uri.parse(
                  //       'https://apps.apple.com/in/app/pexa-shoppe/id1613868591')))
                  //     throw 'Could not launch URL';
                  // }
                },
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                        size: 15,
                      ),
                      Text(
                        ' You are using the old version. Please update..!!',
                        style: smallFontW600(Colors.white),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget webHeader(BuildContext context) {
    return Column(
      children: [
        GetBuilder<NavigationDrawerController>(builder: (scaff) {
          return CustomAppBarWeb(
            title: '',
            isMain: true,
            onMenuClick: () {
              scaff.openDrawer();
            },
            backgroundColor: Colors.transparent,
            showCart: true,
          );
        }),
        ResponsiveHelper.isDesktop(context)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: GetBuilder<AuthFactorsController>(
                              builder: (authController) {
                            return Text(
                                (authController.userName != '' &&
                                        authController.userName != null)
                                    ? 'Hello ${authController.userName.toUpperCase()},'
                                    : 'Hello User',
                                style: defaultFont(
                                    size: 20, weight: FontWeight.w400));
                          })),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text('Welcome to PEXA',
                            style:
                                defaultFont(size: 30, weight: FontWeight.w400)),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(
                    width: Get.width * 0.1,
                  ),
                  headerCategories(context),
                  const Spacer()
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GetBuilder<AuthFactorsController>(
                          builder: (authController) {
                        return Text(
                            (authController.userName != '' &&
                                    authController.userName != null)
                                ? 'Hello ${authController.userName.toUpperCase()},'
                                : 'Hello User',
                            style:
                                defaultFont(size: 20, weight: FontWeight.w400));
                      })),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Welcome to PEXA',
                        style: defaultFont(size: 30, weight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  headerCategories(context),
                ],
              ),
        Get.find<AppVersionController>().isOutDated.value
            ? Bouncing(
                onPress: () async {
                  if (Platform.isAndroid || Platform.isIOS) {
                    final appId = Platform.isAndroid
                        ? 'com.carclenx.motor.shoping'
                        : '1613868591';
                    final url = Uri.parse(
                      Platform.isAndroid
                          ? "market://details?id=$appId"
                          : "https://apps.apple.com/app/pexa-shoppe/id$appId",
                    );
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  }
                  // if (Platform.isAndroid) {
                  //   if (!await launchUrl(Uri.parse(
                  //       'https://play.google.com/store/apps/details?id=com.carclenx.motor.shoping')))
                  //     throw 'Could not launch URL';
                  // } else if (Platform.isIOS) {
                  //   if (!await launchUrl(Uri.parse(
                  //       'https://apps.apple.com/in/app/pexa-shoppe/id1613868591')))
                  //     throw 'Could not launch URL';
                  // }
                },
                child: Container(
                  height: 35,
                  margin: const EdgeInsets.only(bottom: 5, left: 25, right: 25),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.red,
                        size: 15,
                      ),
                      Text(
                        ' You are using the old version. Please update..!!',
                        style: smallFontW600(Colors.white),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Padding headerCategories(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        height: 100,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                InkWell(
                  onTap: () {
                    Get.find<BannerController>().bannerData(
                      'ShoppeListingBanner',
                    );
                    Get.find<ProductCategoryController>().fetchCategoryData();
                    Get.find<ProductCategoryController>()
                        .fetchAllProductListData('1');
                    Get.toNamed(RouteHelper.getShoppeList());
                  },
                  child: Ink(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: ResponsiveHelper.isDesktop(context)
                          ? Get.width * 0.09
                          : Get.width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.car_shoppie_ico,
                            width: 30,
                          ),
                          const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          Text('Car Shoppe',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: defaultFont(
                                  size: Dimensions.fontSizeDefault,
                                  weight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                InkWell(
                  onTap: () {
                    if (carSpaController.carSpaCategory.isEmpty) {
                      carSpaController.getAllCarSpaCategory();
                    }
                    Get.toNamed(RouteHelper.serviceListing, arguments: [
                      {
                        'title': 'Car Spa',
                        'type': 'carSpa',
                        'data': carSpaController.carSpaCategory
                      }
                    ]);
                  },
                  child: Ink(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      width: ResponsiveHelper.isDesktop(context)
                          ? Get.width * 0.09
                          : Get.width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.car_spa_ico,
                            width: 40,
                          ),
                          const SizedBox(height: 10),
                          Text('Car Spa',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: defaultFont(
                                  size: Dimensions.fontSizeDefault,
                                  weight: FontWeight.w700)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                GetBuilder<MechanicalController>(
                    builder: (mechanicalController) {
                  return InkWell(
                    onTap: () {
                      if (mechanicalController.mechanicalCategoryList.isNotEmpty) {
                        Get.toNamed(RouteHelper.serviceListing, arguments: [
                          {
                            'title': 'Mechanical Services',
                            'type': 'mechanical',
                            'data': mechanicalController.mechanicalCategoryList
                          }
                        ]);
                      } else {
                        mechanicalController.getMechanicalCategory();
                        Get.toNamed(RouteHelper.serviceListing, arguments: [
                          {
                            'title': 'Mechanical Services',
                            'type': 'mechanical',
                            'data': mechanicalController.mechanicalCategoryList
                          }
                        ]);
                      }
                    },
                    child: Ink(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: ResponsiveHelper.isDesktop(context)
                            ? Get.width * 0.09
                            : Get.width / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Images.mech_serv_ico,
                              width: 40,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Text('Mechanic Services',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: defaultFont(
                                      size: Dimensions.fontSizeDefault,
                                      weight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                InkWell(
                  onTap: () {
                    quickHelpController.getQuickHelpCategoryData();
                    Get.toNamed(RouteHelper.serviceListing, arguments: [
                      {
                        'title': 'Roadside Assistance',
                        'type': 'quickHelp',
                        'data': quickHelpController.quickHelpCategoryData,
                      }
                    ]);
                  },
                  child: Ink(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      width: ResponsiveHelper.isDesktop(context)
                          ? Get.width * 0.09
                          : Get.width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Images.road_assis_ico,
                            width: 40,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 3.0, right: 3.0),
                            child: Text('Roadside Assistance',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: defaultFont(
                                  size: Dimensions.fontSizeDefault,
                                  weight: FontWeight.w700,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
