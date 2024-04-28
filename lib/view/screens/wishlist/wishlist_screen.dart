import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';

class WishListScreen extends StatelessWidget {
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;
  const WishListScreen({super.key,
    this.showNotification = true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
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
                          Icon(
                            Icons.location_pin,
                            size: 18,
                            color: Colors.yellow[600],
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
                                color: Colors.yellow[600],
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
                                              notificationController
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
                    ]),
                  );
                }),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
