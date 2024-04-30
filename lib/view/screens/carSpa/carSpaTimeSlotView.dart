import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaBottomAppBar.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaShowDate.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaTimeSlotGrid.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaTimeSlotView extends StatelessWidget {
  CarSpaTimeSlotView({super.key, Key? keys, this.carSpaServiceResultData});
  // final carSpaTimeSlotController = Get.find<CarSpaTimeSlotController>();
  // final carSpaController = Get.find<CarSpaController>();
  final ServiceId? carSpaServiceResultData;

  final checkOutController = Get.find<ServiceCheckOutController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(
        title: "Order Details",
        // backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: GetBuilder<CarSpaTimeSlotController>(
          builder: (carSpaTimeSlotController) {
        return GetBuilder<CarSpaController>(builder: (carSpaController) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Date',
                    style: mediumFont(Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Bouncing(
                    onPress: () {
                      carSpaTimeSlotController.changeDate(
                          context, carSpaServiceResultData);
                    },
                    child: CarSpaShowDate(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select Time Slot',
                    style: mediumFont(Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  carSpaTimeSlotController.isLoad.value
                      ? SizedBox(
                          height: 200,
                          child: Center(
                            child: SizedBox(
                                height: 35,
                                width: 35,
                                child: Image.asset(Images.spinner,
                                    fit: BoxFit.fill)),
                          ),
                        )
                      : carSpaController.carSpaTimeSlot.isEmpty &&
                              carSpaTimeSlotController.dateLoad.value
                          ? SizedBox(
                              height: 200,
                              child: Center(
                                child: Text(
                                  "Time Slots are not available..!",
                                  style: mediumFont(Colors.red),
                                ),
                              ),
                            )
                          : const TimeSlotGrid(),
                  const SizedBox(
                    height: 20,
                  ),
                  /*SizedBox(
                      width: Get.width,
                      child: Center(
                        child: ApplyOfferButton(
                          carSpaServiceResultData: carSpaServiceResultData,
                        ),
                      ),
                    ),*/
                  CouponApplyWidget(
                    amount: double.parse(
                        carSpaController.carSpaAddOnTotal.value.toString()),
                  ),
                  GetBuilder<CouponController>(builder: (couponController) {
                    return couponController.isApplied.value
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    (couponController.couponName.value),
                                    style: mediumFont(Colors.black),
                                  ),
                                  Text(
                                    ' coupon is applied..!',
                                    style: smallFontW600(Colors.green),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Bouncing(
                                      onPress: () {
                                        couponController.clearValue();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red[900],
                                        size: 20,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                  'You have saved ${couponController.discount} INR',
                                  style: smallFontW600(Colors.black))
                            ],
                          )
                        : const SizedBox();
                  }),
                  GetBuilder<CouponController>(builder: (couponController) {
                    return couponController.showDetails.value
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'this Coupon will be applicable only for the minimum purchase '
                                'amount of ${couponController.minAmount.value}',
                                style: verySmallFontW600(Colors.red),
                                textAlign: TextAlign.center,
                              )
                            ],
                          )
                        : const SizedBox();
                  }),
                  carSpaController.offerApplicable.value
                      ? SizedBox(
                          width: Get.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Offer Applied',
                                      style: mediumFont(Colors.green)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Bouncing(
                                      onPress: () {
                                        carSpaController.clearOffer();
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red[900],
                                        size: 20,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'You have saved ${carSpaController.discount} INR',
                                style: mediumFont(Colors.black),
                              )
                            ],
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
      }),
      bottomNavigationBar: BottomAppBar(
        height: 120,
        elevation: 0,
        color: Theme.of(context).colorScheme.background,
        child: CarSpaBottomAppBar(),
      ),
    );
  }
}

class CouponApplyWidget extends StatelessWidget {
  const CouponApplyWidget({super.key, required this.amount});
  final double amount;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (couponController) {
        return Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Row(
                children: [
                  Icon(Icons.percent_rounded, color: Colors.black),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Apply Coupon Code'),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black),
                ],
              ),
              const Divider(
                color: Colors.black,
              ),
              Container(
                height: 50,
                width: Get.width * 0.86,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38, width: 1),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: couponController.controller.value,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Coupon Code or Gift card no.',
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (couponController.controller.value.text
                            .trim()
                            .isNotEmpty) {
                          couponController.checkCoupon(amount);
                        }
                      },
                      icon: const Icon(Icons.send, color: Colors.black),
                    ),
                  ),
                ),
              ),
              couponController.showDetails.value
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'this Coupon will be applicable only for the minimum purchase '
                          'amount of ${couponController.minAmount.value}',
                          style: verySmallFontW600(Colors.red),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : const SizedBox(),
              couponController.isApplied.value
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              (couponController.couponName.value),
                              style: mediumFont(Colors.black),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  ' Coupon is applied successfully!',
                                  style: smallFontW600(Colors.green),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    couponController.clearValue();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red[900],
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }
}
