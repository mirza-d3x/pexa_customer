import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/single_product_shimmer.dart';
import 'package:shoppe_customer/view/screens/home/widgets/grid_featured.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    final categoryModelController = Get.find<ProductCategoryController>();
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 170,
      width: double.maxFinite,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: type == 'offered'
            ? categoryModelController.offered != null
            ? categoryModelController.offered!.resultData!.length > 12
            ? 12
            : categoryModelController.offered!.resultData!.length
            : 12
            : categoryModelController.featured != null
            ? categoryModelController.featured!.resultData!.length > 6
            ? 6
            : categoryModelController.featured!.resultData!.length
            : 6,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(4),
              child:  Container(
                height:130,
                width: 100,
                margin: const EdgeInsets.all(5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: type == 'offered' &&
                    categoryModelController.offered != null
                    ? FeaturedTile(
                  type: type,
                  index: index,
                )
                    : type == 'feature' &&
                    categoryModelController.featured != null
                    ? FeaturedTile(
                  type: type,
                  index: index,
                )
                    : const SingleProductShimmer(),
              )
          );
        },),

    );

    /*CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,

        slivers: [
          SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: ResponsiveHelper.isDesktop(context)
                  ? Get.width / 6
                  : Get.width / 3,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.7,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: height * 0.1,
                  margin: EdgeInsets.all(5),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,

                  ),
                  child: type == 'offered' &&
                          categoryModelController.offered != null
                      ? FeaturedTile(
                          type: type,
                          index: index,
                        )
                      : type == 'feature' &&
                              categoryModelController.featured != null
                          ? FeaturedTile(
                              type: type,
                              index: index,
                            )
                          : SingleProductShimmer(),
                );
              },
              childCount: type == 'offered'
                  ? categoryModelController.offered != null
                      ? categoryModelController.offered!.resultData!.length > 12
                          ? 12
                          : categoryModelController.offered!.resultData!.length
                      : 12
                  : categoryModelController.featured != null
                      ? categoryModelController.featured!.resultData!.length > 6
                          ? 6
                          : categoryModelController.featured!.resultData!.length
                      : 6,
            ),
          ),
        ]);*/

  }
}
