import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanical_offer_tile.dart';

import 'package:shoppe_customer/view/widgets/bouncing.dart';

Widget mechanicalOfferBottomUp(
    BuildContext context, ServiceId? mechanicalServiceResultData) {
  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return GetBuilder<MechanicalController>(
            builder: (mechanicalController) {
          return GetBuilder<CouponController>(builder: (couponController) {
            return Container(
              height: MediaQuery.of(context).size.height * .85,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
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
                          height: 10,
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
                                        .checkCoupon(mechanicalController
                                            .mechanicalAddOnTotal.value
                                            .toDouble())
                                        .then((value) {
                                      print(value);
                                      if (value['applicable'] == false) {
                                        showCustomSnackBar(
                                            "Offer not applicable",
                                            title: "Offer",
                                            isError: true);
                                      } else {
                                        Get.back();
                                      }
                                    });
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
                  Expanded(
                    child: mechanicalController.mechanicalOffer.isNotEmpty
                        ? SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                ListView.builder(
                                    controller: scrollController,
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mechanicalController
                                        .mechanicalOffer.length,
                                    itemBuilder: (context, index) {
                                      return MechanicalOfferTileNew(
                                        mechanicalOfferResultData:
                                            mechanicalController
                                                .mechanicalOffer[index],
                                        mechanicalServiceResultData:
                                            mechanicalServiceResultData,
                                        index: index,
                                      );
                                    })
                              ],
                            ),
                          )
                        : Center(
                            child: mechanicalController.offerEmpty.value
                                ? Text(
                                    'No Offers Found..!',
                                    style: smallFontW600(Colors.grey),
                                  )
                                : LoadingAnimationWidget.twistingDots(
                                    leftDotColor: const Color(0xFF4B4B4D),
                                    rightDotColor: const Color(0xFFf7d417),
                                    size: 50,
                                  )),
                  ),
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
              ),
            );
          });
        });
      });
}
