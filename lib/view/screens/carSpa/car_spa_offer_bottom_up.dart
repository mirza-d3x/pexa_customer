import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/offerTile.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

Widget carSpaOfferBottomUp(
    BuildContext context, ServiceId? carSpaServiceResultData) {
  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * .85,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: GetBuilder<CouponController>(builder: (couponController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/carSpa/offer_section.png',
                            height: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Apply Coupon Code',
                            style: largeFont(Colors.black),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: couponController.controller.value,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 8),
                                  border: InputBorder.none,
                                  hintText: 'Enter Coupon Code',
                                  hintStyle: smallFont(Colors.grey)),
                            )),
                            const SizedBox(
                              width: 5,
                            ),
                            Bouncing(
                              onPress: () {
                                if (couponController.controller.value.text
                                            .trim() !=
                                        '') {
                                  couponController
                                      .checkCoupon(Get.find<CarSpaController>()
                                          .carSpaAddOnTotal
                                          .value
                                          .toDouble())
                                      .then((value) => Get.back());
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                    color: Theme.of(context).primaryColor),
                                height: 28,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    'check',
                                    style: mediumFont(Colors.black),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CarSpaController>(builder: (carSpaController) {
                  return Expanded(
                    child: !carSpaController.loaderHelper.isLoading
                        ? carSpaController.carSpaOffers.isNotEmpty
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        controller: scrollController,
                                        scrollDirection: Axis.vertical,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: carSpaController
                                            .carSpaOffers.length,
                                        itemBuilder: (context, index) {
                                          return OfferTile(
                                            carSpaOfferModelData:
                                                carSpaController
                                                    .carSpaOffers[index],
                                            carSpaServiceResultData:
                                                carSpaServiceResultData,
                                            index: index,
                                          );
                                        })
                                  ],
                                ),
                              )
                            : Center(
                                child: Text(
                                'No Offers Found..!',
                                style: smallFontW600(Colors.grey),
                              ))
                        : LoadingAnimationWidget.twistingDots(
                            leftDotColor: const Color(0xFF4B4B4D),
                            rightDotColor: const Color(0xFFf7d417),
                            size: 50,
                          ),
                  );
                }),
                const SizedBox(
                  height: 5,
                ),
                Bouncing(
                  onPress: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: mediumFont(Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        );
      });
}

Future applyOffer() async {
  if (Get.find<CarSpaController>().applyOfferStatus.value) {
    Get.find<CouponController>().clearValue();
    Get.find<CarSpaController>().clearOffer();
    Get.find<CarSpaController>().applyOfferToService(
        Get.find<CarSpaController>().applyOfferId.value,
        Get.find<CarSpaController>().carSpaAddOnTotal.value,
        Get.find<CarSpaController>().applyOfferServiceId.value);
  }
}
