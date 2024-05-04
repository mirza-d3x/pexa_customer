import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/single_product_shimmer.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/carshoppe/categorywise_productlisting.dart';
import 'package:shoppe_customer/view/screens/carshoppe/widget/shoppe_product_tile.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/home/widgets/grid_featured.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ViewAllProduct extends StatefulWidget {
  ViewAllProduct({super.key, this.type});
  final String? type;

  @override
  State<ViewAllProduct> createState() => _ViewAllProductState();
}

class _ViewAllProductState extends State<ViewAllProduct> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  static int pageNumber = 1;
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

  @override
  void initState() {
    changePage(pageNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Padding(
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
                                            Expanded(
                                              child: Image.asset(
                                                  "assets/image/logo.png"),
                                            ),
                                            Text(
                                              "Pexa",
                                              style:
                                                  verySmallFont(Colors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 120,
                                    ),
                                    GetBuilder<CarModelController>(
                                      builder: (carModelController) {
                                        return Expanded(
                                          flex: 25,
                                          child: Row(
                                            children: [
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
                                                            .brandList!
                                                            .isNotEmpty &&
                                                        carModelController
                                                            .brandList!
                                                            .isNotEmpty) {
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
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: defaultFont(
                                                            size: 12,
                                                            weight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
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
                                          Get.toNamed(
                                              RouteHelper.locationSearch,
                                              arguments: {
                                                'page': Get.currentRoute,
                                                'isForAddress': false
                                              });
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_pin,
                                              size: 18,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: GetBuilder<
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
                                                              ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}').substring(0, 19)}...'
                                                              : currentLocationController.userLocationString!.split(',')[
                                                                              0] ==
                                                                          '' &&
                                                                      currentLocationController
                                                                          .userLocationString!
                                                                          .split(
                                                                              ',')
                                                                          .isEmpty
                                                                  ? 'Unknown Place'
                                                                  : '${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}',
                                                          style: smallFont(
                                                              Colors.black),
                                                          overflow: TextOverflow
                                                              .ellipsis,
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
                                                                  .substring(
                                                                      0, 10)
                                                              : currentLocationController
                                                                  .userLocationString
                                                                  .toString(),
                                                          style: smallFont(
                                                              Colors.black),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.find<ShoppeSearchController>()
                                        .clearList();
                                    Get.toNamed(RouteHelper.search);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Container(
                                      height: 40,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.find<ShoppeSearchController>()
                                                  .clearList();
                                              Get.toNamed(RouteHelper.search);
                                            },
                                            child: Container(
                                              height: 30,
                                              width: 30,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(50),
                                                ),
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
                                          Text(
                                            "Search",
                                            style: smallFont(Colors.black38),
                                          )
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
                            enablePullDown: false,
                            enablePullUp: true,
                            // enableTwoLevel: true,
                            // scrollController: scrollController,
                            dragStartBehavior: DragStartBehavior.down,
                            onRefresh: () => _onLoading(true),
                            onLoading: () => _onLoading(false),
                            child: SingleChildScrollView(
                              // physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /* SizedBox(height: 10,),*/
                                  /* Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10),
                                child: Text("Pexa",style: mediumBoldFont(Colors.black)),
                              ),*/
                                  Container(
                                    height: 105,
                                    width: Get.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color: Colors.white,
                                    child: ListView.builder(
                                      // controller: scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: widget.type == 'offered'
                                          ? categoryModelController.offered !=
                                                  null
                                              ? categoryModelController.offered!
                                                          .resultData!.length >
                                                      12
                                                  ? 12
                                                  : categoryModelController
                                                      .offered!
                                                      .resultData!
                                                      .length
                                              : 12
                                          : categoryModelController.featured !=
                                                  null
                                              ? categoryModelController
                                                          .featured!
                                                          .resultData!
                                                          .length >
                                                      6
                                                  ? 6
                                                  : categoryModelController
                                                      .featured!
                                                      .resultData!
                                                      .length
                                              : 6,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (index == 0) {
                                            } else {
                                              var productLocations = Get.find<
                                                      ProductCategoryController>()
                                                  .productLocationList;
                                              var categoryId =
                                                  categoryModelController
                                                      .categoryList[index - 1]
                                                      .id;

                                              Get.find<BannerController>()
                                                  .bannerData(
                                                'shoppeCategoriesListing',
                                              );

                                              categoryModelController
                                                  .fetchSubCategoryData(
                                                      categoryId);
                                              categoryModelController
                                                  .fetchProductsByCategory(
                                                      categoryId,
                                                      productLocations,
                                                      '1');
                                              Get.to(
                                                () =>
                                                    CategoryWiseProductListing(
                                                  subCategories:
                                                      categoryModelController
                                                          .subCategoryList,
                                                  data: categoryModelController
                                                      .categoryList[index - 1],
                                                  title: categoryModelController
                                                      .categoryList[index - 1]
                                                      .name,
                                                  idx: index - 1,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              children: [
                                                index == 0
                                                    ? Container(
                                                        height: 55,
                                                        decoration:
                                                            const BoxDecoration(
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
                                                            Images
                                                                .all_list_ico_new,
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
                                                                  .thumbUrl[0],
                                                        ),
                                                      ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 1,
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: 65,
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Text(
                                                      index == 0
                                                          ? 'View All'
                                                          : categoryModelController
                                                              .categoryList[
                                                                  index - 1]
                                                              .name,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                    ),
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    // controller: scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                    itemCount: widget.type == 'offered'
                                        ? categoryModelController.offered !=
                                                null
                                            ? categoryModelController.offered!
                                                        .resultData!.length >
                                                    12
                                                ? 12
                                                : categoryModelController
                                                    .offered!.resultData!.length
                                            : 12
                                        : categoryModelController.featured !=
                                                null
                                            ? categoryModelController.featured!
                                                        .resultData!.length >
                                                    6
                                                ? 6
                                                : categoryModelController
                                                    .featured!
                                                    .resultData!
                                                    .length
                                            : 6,
                                    itemBuilder: (context, index) {
                                      return
                                          // type == 'offered' &&
                                          //         categoryModelController.offered !=
                                          //             null
                                          // // ? ShoppeProductTile(
                                          // //     childCount: 0,
                                          // //     elementCrossCount: 0,
                                          // //     index: index,
                                          // //     data: categoryModelController.offered.,
                                          // //   )
                                          // ? FeaturedTile(
                                          //     type: type,
                                          //     index: index,
                                          //   )
                                          // : SizedBox();
                                          widget.type == 'offered' &&
                                                  categoryModelController
                                                          .offered !=
                                                      null
                                              ? FeaturedTile(
                                                  type: widget.type,
                                                  index: index,
                                                )
                                              : widget.type == 'feature' &&
                                                      categoryModelController
                                                              .featured !=
                                                          null
                                                  ? FeaturedTile(
                                                      type: widget.type,
                                                      index: index,
                                                    )
                                                  : const SingleProductShimmer();
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
        },
      ),
    );
  }
}
