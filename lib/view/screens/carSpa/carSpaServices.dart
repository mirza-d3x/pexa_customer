import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaServiceTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/home/widgets/clients_testimonial.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:shoppe_customer/view/screens/service/widget/service_list_tile.dart';

class CarSpaServices extends StatefulWidget {
  const CarSpaServices({
    super.key,
    required this.title,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
    this.showNotification = true,
    this.type,
  });
  final String? title;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;
  final bool showNotification;
  final String? type;
  @override
  State<CarSpaServices> createState() => _CarSpaServicesState();
}

class _CarSpaServicesState extends State<CarSpaServices> {
  AuthFactorsController? controller;
  @override
  void initState() {
    controller = Get.find<AuthFactorsController>();
    var bannerController = Get.find<BannerController>();
    if (widget.type == 'carSpa') {
      bannerController.bannerData('carspa');
    } else if (widget.type == 'mechanical') {
      bannerController.bannerData('mechanical');
    } else {
      bannerController.bannerData('quickhelp');
    }
    // TODO: implement initState
    super.initState();
  }

  //final int index;
  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: (GetPlatform.isMobile
                ? CustomAppBar(title: widget.title)
                : CustomAppBarWeb(title: widget.title)) as PreferredSizeWidget?,
            /*appBar: (GetPlatform.isMobile
                ? CustomAppBar(
                    title: title!.toUpperCase(),
                    backgroundColor: Colors.transparent,
                  )
                : CustomAppBarWeb(
                    title: title!.toUpperCase(),
                    backgroundColor: Colors.transparent)) as PreferredSizeWidget?,*/
            backgroundColor: Theme.of(context).colorScheme.background,
            body: GetBuilder<CarSpaController>(builder: (carSpaController) {
              return carSpaController.isCarspaservicelistLoading.isLoading
                  ? const LoadingScreen()
                  : carSpaController.carSpaService.isEmpty
                      ? const NoProductErrorScreen()
                      : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 420,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 90.0, bottom: 20.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.1),
                                              width: 0.5,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 40,
                                                child: InkWell(
                                                  onTap: () {
                                                    // Get.find<locationPermissionController>()
                                                    //     .determinePosition();
                                                    // Get.find<SearchLocationController>().resetSearch();
                                                    Get.toNamed(
                                                        RouteHelper
                                                            .locationSearch,
                                                        arguments: {
                                                          'page': Get
                                                              .currentRoute,
                                                          'isForAddress':
                                                          false
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
                                                        Expanded(
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child: GetBuilder<
                                                                      locationPermissionController>(
                                                                      builder:
                                                                          (currentLocationController) {
                                                                        return currentLocationController
                                                                            .userLocationString
                                                                            .toString()
                                                                            .contains(
                                                                            ',')
                                                                            ? Text(
                                                                          ('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}').length > 20
                                                                              ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}').substring(0, 19)}...'
                                                                              : currentLocationController.userLocationString!.split(',')[0] == '' && currentLocationController.userLocationString!.split(',').isEmpty
                                                                              ? 'Unknown Place'
                                                                              : '${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}',
                                                                          style:
                                                                          smallFont(Colors.black),
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          maxLines:
                                                                          1,
                                                                        )
                                                                            : Text(
                                                                          currentLocationController.userLocationString.toString().length > 20
                                                                              ? currentLocationController.userLocationString.toString().substring(0, 10)
                                                                              : currentLocationController.userLocationString.toString(),
                                                                          style:
                                                                          smallFont(Colors.black),
                                                                          overflow:
                                                                          TextOverflow.ellipsis,
                                                                          maxLines:
                                                                          1,
                                                                        );
                                                                      }),
                                                                ),
                                                                const Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_outlined,
                                                                  size: 20,
                                                                )
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GetBuilder<CarModelController>(
                                                  builder:
                                                      (carModelController) {
                                                    return Expanded(
                                                      flex: 60,
                                                      child: Row(children: [
                                                        Expanded(
                                                          child: InkWell(
                                                            onTap: () async {
                                                              print(
                                                                  'Clicked on car icon');
                                                              //carBrandBottomSheet(context);
                                                              carModelController
                                                                  .isMakeSearch
                                                                  .value = false;
                                                              if (carModelController
                                                                  .brandList!.isNotEmpty &&
                                                                  carModelController
                                                                      .brandList!.isNotEmpty) {
                                                                if (!Get
                                                                    .isBottomSheetOpen!) {
                                                                  Get.bottomSheet(
                                                                      carBrandBottomSheet(
                                                                          context),
                                                                      isScrollControlled:
                                                                      true);
                                                                }
                                                              } else {
                                                                carModelController
                                                                    .fetchData()
                                                                    .then(
                                                                        (value) {
                                                                      if (!Get
                                                                          .isBottomSheetOpen!) {
                                                                        Get.bottomSheet(
                                                                            carBrandBottomSheet(
                                                                                context),
                                                                            isScrollControlled:
                                                                            true);
                                                                      }
                                                                    });
                                                              }
                                                            },
                                                            child: Row(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                Image.asset(
                                                                  Images.car_ico,
                                                                  width: 20,
                                                                  color: Colors.black,
                                                                ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Flexible(
                                                                    child: Text(
                                                                        " ${carModelController.carBrandName}"
                                                                            " ${carModelController.carModelName}",
                                                                        maxLines:
                                                                        1,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        style: defaultFont(
                                                                            size:
                                                                            12,
                                                                            weight: FontWeight
                                                                                .w400,
                                                                            color:
                                                                            Colors.black))),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        widget.showSearch
                                                            ? widget.backgroundColor !=
                                                            null &&
                                                            widget.backgroundColor ==
                                                                Colors
                                                                    .transparent &&
                                                            !widget.isMain
                                                            ? Center(
                                                          child:
                                                          InkWell(
                                                            onTap: () {
                                                              Get.find<
                                                                  ShoppeSearchController>()
                                                                  .clearList();
                                                              Get.toNamed(
                                                                  RouteHelper
                                                                      .search);
                                                            },
                                                            child:
                                                            Container(
                                                              height:
                                                              30,
                                                              width: 30,
                                                              decoration:
                                                              BoxDecoration(
                                                                borderRadius:
                                                                const BorderRadius.all(Radius.circular(50)),
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(0.7),
                                                              ),
                                                              child:
                                                              const Center(
                                                                child:
                                                                Icon(
                                                                  Icons
                                                                      .search,
                                                                  color:
                                                                  Colors.black,
                                                                  size:
                                                                  18,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                            : SizedBox(
                                                          width: 25,
                                                          child:
                                                          IconButton(
                                                            padding:
                                                            EdgeInsets
                                                                .zero,
                                                            iconSize:
                                                            25,
                                                            icon: const Icon(
                                                              Icons
                                                                  .search,
                                                              color: Colors
                                                                  .black,
                                                              size: 18,
                                                            ),
                                                            onPressed:
                                                                () {
                                                              Get.find<
                                                                  ShoppeSearchController>()
                                                                  .clearList();
                                                              Get.toNamed(
                                                                  RouteHelper
                                                                      .search);
                                                            },
                                                          ),
                                                        )
                                                            : const SizedBox(),
                                                        widget.showNotification
                                                            ? widget.backgroundColor !=
                                                            null &&
                                                            widget.backgroundColor ==
                                                                Colors
                                                                    .transparent &&
                                                            !widget.isMain
                                                            ? SizedBox(
                                                          width: 30,
                                                          child:
                                                          InkWell(
                                                            onTap: () =>
                                                                Get.toNamed(
                                                                    RouteHelper.notification),
                                                            child: GetBuilder<
                                                                NotificationController>(
                                                                builder:
                                                                    (notificationController) {
                                                                  return Container(
                                                                    height:
                                                                    30,
                                                                    width:
                                                                    30,
                                                                    padding:
                                                                    const EdgeInsets.all(3),
                                                                    alignment:
                                                                    Alignment.center,
                                                                    // padding: const EdgeInsets.all(5),
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      shape:
                                                                      BoxShape.circle,
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(0.7),
                                                                    ),
                                                                    child:
                                                                    NotificationIcon(
                                                                      backgroundColor:
                                                                      widget.backgroundColor,
                                                                      hasNotification:
                                                                      notificationController.hasNotification,
                                                                    ),
                                                                  );
                                                                }),
                                                          ),
                                                        )
                                                            : SizedBox(
                                                          width: 30,
                                                          child:
                                                          InkWell(
                                                            child: GetBuilder<
                                                                NotificationController>(
                                                                builder:
                                                                    (notificationController) {
                                                                  return Container(
                                                                    width:
                                                                    30,
                                                                    alignment:
                                                                    Alignment.center,
                                                                    decoration:
                                                                    const BoxDecoration(
                                                                      shape:
                                                                      BoxShape.circle,
                                                                    ),
                                                                    child:
                                                                    NotificationIcon(
                                                                      backgroundColor:
                                                                      widget.backgroundColor,
                                                                      hasNotification:
                                                                      notificationController.hasNotification,
                                                                      isHome:
                                                                      widget.isMain,
                                                                    ),
                                                                  );
                                                                }),
                                                            onTap: () =>
                                                                Get.toNamed(
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
                                      ),
                                      const SizedBox(
                                        height: 14,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      carSpaController
                                                          .carSpaBannerImages[0],
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            /* child: CustomImage(
                                                  image: carSpaController
                                                      .carSpaBannerImages[0],
                                                  fit: BoxFit.cover,
                                                ),*/
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(padding: const EdgeInsets.only(left: 12,right: 12),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              physics: const ScrollPhysics(),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      const SizedBox(height: 30,),
                                                      GestureDetector(
                                                        onTap: (){
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
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/image/View All image.png"))),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 9,),
                                                      Text("view all",style: verySmallFontBold(Colors.black),)
                                                    ],
                                                  ),
                                                  const SizedBox(width: 10,),
                                                  SizedBox(
                                                    height: 92,
                                                    child:  dataList(context: context),
                                                  )

                                                ],
                                              ),
                                            )

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*child: Stack(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          height: 250,
                                          child: CustomImage(
                                            image: carSpaController
                                                .carSpaBannerImages[0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            height: 10,
                                            width:
                                                MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color:
                                                  Theme.of(context).backgroundColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),*/

                              ),
                              Expanded(
                                child: CustomScrollView(
                                  shrinkWrap: true,
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildListDelegate(
                                        List.generate(
                                            carSpaController.carSpaService.length,
                                            (indx) {
                                          return CarSpaServiceTile(
                                            index: indx,
                                            carSpaServiceResultData:
                                                carSpaController.carSpaService[indx],
                                          );
                                        }),
                                      ),
                                    ),
                                    SliverToBoxAdapter(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        height: 160,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.withOpacity(0.1),
                                                width: 0.5,
                                              )),
                                          child: const Padding(
                                            padding: EdgeInsets.all(12),
                                            child: ClientsTestimonial(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
            }))
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }



  dataList(
      {required BuildContext context}) {
    return GetBuilder<CarSpaController>(builder: (carSpaController) {
      return ListView.builder(
        itemCount: carSpaController.carSpaCategory.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 4,right: 4),
            child: ServiceListTile(
              data: carSpaController.carSpaCategory[index],
              index: index,
              type: widget.type,
            ),
          );
        },
      );
    });
  }
}
