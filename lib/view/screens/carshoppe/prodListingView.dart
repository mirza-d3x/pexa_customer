import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_grid.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductListView extends StatelessWidget {
  ProductListView({super.key, this.title, this.subCatId, this.subCategories});
  final String? title;
  final String? subCatId;
  int pageNumber = 1;
  final subCategories;

  @override
  Widget build(BuildContext context) {
    Get.find<ProductDetailsController>().oneTouch.value = true;
    print(subCategories);
    final categoryModelController = Get.find<ProductCategoryController>();
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: const Color(0xFFF0F4F7),
            appBar: AppBar(
              title: Text('Car Shoppe',
                  style: defaultFont(
                    color: Colors.black,
                    size: 20,
                    weight: FontWeight.w400,
                  )),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 15, color: Colors.black),
                color: Theme.of(context).textTheme.bodyLarge!.color,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 1,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: Obx(
              () => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: (categoryModelController.productListTemp.isEmpty)
                      ? Center(
                          child: (categoryModelController.prodAvailable.value)
                              ? const Text("No Products Listed")
                              : LoadingAnimationWidget.twistingDots(
                                  leftDotColor: const Color(0xFF4B4B4D),
                                  rightDotColor: const Color(0xFFf7d417),
                                  size: 50,
                                ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: 50,
                              //   decoration: BoxDecoration(
                              //     color: Theme.of(context).secondaryHeaderColor,
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black.withOpacity(0.2),
                              //         blurRadius: 4,
                              //         spreadRadius: 5,
                              //         offset: Offset(
                              //           0,
                              //           3,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              //   child: Padding(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 20),
                              //     child: Row(children: [
                              //       Text(
                              //         title,
                              //         style: defaultFont(
                              //           color: Colors.black,
                              //           size: 20,
                              //           weight: FontWeight.w600,
                              //         ),
                              //       ),
                              //       Spacer(),
                              //       IconButton(
                              //         icon: Icon(
                              //           Icons.menu,
                              //           color: Colors.black.withOpacity(0.5),
                              //         ),
                              //         onPressed: () {
                              // common.menuOpen.value =
                              //     !common.menuOpen.value;
                              // print(common.menuOpen.value);
                              //         },
                              //       ),
                              //     ]),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
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
                                                  index == 0
                                                      ? Get.back()
                                                      : categoryModelController
                                                          .fetchProductListData(
                                                              subCategories[
                                                                      index - 1]
                                                                  .id,
                                                              Get.find<
                                                                      ProductCategoryController>()
                                                                  .productLocationList,
                                                              '1');
                                                },
                                                child: Column(
                                                  children: [
                                                    index == 0
                                                        ? Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              //shape: BoxShape.circle,
                                                              // boxShadow: [
                                                              //   BoxShadow(
                                                              //       blurRadius: 2,
                                                              //       color: Colors
                                                              //           .black26,
                                                              //       spreadRadius: 1)
                                                              // ],
                                                            ),
                                                            child: CustomImage(
                                                              image: Images
                                                                  .all_list_ico,
                                                              height: 60,
                                                              width: 60,
                                                            ),
                                                            // CircleAvatar(
                                                            //   radius: 30,
                                                            //   backgroundColor: Theme
                                                            //           .of(context)
                                                            //       .secondaryHeaderColor,
                                                            //   backgroundImage:
                                                            //       NetworkImage('https://res.cloudinary.com/carclenx-pvt-ltd/image/upload/v1651744533/Icons/Home/P_All_80_emxsy4.png'),
                                                            // ),
                                                          )
                                                        : Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    blurRadius:
                                                                        2,
                                                                    color: Colors
                                                                        .black26,
                                                                    spreadRadius:
                                                                        1)
                                                              ],
                                                            ),
                                                            child: CircleAvatar(
                                                              radius: 30,
                                                              backgroundColor:
                                                                  Theme.of(
                                                                          context)
                                                                      .primaryColor,
                                                              backgroundImage: NetworkImage(
                                                                  subCategories[
                                                                          index -
                                                                              1]
                                                                      .imageUrl[0]),
                                                            ),
                                                          ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 80,
                                                      child: Text(
                                                          index == 0
                                                              ? 'ALL'
                                                              : subCategories[
                                                                      index - 1]
                                                                  .name,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: defaultFont(
                                                            color: Colors.black,
                                                            size: 10,
                                                            weight:
                                                                FontWeight.bold,
                                                          )),
                                                    ),
                                                  ],
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
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                height: MediaQuery.of(context).size.height,
                                child: RefreshIndicator(
                                  onRefresh: () async => _onLoading,
                                  child: gridView(
                                      categoryModelController.productListTemp,
                                      context),
                                ),
                              ),
                            ],
                          ),
                        )),
            ))
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }

  SingleChildScrollView gridView(products, ctx) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(height: 100, width: Get.width, color: Colors.blueGrey),
          SizedBox(
            height: Get.height * 0.65,
            child: CustomGridView(
              padding: 10,
              childCount: products.length,
              elementCrossCount: 2,
              data: products,
              //ctx: ctx,
            ),
          ),
        ],
      ),
    );
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageNumber++;
    print(pageNumber);
    if (Get.find<ProductCategoryController>().productList.length == 20) {
      changePage(pageNumber);
    }
  }

  changePage(int page) async {
    Get.find<ProductCategoryController>().fetchProductListData(
        subCatId,
        Get.find<ProductCategoryController>().productLocationList,
        page.toString());
  }
}
