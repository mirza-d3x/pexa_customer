import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/offer_model.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class OfferTile extends StatelessWidget {
  OfferTile(
      {super.key,
      this.carSpaOfferModelData,
      this.carSpaServiceResultData,
      this.index});
  final OfferModel? carSpaOfferModelData;
  final ServiceId? carSpaServiceResultData;
  final int? index;

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  final color = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.lime,
    Colors.indigo,
    Colors.yellow,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.only(bottom: 10),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 10,
                decoration:
                    BoxDecoration(color: color[Random().nextInt(color.length)]),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 50,
                width: 50,
                padding: const EdgeInsets.all(4),
                child: Image.asset(
                  Images.order_active,
                  color: botAppBarColor,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              carSpaOfferModelData!.title!,
                              style: largeFont(Colors.blue),
                            ),
                            // child: Text(
                            //   carSpaOfferModelData.title.toUpperCase(),
                            //   maxLines: 1,
                            //   overflow: TextOverflow.ellipsis,
                            //   style: largeFont(Colors.black),
                            // ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Bouncing(
                            onPress: () {
                              if (carSpaOfferModelData!.status == 'Active') {
                                Get.find<CouponController>().clearValue();
                                Get.find<CarSpaController>().clearOffer();
                                Get.find<CarSpaController>()
                                    .applyOfferToService(
                                        carSpaServiceResultData!.id,
                                        Get.find<CarSpaController>()
                                            .carSpaAddOnTotal
                                            .value,
                                        carSpaOfferModelData!.id)
                                    .then(
                                  (value) {
                                    if (value != null && value['applicable']) {
                                      goBack(context);
                                    } else {
                                      showCustomSnackBar(
                                          "Offer not applicable.",
                                          isError: true);
                                    }
                                  },
                                );
                              } else {
                                print('not active');
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
                                child: Text('APPLY',
                                    style: mediumFont(Colors.black)),
                              ),
                            ),
                          )
                        ],
                      ),
                      // Text(
                      //   'Get  ₹${carSpaOfferModelData.offerAmount.toString()} off',
                      //   style: mediumFont(Colors.blue),
                      // ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        carSpaOfferModelData!.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: smallFontW600(Colors.black),
                      ),
                      // Divider(
                      //   color: Colors.grey,
                      //   thickness: 1,
                      // ),
                      // Text(carSpaOfferModelData.description,
                      //     style: smallFontW600(Colors.grey)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
