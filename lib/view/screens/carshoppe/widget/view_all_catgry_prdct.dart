import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';
import 'package:shoppe_customer/view/screens/carshoppe/categorywise_productlisting.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';

class ViewAllCategoryOfProduct extends StatefulWidget {
  const ViewAllCategoryOfProduct({super.key});

  @override
  State<ViewAllCategoryOfProduct> createState() =>
      _ViewAllCategoryOfProductState();
}

class _ViewAllCategoryOfProductState extends State<ViewAllCategoryOfProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: GetBuilder<ProductCategoryController>(
        builder: (categoryModelController) {
      return categoryModelController.fetchAllProductLoading.value
          ? const LoadingScreen()
          : categoryModelController.allProductListTemp.isEmpty
              ? const NoProductErrorScreen()
              : Column(children: [
                  Container(
                    height: 170,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]),
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
                                              "assets/image/logo.png")),
                                      Text(
                                        "Pexa",
                                        style: verySmallFont(Colors.black),
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
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                  ]),
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
                                          color: Colors.black
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
                                      ],
                                    ),
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
                              Get.find<ShoppeSearchController>().clearList();
                              Get.toNamed(RouteHelper.search);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
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
                                        Get.find<ShoppeSearchController>()
                                            .clearList();
                                        Get.toNamed(RouteHelper.search);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
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
                    child: Container(
                      child: GridView.builder(gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 0,
                      ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: categoryModelController.categoryList.length + 1,
                        itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              if (index == 0) {
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
                                categoryModelController.fetchProductsByCategory(
                                    categoryId, productLocations, '1');
                                Get.to(() => CategoryWiseProductListing(
                                  subCategories:
                                  categoryModelController.subCategoryList,
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
                                        image: categoryModelController
                                            .categoryList[index - 1]
                                            .thumbUrl[0]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 1,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 65,
                                      padding: const EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        index == 0
                                            ? 'View All'
                                            : categoryModelController
                                            .categoryList[index - 1].name,
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
                          ),
                        );
                      },),
                    ),
                  ),
                 /* Expanded(
                    child: Container(
                      child: ListView.builder(
                        // controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryModelController.categoryList.length + 1,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (index == 0) {
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
                                categoryModelController.fetchProductsByCategory(
                                    categoryId, productLocations, '1');
                                Get.to(() => CategoryWiseProductListing(
                                      subCategories:
                                          categoryModelController.subCategoryList,
                                      data: categoryModelController
                                          .categoryList[index - 1],
                                      title: categoryModelController
                                          .categoryList[index - 1].name,
                                      idx: index - 1,
                                    ));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  index == 0
                                      ? Container(
                                          height: 55,
                                          decoration: BoxDecoration(
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
                                              image: categoryModelController
                                                  .categoryList[index - 1]
                                                  .thumbUrl[0]),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 1,
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 65,
                                      padding: EdgeInsets.symmetric(vertical: 2),
                                      child: Text(
                                        index == 0
                                            ? 'View All'
                                            : categoryModelController
                                                .categoryList[index - 1].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
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
                      ),
                    ),
                  ),*/
                ]);
    }));
  }
}
