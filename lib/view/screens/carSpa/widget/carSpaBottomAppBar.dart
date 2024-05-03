import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carspa_payment_chooser_widget.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carspa_proceed_payment_widget.dart';
import 'package:flutter/material.dart';

class CarSpaBottomAppBar extends StatelessWidget {
  CarSpaBottomAppBar({super.key, this.carSpaServiceResultData});
  final ServiceId? carSpaServiceResultData;
  final carSpaController = Get.find<CarSpaController>();
  final couponController = Get.find<CouponController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 9,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: CarSpaPaymentChooserWidget()),
          Expanded(
            child: GetBuilder<CouponController>(builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "total",
                    style: smallFontW600(Colors.black),
                  ),
                  Row(
                    children: [
                      couponController.isApplied.isTrue
                          ? Text(
                              "₹  ${couponController.finalAmount.toString()}",
                              style: largeFont(Colors.black),
                            )
                          : Text(
                              "₹  ${carSpaController.carSpaAddOnTotal.toString()}",
                              style: largeFont(Colors.black),
                            ),
                      Text(
                        " (inc. tax)",
                        style: smallFont(Colors.black),
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
          const SizedBox(
            width: 10,
          ),
          CarSpaProceedPaymentWidget()
        ],
      ),
    );
  }
}
