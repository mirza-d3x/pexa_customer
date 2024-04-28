import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/imageCacheController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/infoPage/widgets/aboutUs.dart';
import 'package:shoppe_customer/view/screens/infoPage/widgets/tnc.dart';
import 'package:shoppe_customer/view/screens/notification/notification_screen.dart';
import 'package:shoppe_customer/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class ProfileScreen extends StatelessWidget {
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;
  AuthFactorsController controller = Get.find<AuthFactorsController>();
  final imageCacheController = Get.put(ImageCacheController());
  ProfileScreen({
    super.key,
    this.showNotification = true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
  });

  @override
  Widget build(BuildContext context) {
    final carModelController = Get.find<CarModelController>();
    final addressController = Get.find<AddressControllerFile>();
    addressController.getAddress();
    bool isLoggedIn = Get.find<AuthFactorsController>().isLoggedIn.value;
    print(Get.find<AuthFactorsController>().userId.value);

    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,

            /*appBar: (GetPlatform.isMobile
                    ? CustomAppBar(
                        */ /* onBackPressed: () {
                Navigator.pop(context);
              },*/ /*
                        title: "Profile",
                      )
                    : CustomAppBarWeb(title: 'Profile'))
                as PreferredSizeWidget?,*/
            body:
                /*ProfileBgWidget(*/
                /*backButton: true,*/
                /*circularImage: Container(*/
                //decoration: BoxDecoration(
                // border:
                //     Border.all(width: 2, color: Theme.of(context).cardColor),
                //shape: BoxShape.circle,
                //color: Colors.white,
                //),
                Column(children: [
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
              /* Container(
                    height: 100,
                    width: double.maxFinite,
                    color: Colors.white,
                     child: Row(
                       children: [
                         Expanded(
                           flex: 25,
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
                         SizedBox(width: 20,),
                         GetBuilder<CarModelController>(builder: (carModelController) {
                           return Expanded(
                             flex: 25,
                             child: Row(
                                 children: [
                                   Expanded(
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
                                                       size: 12,
                                                       weight: FontWeight.w400,
                                                       color: Colors.black))),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ]
                             ),
                           );
                         }),
                       ],
                     ),
                  ),*/

              Container(
                height: 130,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(
                        10,
                      ),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.person_2_rounded,
                            size: 25,
                            color: Colors.white,
                          )),
                      /*Image.asset(
                          Images.profile_blue_ico,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )*/
                      const SizedBox(
                        width: 20,
                      ),
                      isLoggedIn
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (Get.find<AuthFactorsController>()
                                                  .userDetails!
                                                  .name !=
                                              '' &&
                                          Get.find<AuthFactorsController>()
                                                  .userDetails!
                                                  .name !=
                                              null)
                                      ? Get.find<AuthFactorsController>()
                                          .userDetails!
                                          .name!
                                          .toUpperCase()
                                      : Get.find<AuthFactorsController>()
                                          .phoneNumber
                                          .value
                                          .toString(),
                                  style: defaultFont(
                                      color: Colors.black,
                                      size: 18,
                                      weight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Phone No : ${Get.find<AuthFactorsController>().phoneNumber.value.toString()}",
                                  style: defaultFont(
                                    color: Colors.black,
                                    size: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    "User ID : ${Get.find<AuthFactorsController>().userId.value.toString()}")
                              ],
                            )
                          : Text(
                              'Guest User',
                              style: mediumFont(Colors.black),
                            ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                      child: Container(
                    //width: Dimensions.WEB_MAX_WIDTH,
                    //color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Column(children: [
                      SizedBox(height: isLoggedIn ? 10 : 0),
                      isLoggedIn
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.addressDetailsPage,
                                      arguments: {'context': context});
                                },
                                child: Container(
                                  //height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                             CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.yellow[200],
                                              child: Image.asset("assets/image/icons/locationprofile.png",scale: 3,),
                                            ),
                                            const SizedBox(width: 20,),
                                            const Text(
                                              'Saved Addresses',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        // Obx(
                                        //   () => addressController
                                        //           .addressList.isEmpty
                                        //       ? Center(
                                        //           child: (addressController
                                        //                   .isNoAddress.value)
                                        //               ? Text(
                                        //                   'No Saved Addressess',
                                        //                   style: mediumFont(
                                        //                       Colors.red),
                                        //                 )
                                        //               : LoadingAnimationWidget
                                        //                   .twistingDots(
                                        //                   leftDotColor:
                                        //                       const Color(
                                        //                           0xFF4B4B4D),
                                        //                   rightDotColor:
                                        //                       const Color(
                                        //                           0xFFf7d417),
                                        //                   size: 50,
                                        //                 ),
                                        //           // : SizedBox(
                                        //           // height: 35,
                                        //           // width: 35,
                                        //           // child: Image.asset(Images.spinner,
                                        //           //     fit: BoxFit.fill)),
                                        //         )
                                        //       : Expanded(
                                        //           child: Container(
                                        //             height: 250,
                                        //             child: ListView.builder(
                                        //                 physics:
                                        //                     NeverScrollableScrollPhysics(),
                                        //                 itemCount:
                                        //                     addressController
                                        //                         .addressList
                                        //                         .length,
                                        //                 shrinkWrap: true,
                                        //                 scrollDirection:
                                        //                     Axis.vertical,
                                        //                 itemBuilder:
                                        //                     (context, index) {
                                        //                   return Column(
                                        //                     children: [
                                        //                       // Text(addressController
                                        //                       //       .addressList[index].name),
                                        //                       AddressListTile(
                                        //                         index: index,
                                        //                         addressListResultData:
                                        //                             addressController
                                        //                                     .addressList[
                                        //                                 index],
                                        //                         backContext:
                                        //                             backContext,
                                        //                       ),
                                        //                       // SizedBox(
                                        //                       //   height: 5,
                                        //                       // )
                                        //                     ],
                                        //                   );
                                        //                 }),
                                        //           ),
                                        //         ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),

                      SizedBox(height: isLoggedIn ? 10 : 0),
                      isLoggedIn
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.support,
                                      arguments: {'context': context});
                                },
                                child: Container(
                                  //height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.yellow[200],
                                              child: Image.asset("assets/image/icons/question.png",scale: 3,),
                                            ),
                                            const SizedBox(width: 20,),
                                           /* CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.yellow[400],
                                              child: Image.asset("assets/image/icons/question.png",scale: 2,),
                                            ),*/
                                            const Text(
                                              'Contact Support',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        // Obx(
                                        //   () => addressController
                                        //           .addressList.isEmpty
                                        //       ? Center(
                                        //           child: (addressController
                                        //                   .isNoAddress.value)
                                        //               ? Text(
                                        //                   'No Saved Addressess',
                                        //                   style: mediumFont(
                                        //                       Colors.red),
                                        //                 )
                                        //               : LoadingAnimationWidget
                                        //                   .twistingDots(
                                        //                   leftDotColor:
                                        //                       const Color(
                                        //                           0xFF4B4B4D),
                                        //                   rightDotColor:
                                        //                       const Color(
                                        //                           0xFFf7d417),
                                        //                   size: 50,
                                        //                 ),
                                        //           // : SizedBox(
                                        //           // height: 35,
                                        //           // width: 35,
                                        //           // child: Image.asset(Images.spinner,
                                        //           //     fit: BoxFit.fill)),
                                        //         )
                                        //       : Expanded(
                                        //           child: Container(
                                        //             height: 250,
                                        //             child: ListView.builder(
                                        //                 physics:
                                        //                     NeverScrollableScrollPhysics(),
                                        //                 itemCount:
                                        //                     addressController
                                        //                         .addressList
                                        //                         .length,
                                        //                 shrinkWrap: true,
                                        //                 scrollDirection:
                                        //                     Axis.vertical,
                                        //                 itemBuilder:
                                        //                     (context, index) {
                                        //                   return Column(
                                        //                     children: [
                                        //                       // Text(addressController
                                        //                       //       .addressList[index].name),
                                        //                       AddressListTile(
                                        //                         index: index,
                                        //                         addressListResultData:
                                        //                             addressController
                                        //                                     .addressList[
                                        //                                 index],
                                        //                         backContext:
                                        //                             backContext,
                                        //                       ),
                                        //                       // SizedBox(
                                        //                       //   height: 5,
                                        //                       // )
                                        //                     ],
                                        //                   );
                                        //                 }),
                                        //           ),
                                        //         ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),


                      SizedBox(height: isLoggedIn ? 10 : 0),
                      isLoggedIn
                          ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: InkWell(
                          onTap: () {
                            Get.to(const Terms());

                          },
                          child: Container(
                            //height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.yellow[200],
                                        child: Image.asset("assets/image/icons/terms-and-conditions.png",scale: 3,),
                                      ),
                                      const SizedBox(width: 20,),
                                      const Text(
                                        'Terms and Conditions',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  // Obx(
                                  //   () => addressController
                                  //           .addressList.isEmpty
                                  //       ? Center(
                                  //           child: (addressController
                                  //                   .isNoAddress.value)
                                  //               ? Text(
                                  //                   'No Saved Addressess',
                                  //                   style: mediumFont(
                                  //                       Colors.red),
                                  //                 )
                                  //               : LoadingAnimationWidget
                                  //                   .twistingDots(
                                  //                   leftDotColor:
                                  //                       const Color(
                                  //                           0xFF4B4B4D),
                                  //                   rightDotColor:
                                  //                       const Color(
                                  //                           0xFFf7d417),
                                  //                   size: 50,
                                  //                 ),
                                  //           // : SizedBox(
                                  //           // height: 35,
                                  //           // width: 35,
                                  //           // child: Image.asset(Images.spinner,
                                  //           //     fit: BoxFit.fill)),
                                  //         )
                                  //       : Expanded(
                                  //           child: Container(
                                  //             height: 250,
                                  //             child: ListView.builder(
                                  //                 physics:
                                  //                     NeverScrollableScrollPhysics(),
                                  //                 itemCount:
                                  //                     addressController
                                  //                         .addressList
                                  //                         .length,
                                  //                 shrinkWrap: true,
                                  //                 scrollDirection:
                                  //                     Axis.vertical,
                                  //                 itemBuilder:
                                  //                     (context, index) {
                                  //                   return Column(
                                  //                     children: [
                                  //                       // Text(addressController
                                  //                       //       .addressList[index].name),
                                  //                       AddressListTile(
                                  //                         index: index,
                                  //                         addressListResultData:
                                  //                             addressController
                                  //                                     .addressList[
                                  //                                 index],
                                  //                         backContext:
                                  //                             backContext,
                                  //                       ),
                                  //                       // SizedBox(
                                  //                       //   height: 5,
                                  //                       // )
                                  //                     ],
                                  //                   );
                                  //                 }),
                                  //           ),
                                  //         ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                          : const SizedBox(),


                      // _isLoggedIn
                      //     ? Obx(
                      //         () => Text(
                      //           (Get.find<AuthFactorsController>()
                      //                           .userName
                      //                           .value !=
                      //                       '' &&
                      //                   Get.find<AuthFactorsController>()
                      //                           .userName
                      //                           .value !=
                      //                       null)
                      //               ? Get.find<AuthFactorsController>()
                      //                   .userName
                      //                   .value
                      //                   .toUpperCase()
                      //               : Get.find<AuthFactorsController>()
                      //                   .phoneNumber
                      //                   .value
                      //                   .toString(),
                      //           style: mediumFont(Colors.black),
                      //         ),
                      //       )
                      //     : Text(
                      //         'Guest User',
                      //         style: mediumFont(Colors.black),
                      //       ),
                      // SizedBox(height: _isLoggedIn ? 30 : 0),
                      /* _isLoggedIn
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                      ),
                                    ]),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.directions_car,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                              " ${carModelController.carBrandName} ${carModelController.carModelName}"),
                                          Spacer(),
                                          Bouncing(
                                            onPress: () {
                                              Get.find<CarModelController>()
                                                  .isMakeSearch
                                                  .value = false;
                                              if (Get.find<CarModelController>()
                                                  .carModel
                                                  .isEmpty) {
                                                Get.find<CarModelController>()
                                                    .fetchData();
                                              }
                                              Get.bottomSheet(
                                                  carBrandBottomSheet(context),
                                                  isScrollControlled: true);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .primaryColor,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.black,
                                                    size: 16,
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Divider(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.notifications_none_outlined,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 10),
                                          Text('Notification'),
                                          Spacer(),
                                          Switch(
                                            value: true,
                                            activeColor: Theme.of(context)
                                                .secondaryHeaderColor,
                                            onChanged: (value) {
                                              SmartDialog.showToast(
                                                'Can\'t turn off notifications',
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(),*/
                      SizedBox(height: isLoggedIn ? 10 : 0),
                      Get.find<AuthFactorsController>().isLoggedIn.value
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 70,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                      ),
                                    ]),
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.yellow[200],
                                        child: Image.asset("assets/image/icons/Group.png",scale: 3,),
                                      ),
                                      const SizedBox(width: 24,),
                                      Text('Logout',
                                          style: defaultFont(
                                              size: 18,
                                              weight: FontWeight.w400,
                                              color: Colors.black)),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
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
                                                    style:
                                                        mediumFont(Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  'Yes',
                                                  style:
                                                      largeFont(Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  imageCacheController
                                                      .clearCache();
                                                  controller.logOut().then(
                                                      (value) {
                                                    if (value) {
                                                      Get.offNamed(RouteHelper
                                                          .getSignInRoute(
                                                              page: Get
                                                                  .currentRoute));
                                                    }
                                                  }
                                                      // Get.off(LoginPage())
                                                      );
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
                                ),
                              ),
                            )
                          : const SizedBox(),
                      /*SizedBox(height: _isLoggedIn ? 10 : 0),
                      _isLoggedIn
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.addressDetailsPage,
                                      arguments: {'context': context});
                                },
                                child: Container(
                                  //height: 80,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Saved Addresses',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                        // Obx(
                                        //   () => addressController
                                        //           .addressList.isEmpty
                                        //       ? Center(
                                        //           child: (addressController
                                        //                   .isNoAddress.value)
                                        //               ? Text(
                                        //                   'No Saved Addressess',
                                        //                   style: mediumFont(
                                        //                       Colors.red),
                                        //                 )
                                        //               : LoadingAnimationWidget
                                        //                   .twistingDots(
                                        //                   leftDotColor:
                                        //                       const Color(
                                        //                           0xFF4B4B4D),
                                        //                   rightDotColor:
                                        //                       const Color(
                                        //                           0xFFf7d417),
                                        //                   size: 50,
                                        //                 ),
                                        //           // : SizedBox(
                                        //           // height: 35,
                                        //           // width: 35,
                                        //           // child: Image.asset(Images.spinner,
                                        //           //     fit: BoxFit.fill)),
                                        //         )
                                        //       : Expanded(
                                        //           child: Container(
                                        //             height: 250,
                                        //             child: ListView.builder(
                                        //                 physics:
                                        //                     NeverScrollableScrollPhysics(),
                                        //                 itemCount:
                                        //                     addressController
                                        //                         .addressList
                                        //                         .length,
                                        //                 shrinkWrap: true,
                                        //                 scrollDirection:
                                        //                     Axis.vertical,
                                        //                 itemBuilder:
                                        //                     (context, index) {
                                        //                   return Column(
                                        //                     children: [
                                        //                       // Text(addressController
                                        //                       //       .addressList[index].name),
                                        //                       AddressListTile(
                                        //                         index: index,
                                        //                         addressListResultData:
                                        //                             addressController
                                        //                                     .addressList[
                                        //                                 index],
                                        //                         backContext:
                                        //                             backContext,
                                        //                       ),
                                        //                       // SizedBox(
                                        //                       //   height: 5,
                                        //                       // )
                                        //                     ],
                                        //                   );
                                        //                 }),
                                        //           ),
                                        //         ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(),*/
                      // SizedBox(height: _isLoggedIn ? 30 : 0),
                      // _isLoggedIn
                      //     ? Obx(() => ProfileButton(
                      //         icon: Icons.car_repair,
                      //         title:
                      //             " ${carModelController.carBrandName.value} ${carModelController.carModelName.value}",
                      //         suffixIcon: Icons.edit,
                      //         onTap: () {
                      //           if (carModelController.carModel.isEmpty) {
                      //             carModelController.fetchData();
                      //           }
                      //           carSelectionBottomSheet(context);
                      //         }))
                      //     : SizedBox(),
                      // SizedBox(
                      //     height:
                      //         _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
                      // _isLoggedIn
                      //     ? ProfileButton(
                      //         icon: Icons.notifications,
                      //         title: 'NOTIFICATION',
                      //         isButtonActive: true,
                      //         onTap: () {},
                      //       )
                      //     : SizedBox(),
                      // SizedBox(
                      //     height:
                      //         _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
                      // _isLoggedIn
                      //     ? ProfileButton(
                      //         icon: Icons.location_city,
                      //         title: 'MANAGE ADDRESS',
                      //         onTap: () {
                      //           addressController.getAddress();
                      //           Get.find<AddressControllerFile>()
                      //               .fromPexaShoppe
                      //               .value = false;
                      //           Get.to(() => AddressDetailsPage(
                      //                 backContext: context,
                      //               ));
                      //         })
                      //     : SizedBox(),
                      // SizedBox(
                      //     height:
                      //         _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),
                      // _isLoggedIn
                      //     ? ProfileButton(
                      //         icon: Icons.person,
                      //         title: 'USER DETAILS',
                      //         onTap: () {
                      //           addressController.getAddress();
                      //           Get.find<AddressControllerFile>()
                      //               .fromPexaShoppe
                      //               .value = false;
                      //           Get.to(() => UserProfilePage());
                      //         })
                      //     : SizedBox()
                    ]),
                  ))),
            ]))
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
