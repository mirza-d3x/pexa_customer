import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/explore_data.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/single_product_shimmer.dart';

class Explore extends StatelessWidget {
  Explore({super.key});
  static List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.topLeft
  ];

  final mechanicalController = Get.find<MechanicalController>();
  final carSpaController = Get.find<CarSpaController>();
  final quickHelpController = Get.find<QuickHelpController>();

  @override
  Widget build(BuildContext context) {
    // controller.exploreSection();
    //controller.explore.shuffle();
    return CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          GetBuilder<ProductCategoryController>(
              builder: (productCategoryController) {
            return SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    GetPlatform.isWeb ? Get.width / 6 : Get.width / 3,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.4,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return productCategoryController.explore.isNotEmpty
                    ? exploreTile(productCategoryController.explore, index)
                    : const SingleProductShimmer();
              },
                      childCount: productCategoryController.explore.isNotEmpty
                          ? productCategoryController.explore.length > 6
                              ? 6
                              : productCategoryController.explore.length
                          : 3),
            );
          }),
        ]);
  }

  InkWell exploreTile(List<ExploreData> explore, int index) {
    return InkWell(
      onTap: () {
        if (explore[index].assetType == 'Carspa') {
          if (explore[index].name != 'Bike' &&
              explore[index].name != 'House Keeping') {
            carSpaController
                .getCarSpaServiceWithCatId(explore[index].categoryId!);
            Get.toNamed(RouteHelper.carSpaService,
                arguments: {'title': explore[index].name});
          } else {
            carSpaController
                .getCarSpaServiceWithoutCatId(explore[index].categoryId);
            Get.toNamed(RouteHelper.carSpaService,
                arguments: {'title': explore[index].name});
          }
        } else if (explore[index].assetType == 'Mechanical') {
          mechanicalController
              .getMechanicalServiceWithCatId(explore[index].categoryId!);
          Get.toNamed(RouteHelper.mechanicalService,
              arguments: {'title': explore[index].name});
        } else {
          quickHelpController
              .getQuickHelpServiceWithCatId(explore[index].categoryId!);
          Get.toNamed(RouteHelper.quickHelpService,
              arguments: {'title': explore[index].name});
        }
      },
      child: Container(
        height: Get.height * 0.1,
        margin: EdgeInsets.all(GetPlatform.isWeb ? 5 : 0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.3),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: Offset(0, 1), // changes position of shadow
          //   ),
          // ],
        ),
        child: CustomImage(
          image:
              explore[index].thumbUrl != null ? explore[index].thumbUrl![0] : '',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
