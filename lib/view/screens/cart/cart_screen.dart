import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/not_logged_in_screen.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/home/widgets/drawer.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/cart/widget/cartPrdouctTile.dart';
import 'package:shoppe_customer/view/screens/error_screen/shop_error_screen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  final fromNav;
  final fromMain;
  final String? prodId;
  final cartController = Get.find<CartControllerFile>();
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;

  CartScreen({super.key, 
    required this.fromNav,
    required this.fromMain,
    this.prodId,
    this.showNotification = true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
  });

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  AuthFactorsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? GetBuilder<NavigationDrawerController>(builder: (scaff) {
            if (fromMain && !fromNav) {
              if (scaff.scaffoldKey.currentState != null &&
                  scaff.scaffoldKey.currentState!.isDrawerOpen) {
                scaff.closeDrawer();
              }
            }
            return Scaffold(

                /*drawer: fromMain && !fromNav
                    ? HomeDrawer(controller: controller)
                    : null,*/
                /*appBar: CustomAppBar(
                  title: 'My Cart',
                  isMain: !fromNav,
                  onMenuClick: () {
                    if (!fromNav) {
                      scaff.openDrawer();
                    }
                  },
                ),*/
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
                                return currentLocationController
                                        .userLocationString
                                        .toString()
                                        .contains(',')
                                    ? Text(
                                        ('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}').length >
                                                20
                                            ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController
                                                            .userLocationString!
                                                            .split(',')[1]}')
                                                    .substring(0, 19)}...'
                                            : currentLocationController.userLocationString!.split(',')[0] == '' &&
                                                    currentLocationController
                                                            .userLocationString!
                                                            .split(',').isEmpty
                                                ? 'Unknown Place'
                                                : '${currentLocationController
                                                        .userLocationString!
                                                        .split(',')[0]},${currentLocationController
                                                        .userLocationString!
                                                        .split(',')[1]}',
                                        style: smallFont(Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    : Text(
                                        currentLocationController
                                                    .userLocationString
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
                    GetBuilder<CarModelController>(
                        builder: (carModelController) {
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
                                    Get.bottomSheet(
                                        carBrandBottomSheet(context),
                                        isScrollControlled: true);
                                  }
                                } else {
                                  carModelController.fetchData().then((value) {
                                    if (!Get.isBottomSheetOpen!) {
                                      Get.bottomSheet(
                                          carBrandBottomSheet(context),
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
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(50)),
                                            color:
                                                Colors.white.withOpacity(0.7),
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
                                        onTap: () => Get.toNamed(
                                            RouteHelper.notification),
                                        child:
                                            GetBuilder<NotificationController>(
                                                builder:
                                                    (notificationController) {
                                          return Container(
                                            height: 30,
                                            width: 30,
                                            padding: const EdgeInsets.all(3),
                                            alignment: Alignment.center,
                                            // padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.white.withOpacity(0.7),
                                            ),
                                            child: NotificationIcon(
                                              backgroundColor: backgroundColor,
                                              hasNotification:
                                                  notificationController
                                                      .hasNotification,
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 30,
                                      child: InkWell(
                                        child:
                                            GetBuilder<NotificationController>(
                                                builder:
                                                    (notificationController) {
                                          return Container(
                                            width: 30,
                                            alignment: Alignment.center,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: NotificationIcon(
                                              backgroundColor: backgroundColor,
                                              hasNotification:
                                                  notificationController
                                                      .hasNotification,
                                              isHome: isMain,
                                            ),
                                          );
                                        }),
                                        onTap: () => Get.toNamed(
                                            RouteHelper.notification),
                                      ),
                                    )
                              : const SizedBox(),
                          const SizedBox(width: 10,),
                        ]),
                      );
                    }),
                  ],
                ),
              ),
              Get.find<AuthFactorsController>().isLoggedIn.value
                  ? GetBuilder<CartControllerFile>(builder: (cartController) {
                      return cartController.cartList == null ||
                              cartController.cartList!.isEmpty
                          ? const Expanded(
                              child: Center(
                                child: ShopErrorScreen(
                                  title: 'Ohh...! Your cart is empty',
                                  subTitle: 'But it doesn\'t have to be',
                                  imagePath: Images.empty_cart_icon,
                                  route: RouteHelper.shoppeListing,
                                ),
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          padding: const EdgeInsets.all(10),
                                          physics: const BouncingScrollPhysics(),
                                          child: Center(
                                            child: SizedBox(
                                              width: Dimensions.WEB_MAX_WIDTH,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: cartController
                                                          .cartList!.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CartProductTile(
                                                          index: index,
                                                          cartItem:
                                                              cartController
                                                                      .cartList![
                                                                  index],
                                                        );
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Grand Total :',
                                                    style: mediumFont(
                                                        Colors.black),
                                                  ),
                                                  Text(
                                                    '₹${cartController
                                                            .cartGrandTotal}',
                                                    style:
                                                        largeFont(Colors.black),
                                                  ),
                                                  Text(
                                                    '(${cartController.cartList!.length} items)',
                                                    style: mediumFont(
                                                        Colors.black),
                                                  )
                                                ],
                                              ),
                                              Expanded(
                                                child: Bouncing(
                                                  onPress: () {
                                                    if (cartController
                                                                .cartGrandTotal >
                                                            1 &&
                                                        cartController.cartList!.isNotEmpty) {
                                                      Get.find<
                                                              CouponController>()
                                                          .clearValue();
                                                      Get.find<
                                                              AddressControllerFile>()
                                                          .getAddress()
                                                          .then((value) => {
                                                                if (Get.find<
                                                                        AddressControllerFile>()
                                                                    .addressList!
                                                                    .isNotEmpty)
                                                                  {
                                                                    Get.find<
                                                                            AddressControllerFile>()
                                                                        .getDefaultAddress()
                                                                        .then(
                                                                          (value) => Get.toNamed(
                                                                              RouteHelper.cartCheckOut,
                                                                              arguments: {
                                                                                'amount': cartController.cartGrandTotal.value
                                                                              }),
                                                                        )
                                                                  }
                                                                else
                                                                  {
                                                                    Get.toNamed(
                                                                        RouteHelper
                                                                            .cartCheckOut,
                                                                        arguments: {
                                                                          'amount': cartController
                                                                              .cartGrandTotal
                                                                              .value
                                                                        }),
                                                                  }
                                                              });
                                                    } else {
                                                      showCustomSnackBar(
                                                          "Nothing to checkout.",
                                                          isError: true);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    margin:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'Pay ₹${cartController
                                                                .cartGrandTotal}',
                                                        style: largeFont(
                                                            Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          cartController.cartGrandTotal <=
                                                      cartController
                                                          .cartMinimumOrderAmount &&
                                                  cartController
                                                          .cartGrandTotal >
                                                      1
                                              ? Container(
                                                  child: Text(
                                                    "* Delivery charge of ₹${cartController
                                                            .cartShipping
                                                            .round()} is applicable",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .amber.shade900,
                                                        fontSize: 12),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                    })
                  : const NotLoggedInScreen()
            ]));
          })
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
