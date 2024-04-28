import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/not_logged_in_screen.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/home/widgets/drawer.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/order/pastOrder.dart';
import 'package:shoppe_customer/view/screens/order/runnigOrders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;

  const OrderScreen({super.key, 
    this.showNotification = true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
  });
  // final orderController = Get.find<OrderScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationDrawerController>(builder: (scaff) {
      /* if (scaff.scaffoldKey.currentState != null &&
          scaff.scaffoldKey.currentState!.isDrawerOpen) {
        scaff.closeDrawer();
      }*/
      return GetBuilder<MyTabController>(builder: (tabx) {
        return GetBuilder<AuthFactorsController>(builder: (authController) {
          return Scaffold(
              /* key: scaff.scaffoldKey,
              backgroundColor: Color(0xFFF0F4F7),*/
              //drawer: HomeDrawer(controller: authController),
              /* appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(children: [
                  Expanded(
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
                              size: 18,
                              color: Colors.yellow[600],
                            ),
                            SizedBox(width: 5),
                            Expanded(
                                child:
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  Icon(Icons.favorite_border)
                ],),),*/
              /*appBar: CustomAppBar(
                backgroundColor: Colors.white,
                title: 'Orders',
               */ /* isMain: true,*/ /*
               */ /* onMenuClick: () {
                  scaff.openDrawer();
                },*/ /*
              ),*/
              body: authController.isLoggedIn.value
                  ? Column(
                      children: [
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
                                    Get.toNamed(RouteHelper.locationSearch,
                                        arguments: {
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
                                        Expanded(child: GetBuilder<
                                                locationPermissionController>(
                                            builder:
                                                (currentLocationController) {
                                          return currentLocationController
                                                  .userLocationString
                                                  .toString()
                                                  .contains(',')
                                              ? Text(
                                                  ('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}')
                                                              .length >
                                                          20
                                                      ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}')
                                                              .substring(
                                                                  0, 19)}...'
                                                      : currentLocationController.userLocationString!.split(',')[0] == '' &&
                                                              currentLocationController
                                                                      .userLocationString!
                                                                      .split(
                                                                          ',').isEmpty
                                                          ? 'Unknown Place'
                                                          : '${currentLocationController
                                                                  .userLocationString!
                                                                  .split(
                                                                      ',')[0]},${currentLocationController
                                                                  .userLocationString!
                                                                  .split(',')[1]}',
                                                  style:
                                                      smallFont(Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  style:
                                                      smallFont(Colors.black),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                );
                                        })),
                                        const Icon(Icons.arrow_drop_down,),
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
                                          carModelController
                                              .isMakeSearch.value = false;
                                          if (carModelController
                                                      .brandList!.isNotEmpty &&
                                              carModelController
                                                      .brandList!.isNotEmpty) {
                                            if (!Get.isBottomSheetOpen!) {
                                              Get.bottomSheet(
                                                  carBrandBottomSheet(context),
                                                  isScrollControlled: true);
                                            }
                                          } else {
                                            carModelController
                                                .fetchData()
                                                .then((value) {
                                              if (!Get.isBottomSheetOpen!) {
                                                Get.bottomSheet(
                                                    carBrandBottomSheet(
                                                        context),
                                                    isScrollControlled: true);
                                              }
                                            });
                                          }
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                backgroundColor ==
                                                    Colors.transparent &&
                                                !isMain
                                            ? Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.find<
                                                            ShoppeSearchController>()
                                                        .clearList();
                                                    Get.toNamed(
                                                        RouteHelper.search);
                                                  },
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: Colors.white
                                                          .withOpacity(0.7),
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
                                                    Get.find<
                                                            ShoppeSearchController>()
                                                        .clearList();
                                                    Get.toNamed(
                                                        RouteHelper.search);
                                                  },
                                                ),
                                              )
                                        : const SizedBox(),
                                    showNotification
                                        ? backgroundColor != null &&
                                                backgroundColor ==
                                                    Colors.transparent &&
                                                !isMain
                                            ? SizedBox(
                                                width: 30,
                                                child: InkWell(
                                                  onTap: () => Get.toNamed(
                                                      RouteHelper.notification),
                                                  child: GetBuilder<
                                                          NotificationController>(
                                                      builder:
                                                          (notificationController) {
                                                    return Container(
                                                      height: 30,
                                                      width: 30,
                                                      padding:
                                                          const EdgeInsets.all(3),
                                                      alignment:
                                                          Alignment.center,
                                                      // padding: const EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                      ),
                                                      child: NotificationIcon(
                                                        backgroundColor:
                                                            backgroundColor,
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
                                                  child: GetBuilder<
                                                          NotificationController>(
                                                      builder:
                                                          (notificationController) {
                                                    return Container(
                                                      width: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: const BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: NotificationIcon(
                                                        backgroundColor:
                                                            backgroundColor,
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
                                    SizedBox(
                                      width: 20,
                                      child: IconButton(
                                          onPressed: () {
                                            Get.find<CartControllerFile>()
                                                .getCartDetails(true);
                                            Get.toNamed(RouteHelper.cart,
                                                arguments: {
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
                        Center(
                          child: Container(
                            width: Dimensions.WEB_MAX_WIDTH,
                            color: Theme.of(context).cardColor,
                            child: TabBar(
                              controller: tabx.controller,
                              indicatorColor: Theme.of(context).primaryColor,
                              indicatorWeight: 5,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelColor:
                                  Theme.of(context).secondaryHeaderColor,
                              unselectedLabelColor:
                                  Theme.of(context).disabledColor,
                              unselectedLabelStyle: defaultFont(
                                color: Theme.of(context).primaryColor,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              labelStyle: defaultFont(
                                color: Theme.of(context).primaryColor,
                                size: 15,
                                weight: FontWeight.bold,
                              ),
                              tabs: tabx.myTabs,
                            ),
                          ),
                        ),
                        Expanded(
                            child: TabBarView(
                              controller: tabx.controller,
                              children: const [RunningOrdersView(), OrderHystoryView()],
                            )),
                       /* Expanded(
                          child: OrderHystoryView(),
                        ),*/
                      ],
                    )
                  : const NotLoggedInScreen());
        });
      });
    });
  }
}
