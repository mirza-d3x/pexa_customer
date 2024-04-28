import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/home/widgets/grid_featured.dart';

class ViewAll extends StatelessWidget {
  const ViewAll(
      {super.key, required this.title, required this.data, required this.type});
  final title;
  final data;
  final type;

  @override
  Widget build(BuildContext context) {
    final categoryModelController = Get.find<ProductCategoryController>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'View All'),
      body: SingleChildScrollView(
        // physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 150,
              width: Get.width,
              color: Colors.blueGrey,
              child: GetBuilder<BannerController>(builder: (bannerControler) {
                return bannerControler.banner!.isEmpty
                    ? Container(
                        height: 260,
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
                          height: 260,
                          disableCenter: true,
                          autoPlayInterval: const Duration(seconds: 6),
                          onPageChanged: (index, reason) {},
                        ),
                        itemCount: bannerControler.banner!.length,
                        itemBuilder: (context, index, _) {
                          return InkWell(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors
                                            .grey[Get.isDarkMode ? 800 : 200]!,
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: ClipRRect(
                                  child: CustomImage(
                                    image: bannerControler.banner![index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ));
                        },
                      );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // height: Get.height - 300,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                            height: MediaQuery.of(context).size.height * 0.1,
                            clipBehavior: Clip.hardEdge,
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: FeaturedTile(
                              type: type,
                              index: index,
                            ),
                          );
                        },
                        childCount: type == 'offered'
                            ? categoryModelController.offered!.resultData!.length
                            : categoryModelController
                                .featured!.resultData!.length,
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
