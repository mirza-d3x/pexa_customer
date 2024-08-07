import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaBottumUpView.dart';
import 'package:shoppe_customer/view/screens/carshoppe/categorywise_productlisting.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});
  // var bannerController = Get.find<BannerController>();

  void getCategoryData() async {
    await Get.find<ProductCategoryController>().fetchCategoryData();
    await Get.find<BannerController>().bannerData(
      'shoppeCategoriesListing',
    );
    await Get.find<CarSpaController>()
        .getCarSpaServiceWithCatId("62163f5f0e80605ad0545a1b");
  }

  @override
  Widget build(BuildContext context) {
    // bannerController.bannerData('Newbanners');
    getCategoryData();
    return GetBuilder<BannerController>(builder: (bannerController) {
      return bannerController.banner != null &&
              bannerController.banner!.isNotEmpty
          ? SizedBox(
              width: Get.width,
              height: ResponsiveHelper.isDesktop(context) ? 240 : 140,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enlargeCenterPage: true,
                  height: 260,
                  disableCenter: true,
                  autoPlayInterval: const Duration(seconds: 6),
                  onPageChanged: (index, reason) {},
                ),
                itemCount: bannerController.banner!.length,
                itemBuilder: (context, index, _) {
                  return InkWell(
                      onTap: () async {
                        final carSpaController = Get.find<CarSpaController>();
                        final categoryModelController =
                            Get.find<ProductCategoryController>();
                        // getCategoryData();
                        log(bannerController.banner![index]);
                        log(index.toString());

                        if (index == 0) {
                          var productLocations =
                              Get.find<ProductCategoryController>()
                                  .productLocationList;
                          var categoryId =
                              categoryModelController.categoryList[2].id;

                          categoryModelController
                              .fetchSubCategoryData(categoryId);
                          categoryModelController.fetchProductsByCategory(
                              categoryId, productLocations, '1');
                          Get.to(() => CategoryWiseProductListing(
                                subCategories:
                                    categoryModelController.subCategoryList,
                                data: categoryModelController.categoryList[0],
                                title: categoryModelController
                                    .categoryList[2].name,
                                idx: 0,
                              ));
                        } else if (index == 2) {
                          carSpaController.getCarSpaServiceWithCatId(
                              carSpaController.carSpaCategory[0].id);
                          carSpaController.setRadioStatusList(14);
                          Get.toNamed(RouteHelper.carSpaService, arguments: {
                            'title': carSpaController.carSpaCategory[0].name
                          });
                          await Future.delayed(const Duration(seconds: 1));
                          Get.bottomSheet(
                              carSpaBottomUpView(
                                  context,
                                  0,
                                  carSpaController.carSpaServiceProperty[2],
                                  carSpaController.carSpaService[2]),
                              isScrollControlled: true);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Colors.grey[Get.isDarkMode ? 800 : 200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: ClipRRect(
                            child: CustomImage(
                              image: bannerController.banner![index],
                              height: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ));
                },
              ))
          : SizedBox(
              width: Get.width,
              height: 150,
              child: CustomImage(
                image: "",
                fit: BoxFit.fill,
                width: Get.width,
                height: 150,
              ),
            );
    });
  }
}
