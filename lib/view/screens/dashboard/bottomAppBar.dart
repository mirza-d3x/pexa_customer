import 'dart:async';
import 'package:shoppe_customer/controller/myController/appVersionController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/packageOfferController.dart';
import 'package:shoppe_customer/data/models/notification_body.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/screens/home/homescreen.dart';
import 'package:shoppe_customer/view/screens/cart/cart_screen.dart';
import 'package:shoppe_customer/view/screens/dashboard/widget/bottom_nav_item.dart';
import 'package:shoppe_customer/view/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/profile/profile_screen.dart';
import 'package:shoppe_customer/view/screens/support/support_screen.dart';

class DashBoard extends StatefulWidget {
  DashBoard(
      {super.key, required this.pageIndex, this.pageFromLogin = false, this.productId});
  final bool pageFromLogin;
  final int pageIndex;
  String? productId;

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final cartController = Get.find<CartControllerFile>();
  PageController? _pageController;
  int _pageIndex = 0;
  late List<Widget> _screens;
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.pageIndex;
    getCurrentLocation();
    // if (Get.find<CurrentLocationController>().locationEnabled.value) {
    //   Get.find<CurrentLocationController>().getUserLocation();
    // } else {
    //   Get.find<CurrentLocationController>().requestPermission();
    //   Get.find<CurrentLocationController>().getUserLocation();
    // }
    Get.find<AppVersionController>().checkVersionBalance();
    Get.find<ProductCategoryController>().setLocationForProductFetch();

    _pageController = PageController(initialPage: widget.pageIndex);
    _screens = [
      HomeScreen(newUser: widget.pageFromLogin),
      const OrderScreen(),
      CartScreen(fromNav: false, fromMain: true),
      const SupportScreen(),
      ProfileScreen(),

    ];
    if (widget.productId != null) {
      var id = widget.productId!;
      if (Get.find<AuthFactorsController>().isLoggedIn.value) {
        Get.find<CartControllerFile>().checkProductInCart(id);
      }

      Get.find<ProductCategoryController>()
          .fetchProductDetails(id)
          .then((value) {
        Get.toNamed(RouteHelper.productDetails);
      });
    }
  }

  var locationController = Get.find<locationPermissionController>();

  NotificationBody convertNotification(Map<String, dynamic> data) {
    return NotificationBody.fromJson(data);
  }

  getCurrentLocation() {
    if (locationController.userLocationString == '') {
      locationController.checkLocationStatus().then((value) {
        locationController.getUserLocation(isForAddress: false).then((value) {
          Get.find<AuthFactorsController>()
              .updateUserLocation(locationController.userLocationString);
        });
      });
      // Future.delayed(Duration(seconds: 2), (() async {
      //   locationController.determinePosition();
      //   if (locationController.locationEnabled.value == true &&
      //       locationController.permissionData.value == true) {
      //     await Geolocator.getCurrentPosition();
      //   }
      // }));
    }
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            if (_canExit) {
              return true;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Back press again to exit.',
                    style: TextStyle(color: Colors.white)),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              ));
              _canExit = true;
              Timer(const Duration(seconds: 2), () {
                _canExit = false;
              });
              return false;
            }
          }
        },
        child: SafeArea(
          bottom: true,
          top: false,
          child: Scaffold(
              bottomNavigationBar:
                  !GetPlatform.isWeb ? bottomBar() : const SizedBox(),
              body: PageView.builder(
                controller: _pageController,
                itemCount: _screens.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _screens[index];
                },
              )),
        ));
    //),
    //);
  }

  Widget bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 65,
      width: Get.width * 0.8,
      decoration: const BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
        /*  boxShadow: [
        BoxShadow(
            color: Color.fromARGB(31, 0, 0, 0),
            blurRadius: 5,
            spreadRadius: 7,
            offset: Offset(3, 0))
      ]*/
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: BottomNavItem(
                path: _pageIndex == 0 ? Images.home_active : Images.home,
                title: 'Home',
                isSelected: _pageIndex == 0,
                onTap: () {
                  Get.find<NotificationController>().setBottomNavSelectedPage(0);
                  _setPage(0);
                }),
          ),
          Expanded(
            child: BottomNavItem(
                path: _pageIndex == 1 ? Images.order_active : Images.order,
                title: 'Order',
                isSelected: _pageIndex == 1,
                onTap: () {
                  Get.find<NotificationController>().setBottomNavSelectedPage(1);
                  Get.find<PackageOfferController>().getAllOfers();
                  _setPage(1);
                }),
          ),
          Expanded(
            child: BottomNavItem(
                path: _pageIndex == 2 ? Images.cart_active : Images.cart,
                title: 'Cart',
                isSelected: _pageIndex == 2,
                onTap: () {
                  Get.find<NotificationController>().setBottomNavSelectedPage(2);
                  cartController.getCartDetails(true);
                  _setPage(2);
                }),
          ),
          Expanded(
            child: BottomNavItem(
                path: _pageIndex == 3 ? Images.supports_active : Images.supports,
                title: 'Support',
                isSelected: _pageIndex == 3,
                onTap: () {
                  Get.find<NotificationController>().setBottomNavSelectedPage(3);
                  _setPage(3);
                }),
          ),
          Expanded(
            child: BottomNavItem(
                path: _pageIndex == 4 ? Images.account_active : Images.account,
                title: 'Account',
                isSelected: _pageIndex == 4,
                onTap: () {
                  Get.find<NotificationController>().setBottomNavSelectedPage(4);
                  /*Get.find<PackageOfferController>().getAllOfers();*/
                  _setPage(4);
                }),
          ),
        ],
      ),
    );
  }
}
