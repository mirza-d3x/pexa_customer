import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/title_widget.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/carshoppe/categorywise_productlisting.dart';
import 'package:shoppe_customer/view/screens/carshoppe/widget/view_all_catgry_prdct.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/home/widgets/slider.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../home/widgets/featured_products.dart';

class ShoppeListing extends StatelessWidget {
  final bool showNotification;
  final Color? backgroundColor;
  final bool isMain;
  final bool showSearch;
  ShoppeListing({super.key,
    this.showNotification=true,
    this.backgroundColor,
    this.isMain = false,
    this.showSearch=true,});

  static int pageNumber = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // ScrollController scrollController;
  void _onLoading(bool isReload) async {
    if (isReload) {
      pageNumber = 0;
    }
    await Future.delayed(const Duration(milliseconds: 500));
    int totalPage = Get.find<ProductCategoryController>().allPdtTotalPage!;
    if (pageNumber < totalPage) {
      pageNumber++;
      changePage(pageNumber);
      if (isReload) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
    } else {
      _refreshController.loadNoData();
    }
  }

  changePage(int page) async {
    await Get.find<ProductCategoryController>()
        .fetchAllProductListData(page.toString());
  }

  // void _scrollListener() {
  //   print(scrollController.position.extentAfter);
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     // _onLoading();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // scrollController = ScrollController()..addListener(_scrollListener);
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Container(
          height: 30,
            child: Column(
              children: [
                SizedBox(height: 4,),
                Expanded(
                  flex: 1,
                    child: Image.asset("assets/image/logo.png")),
                SizedBox(height: 2,),
                Text("Pexa",style: verySmallFontW600(Colors.black),)
              ],
            )),
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
            SizedBox(
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
                      SizedBox(width: 5,),

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
                              BorderRadius.all(Radius.circular(50)),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      )
                          : Container(
                        width: 25,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 25,
                          icon: Icon(
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
                          : SizedBox(),


                      showNotification
                          ? backgroundColor != null &&
                          backgroundColor == Colors.transparent &&
                          !isMain
                          ? Container(
                        width: 30,
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.notification),
                          child: GetBuilder<NotificationController>(
                              builder: (notificationController) {
                                return Container(
                                  height: 30,
                                  width: 30,
                                  padding: EdgeInsets.all(3),
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
                          : Container(
                        width: 30,
                        child: InkWell(
                          child: GetBuilder<NotificationController>(
                              builder: (notificationController) {
                                return Container(
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
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


                          :SizedBox()]
                ),
              );
            }),
          ],
        ),),*/
        /*appBar: (GetPlatform.isMobile
            ? CustomAppBar(title: 'Car Shoppe', showCart: true)
            : CustomAppBarWeb(
                title: 'Car Shoppe',
                showCart: true,
              )) as PreferredSizeWidget?,*/
        body: GetBuilder<ProductCategoryController>(
            builder: (categoryModelController) {
          return categoryModelController.fetchAllProductLoading.value
              ? const LoadingScreen()
              : categoryModelController.allProductListTemp.isEmpty
                  ? const NoProductErrorScreen()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: const Offset(0, 2),)
                          ]),
                          child:  Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: SizedBox(
                                        height: 50,
                                        child: Column(
                                          children: [
                                            Expanded(child: Image.asset("assets/image/logo.png")),
                                            Text("Pexa",style: verySmallFont(Colors.black),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 100,),
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
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset(
                                                        Images.car_ico,
                                                        width: 20,
                                                        color: Colors.black
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
                                            ]
                                        ),
                                      );
                                    }),
                                    const SizedBox(
                                      width: 10,
                                    ),
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
                                              const Icon(
                                                Icons.location_pin,
                                                size: 18,
                                                color: Colors.black,
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
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),
                                  const SizedBox(width: 10,),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                InkWell(
                                  onTap: () {
                                    Get.find<ShoppeSearchController>().clearList();
                                    Get.toNamed(RouteHelper.search);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12,right: 12),
                                    child: Container(
                                      height: 40,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.find<ShoppeSearchController>().clearList();
                                              Get.toNamed(RouteHelper.search);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(50)),

                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.search,
                                                  color: Colors.black38,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text("Search",style: smallFont(Colors.black38),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            // enableTwoLevel: true,
                            // scrollController: scrollController,
                            dragStartBehavior: DragStartBehavior.down,
                            onRefresh: () => _onLoading(true),
                            onLoading: () => _onLoading(false),
                            child: SingleChildScrollView(
                              // physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  GetBuilder<BannerController>(
                                      builder: (bannerController) {
                                        return bannerController
                                            .shoppeListing.isNotEmpty
                                            ? CarouselSlider.builder(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            viewportFraction: 1.0,
                                            enlargeCenterPage: true,
                                            height: ResponsiveHelper
                                                .isDesktop(context) |
                                            ResponsiveHelper.isTab(
                                                context)
                                                ? 240
                                                : 130,
                                            disableCenter: true,
                                            autoPlayInterval:
                                            const Duration(seconds: 6),
                                            onPageChanged: (index, reason) {},
                                          ),
                                          itemCount: bannerController
                                              .shoppeListing.length,
                                          itemBuilder: (context, index, _) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
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
                                                  image: bannerController
                                                      .shoppeListing.isNotEmpty
                                                      ? bannerController
                                                      .shoppeListing
                                                      .value[index]
                                                      : "",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                            : const SizedBox();
                                      }),
                                  const SizedBox(height: 20,),
                                  Container(
                                      height: 105,
                                      width: Get.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      color: Colors.white,
                                      child: ListView.builder(
                                        // controller: scrollController,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                        categoryModelController.categoryList.length +
                                            1,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              if (index == 0) {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewAllCategoryOfProduct(),));
                                              } else {
                                                var productLocations =
                                                    Get.find<ProductCategoryController>()
                                                        .productLocationList;
                                                var categoryId = categoryModelController
                                                    .categoryList[index - 1].id;

                                                Get.find<BannerController>().bannerData(
                                                  'shoppeCategoriesListing',
                                                );

                                                categoryModelController
                                                    .fetchSubCategoryData(categoryId);
                                                categoryModelController
                                                    .fetchProductsByCategory(categoryId,
                                                    productLocations, '1');
                                                Get.to(() => CategoryWiseProductListing(
                                                  subCategories:
                                                  categoryModelController
                                                      .subCategoryList,
                                                  data: categoryModelController
                                                      .categoryList[index - 1],
                                                  title: categoryModelController
                                                      .categoryList[index - 1].name,
                                                  idx: index - 1,
                                                ));
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 10),
                                              child: Column(
                                                children: [
                                                  index == 0
                                                      ? Container(
                                                    height: 55,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.white,
                                                      //shape: BoxShape.circle,
                                                      // boxShadow: [
                                                      //   BoxShadow(
                                                      //       blurRadius: 2,
                                                      //       color: Colors
                                                      //           .black26,
                                                      //       spreadRadius: 1)
                                                      // ],
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        Images.all_list_ico_new,
                                                        height: 35,
                                                        width: 35,
                                                      ),
                                                    ),
                                                  )
                                                      : SizedBox(
                                                    height: 55,
                                                    width: 55,
                                                    child: CustomImage(
                                                        image:
                                                        categoryModelController
                                                            .categoryList[
                                                        index - 1]
                                                            .thumbUrl[0]),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                      top: 1,
                                                    ),
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: 65,
                                                      padding: const EdgeInsets.symmetric(
                                                          vertical: 2),

                                                      child: Text(
                                                        index == 0
                                                            ? 'View All'
                                                            : categoryModelController
                                                            .categoryList[index - 1]
                                                            .name,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        shrinkWrap: true,
                                      )),
                                 /* GetBuilder<BannerController>(
                                      builder: (bannerController) {
                                    return bannerController
                                                .shoppeListing.length >
                                            0
                                        ? CarouselSlider.builder(
                                            options: CarouselOptions(
                                              autoPlay: true,
                                              viewportFraction: 1.0,
                                              enlargeCenterPage: true,
                                              height: ResponsiveHelper
                                                          .isDesktop(context) |
                                                      ResponsiveHelper.isTab(
                                                          context)
                                                  ? 240
                                                  : 100,
                                              disableCenter: true,
                                              autoPlayInterval:
                                                  Duration(seconds: 6),
                                              onPageChanged: (index, reason) {},
                                            ),
                                            itemCount: bannerController
                                                .shoppeListing.length,
                                            itemBuilder: (context, index, _) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
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
                                                    image: bannerController
                                                                .shoppeListing
                                                                .length >
                                                            0
                                                        ? bannerController
                                                            .shoppeListing
                                                            .value[index]
                                                        : "",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : SizedBox();
                                  }),*/
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: offeredProductWidget(categoryModelController),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10,right: 10),
                                    child: ImageSlider(),
                                  ),
                                 const SizedBox(height: 10,),
                                 /* Container(height: 300,
                                    width: double.maxFinite,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10,right: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Pexa",style: mediumBoldFont(Colors.black)),
                                              TextButton(onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAllProduct(),));
                                              }, child: Text("See All",style: mediumBoldFont(Colors.blue),))
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Expanded(
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics: ScrollPhysics(),
                                            itemCount: categoryModelController.allProductListTemp.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ShoppeProductTile(
                                                  childCount: 0,
                                                  elementCrossCount: 0,
                                                  index: index,
                                                  data: categoryModelController
                                                      .allProductListTemp,
                                                ),
                                              );
                                            },),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: featuredProductWidget(categoryModelController),
                                  ),
                                  /*GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(10),
                                    // controller: scrollController,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          ResponsiveHelper.isDesktop(context)
                                              ? Get.width / 6
                                              : ResponsiveHelper.isTab(context)
                                                  ? Get.width / 4
                                                  : Get.width / 2,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio: 1,
                                    ),
                                    itemCount: categoryModelController
                                        .allProductListTemp.length,
                                    itemBuilder: (context, index) {
                                      return ShoppeProductTile(
                                        childCount: 0,
                                        elementCrossCount: 0,
                                        index: index,
                                        data: categoryModelController
                                            .allProductListTemp,
                                      );
                                    },
                                  )*/

                                  // CustomGridView(
                                  //   padding: 10,
                                  //   childCount: categoryModelController
                                  //       .allProductListTemp.length,
                                  //   elementCrossCount: 2,
                                  //   data: categoryModelController
                                  //       .allProductListTemp,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
        }),

    );
  }




  Column offeredProductWidget(
      ProductCategoryController categoryModelController) {
    return Column(
      children: [
        categoryModelController.offered != null &&
            categoryModelController.offered!.resultData!.length > 6
            ? TitleData(
            title: 'Offered Products',
            onTap: () {
              Get.toNamed(RouteHelper.viewAllProducts, arguments: [
                {
                  'title': 'Offered Products',
                  'data': categoryModelController.offered,
                  'type': 'offered'
                }
              ]);
            })
            : const TitleData(title: 'Offered Products'),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: const FeaturedProducts(type: 'offered'),
        ),
      ],
    );
  }



  Column featuredProductWidget(
      ProductCategoryController categoryModelController) {
    return Column(
      children: [
        categoryModelController.featured != null &&
            categoryModelController.featured!.resultData!.length > 6
            ? TitleData(
            title: 'Featured Products',
            onTap: () {
              Get.toNamed(RouteHelper.viewAllProducts, arguments: [
                {
                  'title': 'Featured Products',
                  'data': categoryModelController.featured,
                  'type': 'feature'
                }
              ]);
            })
            : const TitleData(title: 'Featured Products'),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: const FeaturedProducts(type: 'feature'),
        ),
      ],
    );
  }

}
