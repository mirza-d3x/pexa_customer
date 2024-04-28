import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/home/widgets/video_play.dart';
import 'package:shoppe_customer/view/screens/service/widget/service_list_tile.dart';
import 'package:shoppe_customer/view/screens/home/widgets/drawer.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';

class ServiceList extends StatefulWidget {
  ServiceList({
    super.key,
    required this.title,
    required this.data,
    required this.type,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch = true,
    this.showNotification = true,
  });
  final String? title;
  List<dynamic>? data;
  final String? type;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;
  final bool showNotification;

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  var isLoading = false;

  bool hasData = false;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: HomeDrawer(controller: controller),
      appBar: (GetPlatform.isMobile
          ? CustomAppBar(title: widget.title)
          : CustomAppBarWeb(title: widget.title)) as PreferredSizeWidget?,
      body: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey.withOpacity(0.1),
              width: 0.5,
            )),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
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
                              color: Colors.black,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                                child: Row(
                              children: [
                                Expanded(
                                  child:
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
                                  }),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
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
                                    Get.bottomSheet(
                                        carBrandBottomSheet(context),
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
                        widget.showSearch
                            ? widget.backgroundColor != null &&
                                    widget.backgroundColor ==
                                        Colors.transparent &&
                                    !widget.isMain
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
                        widget.showNotification
                            ? widget.backgroundColor != null &&
                                    widget.backgroundColor ==
                                        Colors.transparent &&
                                    !widget.isMain
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
                                            color:
                                                Colors.white.withOpacity(0.7),
                                          ),
                                          child: NotificationIcon(
                                            backgroundColor:
                                                widget.backgroundColor,
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
                                            backgroundColor:
                                                widget.backgroundColor,
                                            hasNotification:
                                                notificationController
                                                    .hasNotification,
                                            isHome: widget.isMain,
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
                                Get.find<CartControllerFile>()
                                    .getCartDetails(true);
                                Get.toNamed(RouteHelper.cart, arguments: {
                                  'fromNav': !widget.isMain,
                                  'fromMain': widget.isMain,
                                  'prodId': ""
                                });
                              },
                              icon: const Icon(
                                Icons.shopping_cart_outlined,
                                size: 18,
                                color: Colors.black,
                              )),
                        ),
                      ]),
                    );
                  }),
                  const SizedBox(width: 10,),
                ],
              ),
            ),
          ),
          Expanded(child: switchSectionWidget(context)),

        ],
      ),
    );
  }

  Widget switchSectionWidget(BuildContext context) {
    return GetBuilder<BannerController>(builder: (bannerController) {
      if (widget.type == "carSpa") {
        return GetBuilder<CarSpaController>(builder: (carSpaController) {
          return bodyWidget(
              context: context,
              banner: bannerController.carspaBanners,
              data: carSpaController.carSpaCategory,
              isLoading: carSpaController.isCarspaservicelistLoading.isLoading);
        });
      } else if (widget.type == "mechanical") {
        return GetBuilder<MechanicalController>(
            builder: (mechanicalController) {
          return bodyWidget(
              context: context,
              banner: bannerController.mechanicalBanners,
              data: mechanicalController.mechanicalCategoryList,
              isLoading: mechanicalController.loaderHelper.isLoading);
        });
      } else {
        return GetBuilder<QuickHelpController>(builder: (quickHelpController) {
          return bodyWidget(
              context: context,
              banner: bannerController.quickhelpBanners,
              isLoading: quickHelpController.loaderHelper.isLoading,
              data: quickHelpController.quickHelpCategoryData);
        });
      }
    });
  }

  Widget bodyWidget(
      {RxList? banner,
      required bool isLoading,
      RxList? data,
      BuildContext? context}) {
    return isLoading
        ? const LoadingScreen()
        : data!.isEmpty
            ? SizedBox(
                height: MediaQuery.of(context!).size.height,
                child: const NoProductErrorScreen(
                  isService: true,
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          banner!.isEmpty
                              ? Container(
                                  height: ResponsiveHelper.isMobile(context)
                                      ? Get.height * 0.2
                                      : Get.height * 0.4,
                                  width: Get.width,
                                  color: Colors.white,
                                  child: Image.asset(
                                    Images.loading,
                                    fit: BoxFit.contain,
                                  ))
                              : CarouselSlider.builder(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: true,
                                    height: ResponsiveHelper.isMobile(context)
                                        ? Get.height * 0.2
                                        : Get.height * 0.4,
                                    disableCenter: true,
                                    autoPlayInterval: const Duration(seconds: 6),
                                    onPageChanged: (index, reason) {},
                                  ),
                                  itemCount: banner.length,
                                  itemBuilder: (context, index, _) {
                                    return InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              // borderRadius: BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[
                                                        Get.isDarkMode
                                                            ? 800
                                                            : 200]!,
                                                    spreadRadius: 1,
                                                    blurRadius: 5)
                                              ],
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: ClipRRect(
                                              child: CustomImage(
                                                image: banner[index],
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ));
                                  },
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Pexa Services",
                              style: mediumBoldFont(Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                  ),
                  isLoading
                      ? const SliverToBoxAdapter(child: LoadingScreen())
                      : dataGrid(
                          context: context!, isLoading: isLoading, data: data),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: VideoPlaying(),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                ],
              );
  }

  SliverPadding dataGrid(
      {required BuildContext context, bool? isLoading, required RxList data}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ResponsiveHelper.isMobile(context)
              ? Get.width / 3
              : Get.width / 6,
          mainAxisSpacing: 10,
              crossAxisSpacing: 10,
          childAspectRatio: 0.90,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return /*Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),*/
                // height: MediaQuery.of(context).size.height * 0.3,
                // width: MediaQuery.of(context).size.width * 0.3,
                /* child:*/
                ServiceListTile(
              data: data[index],
              index: index,
              type: widget.type,
            );
          },
          childCount: data.length,
        ),
      ),
    );
  }
}
