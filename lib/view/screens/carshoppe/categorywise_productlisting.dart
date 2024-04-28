import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/carshoppe/widget/shoppe_product_tile.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_product_error_screen.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class CategoryWiseProductListing extends StatelessWidget {

  CategoryWiseProductListing(
      {super.key,
      required this.data,
      required this.title,
      required this.subCategories,
      required this.idx});
  final data;
  final title;
  final subCategories;
  final idx;
  num selectedIndex = 0;

  static int pageNumber = 1;
  static final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  final categoryModelController = Get.find<ProductCategoryController>();
  var bannerController = Get.find<BannerController>();
  void _onLoading(bool isReload) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (isReload) {
      pageNumber = 0;
    }
    int totalPage =
        Get.find<ProductCategoryController>().categoryListPdtTotalPage!;
    if (pageNumber < totalPage) {
      pageNumber++;
      print('***0000**');
      print(pageNumber);
      print('***0000**');
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
    await Get.find<ProductCategoryController>().fetchProductsByCategory(
        data.id,
        Get.find<ProductCategoryController>().productLocationList,
        page.toString());
  }

  // void _scrollListener() {
  //   print(scrollController.position.extentAfter);
  //   if (scrollController.position.pixels ==
  //           scrollController.position.maxScrollExtent &&
  //       !GetPlatform.isMobile) {
  //     _onLoading();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // scrollController = ScrollController()..addListener(_scrollListener);
    return Scaffold(
      appBar: (GetPlatform.isMobile
          ? CustomAppBar(title: title, showCart: true)
          : CustomAppBarWeb(
              title: title,
              showCart: true,
            )) as PreferredSizeWidget?,
      body: GetBuilder<ProductCategoryController>(
          builder: (categoryModelController) {
        return categoryModelController.loaderHelper.isLoading
            ? const LoadingScreen()
            : Column(
                children: [
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Get.find<ShoppeSearchController>().clearList();
                      Get.toNamed(RouteHelper.search);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: Container(
                        height: 40,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                  const SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 110,
                    color: Colors.white,
                    child: Row(children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: subCategories.length + 1,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        selectedIndex = 0;
                                        categoryModelController
                                            .fetchProductsByCategory(
                                                categoryModelController
                                                    .categoryList[idx].id,
                                                categoryModelController
                                                    .productLocationList,
                                                '1');
                                      } else {
                                        selectedIndex = index;
                                        categoryModelController
                                            .fetchProductListData(
                                                subCategories[index - 1].id,
                                                categoryModelController
                                                    .productLocationList,
                                                '1');
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5),
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
                                                      Images.all_list_ico,
                                                      height: 35,
                                                      width: 35,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 55,
                                                  width: 55,
                                                  child: CustomImage(
                                                      fit: BoxFit.contain,
                                                      image: subCategories[
                                                              index - 1]
                                                          .thumbUrl[0]),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 2),
                                            child: Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  color: selectedIndex == index
                                                      ? primaryColor1
                                                      : null,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(5))),
                                              width: 60,
                                              child: Text(
                                                index == 0
                                                    ? 'ALL'
                                                    : subCategories[index - 1]
                                                        .name,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              );
                            }),
                      )
                    ]),
                  ),
                  categoryModelController.productListTemp.isEmpty
                      ? const Expanded(child: NoProductErrorScreen())
                      : Expanded(
                          child: SmartRefresher(
                            controller: _refreshController,
                            scrollController: scrollController,
                            enablePullDown: true,
                            enablePullUp: true,
                            onLoading: () => _onLoading(false),
                            onRefresh: () => _onLoading(true),
                            child: SingleChildScrollView(
                              // physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  bannerController
                                              .shoppeCategoriesListing.isNotEmpty
                                      ? CarouselSlider.builder(
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            viewportFraction: 1.0,
                                            enlargeCenterPage: true,
                                            height: ResponsiveHelper.isDesktop(
                                                        context) ||
                                                    ResponsiveHelper.isTab(
                                                        context)
                                                ? 240
                                                : 100,
                                            disableCenter: true,
                                            autoPlayInterval:
                                                const Duration(seconds: 6),
                                            onPageChanged: (index, reason) {},
                                          ),
                                          itemCount: bannerController
                                                      .shoppeCategoriesListing.isNotEmpty
                                              ? bannerController
                                                  .shoppeCategoriesListing
                                                  .length
                                              : 1,
                                          itemBuilder: (context, index, _) {
                                            return InkWell(
                                                onTap: () {},
                                                child: Container(
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
                                                                  .shoppeCategoriesListing.isNotEmpty
                                                          ? bannerController
                                                                  .shoppeCategoriesListing[
                                                              index]
                                                          : "",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ));
                                          },
                                        )
                                      : const SizedBox(),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.all(10),
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
                                        .productListTemp.length,
                                    itemBuilder: (context, index) {
                                      return ShoppeProductTile(
                                        childCount: 0,
                                        elementCrossCount: 0,
                                        index: index,
                                        data: categoryModelController
                                            .productListTemp,
                                      );
                                    },
                                  )
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
}
