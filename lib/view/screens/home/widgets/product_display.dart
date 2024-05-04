import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/view/base/title_widget.dart';
import 'package:shoppe_customer/view/screens/home/widgets/clients_testimonial.dart';
import 'package:shoppe_customer/view/screens/home/widgets/explore.dart';
import 'package:shoppe_customer/view/screens/home/widgets/featured_products.dart';
import 'package:shoppe_customer/view/screens/home/widgets/pexa_seriveRound.dart';
import 'package:shoppe_customer/view/screens/home/widgets/pexa_service.dart';
import 'package:shoppe_customer/view/screens/home/widgets/video_play.dart';

class HomeProducts extends StatelessWidget {
  const HomeProducts({super.key});

  // var categoryModelController = Get.find<ProductCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:
          // categoryModelController.exploreSection();
          GetBuilder<ProductCategoryController>(
        builder: (categoryModelController) {
          return Column(
            children: [
              const PexaService(),
              const SizedBox(
                height: 10,
              ),
              const PexaServiceRound(
                type: 'carSpa',
              ),
              const SizedBox(
                height: 10,
              ),
              offeredProductWidget(categoryModelController),
              const SizedBox(
                height: 10,
              ),
              featuredProductWidget(categoryModelController),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_SMALL,
              ),
              /* exploreListWidget(),*/
              const SizedBox(
                height: 10,
              ),
              const ClientsTestimonial(),
              const SizedBox(
                height: 20,
              ),
              const VideoPlaying(),
              const SizedBox(
                height: 20,
              ),
            ],
          );
        },
      ),
    );
  }

  Column exploreListWidget() {
    return Column(
      children: [
        const TitleData(title: 'Explore'),
        const SizedBox(
          height: 10,
        ),
        Explore(),
      ],
    );
  }

  Column offeredProductWidget(
      ProductCategoryController categoryModelController) {
    return Column(
      children: [
        categoryModelController.offered != null &&
                categoryModelController.offered!.resultData!.length > 6
            ? TitleData(
                title: 'Offered Products',
                onTap: () {
                  Get.toNamed(
                    RouteHelper.viewAllProducts,
                    arguments: [
                      {
                        'title': 'Offered Products',
                        'data': categoryModelController.offered,
                        'type': 'offered'
                      }
                    ],
                  );
                },
              )
            : const TitleData(title: 'Offered Products'),
        const SizedBox(
          height: 10,
        ),
        FeaturedProducts(type: 'offered'),
      ],
    );
  }

  Column featuredProductWidget(
      ProductCategoryController categoryModelController) {
    return Column(
      children: [
        categoryModelController.featured != null &&
                categoryModelController.featured!.resultData!.length > 6
            ? TitleData(
                title: 'Featured Products',
                onTap: () {
                  Get.toNamed(
                    RouteHelper.viewAllProducts,
                    arguments: [
                      {
                        'title': 'Featured Products',
                        'data': categoryModelController.featured,
                        'type': 'feature'
                      }
                    ],
                  );
                },
              )
            : const TitleData(title: 'Featured Products'),
        const SizedBox(
          height: 10,
        ),
        FeaturedProducts(type: 'feature'),
      ],
    );
  }
}
