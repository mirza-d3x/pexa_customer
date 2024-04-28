import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});
  // var bannerController = Get.find<BannerController>();
  @override
  Widget build(BuildContext context) {
    // bannerController.bannerData('Newbanners');

    return GetBuilder<BannerController>(builder: (bannerController) {
      return bannerController.banner != null &&
              bannerController.banner!.isNotEmpty
          ? SizedBox(
              width: Get.width,
              height: ResponsiveHelper.isDesktop(context) ? 240 : 140,
              child:
                  // Obx(() => bannerController.banner.isEmpty
                  //     ? Container(
                  //         height: 260,
                  //         width: Get.width,
                  //         color: Colors.white,
                  //         child: Image.asset(
                  //           Images.loading,
                  //           fit: BoxFit.contain,
                  //         ))
                  //     :
                  CarouselSlider.builder(
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
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
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
