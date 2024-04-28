import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';

class CategoryScreen extends StatelessWidget {
  final List categoryDetails = [
    'assets/image/menu/carspa.png',
    'assets/image/menu/quick.png',
    'assets/image/menu/mechanical.png',
    'assets/image/menu/shoppe.png',
  ];

  CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find<CategoryController>().getCategoryList(false);

    return Scaffold(
      appBar: CustomAppBar(title: 'categories'.tr),
      body: Scrollbar(
          child: SingleChildScrollView(
              child: Center(
                  child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder(builder: (dynamic catController) {
          return catController.categoryList != null
              ? catController.categoryList.length > 0
                  ? GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.isDesktop(context)
                            ? 6
                            : ResponsiveHelper.isTab(context)
                                ? 4
                                : 3,
                        childAspectRatio: (1 / 1),
                        mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                        crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      itemCount: categoryDetails.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () =>
                              Get.toNamed(RouteHelper.getCategoryProductRoute(
                            catController.categoryList[index].id,
                            catController.categoryList[index].name,
                          )),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors
                                        .grey[Get.isDarkMode ? 800 : 200]!,
                                    blurRadius: 5,
                                    spreadRadius: 1)
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    child: CustomImage(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      image: categoryDetails[index],
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  Text(
                                    catController.categoryList[index].name,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeSmall),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("No data"),
                    )
              : Center(
                  child: LoadingAnimationWidget.twistingDots(
                    leftDotColor: const Color(0xFF4B4B4D),
                    rightDotColor: const Color(0xFFf7d417),
                    size: 50,
                  ),
                );
        }),
      )))),
    );
  }
}
