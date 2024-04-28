import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalAddressBottomUpView.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalBottomAppBarRow2 extends StatelessWidget {
  const MechanicalBottomAppBarRow2({super.key, this.mechanicalServiceResultData});
  final ServiceId? mechanicalServiceResultData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicalController>(builder: (mechanicalController) {
      return SizedBox(
        height: Get.find<CouponController>().isApplied.value
            ? 58
            : Get.find<MechanicalController>().offerApplicable.value
                ? 58
                : 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Total",
                      style: smallFont(Colors.black),
                    ),
                    Get.find<CouponController>().isApplied.value
                        ? Text(
                            " : ₹ ${mechanicalController.mechanicalAddOnTotal}",
                            style: smallFontW600(Colors.black),
                          )
                        : Get.find<MechanicalController>().offerApplicable.value
                            ? Text(
                                " : ₹ ${mechanicalController.mechanicalAddOnTotal}",
                                style: smallFontW600(Colors.black),
                              )
                            : const SizedBox()
                  ],
                ),
                Get.find<CouponController>().isApplied.value
                    ? Row(
                        children: [
                          Text(
                            "Discount : ",
                            style: smallFont(Colors.black),
                          ),
                          Text(
                            "₹ ${Get.find<CouponController>()
                                    .discount}",
                            style: smallFontW600(Colors.green),
                          )
                        ],
                      )
                    : Get.find<MechanicalController>().offerApplicable.value
                        ? Row(
                            children: [
                              Text(
                                "Discount : ",
                                style: smallFont(Colors.black),
                              ),
                              Text(
                                "₹ ${Get.find<MechanicalController>()
                                        .discount}",
                                style: smallFontW600(Colors.green),
                              )
                            ],
                          )
                        : const SizedBox(),
                Row(
                  children: [
                    Get.find<CouponController>().isApplied.value
                        ? Text(
                            "₹ ${Get.find<CouponController>()
                                    .finalAmount}",
                            style: largeFont(Colors.black),
                          )
                        : Get.find<MechanicalController>().offerApplicable.value
                            ? Text(
                                "₹ ${Get.find<MechanicalController>()
                                        .discountedAmount}",
                                style: largeFont(Colors.black),
                              )
                            : Text(
                                "₹ ${mechanicalController.mechanicalAddOnTotal}",
                                style: largeFont(Colors.black),
                              ),
                    Text(
                      "(inc. tax)",
                      style: smallFont(Colors.black),
                    ),
                  ],
                )
              ],
            ),
            GetBuilder<AddressControllerFile>(builder: (addressController) {
              return GetBuilder<ServiceCheckOutController>(
                  builder: (serviceCheckOutController) {
                return Bouncing(
                  onPress: () {
                    print(serviceCheckOutController.timeSlot.value);
                    if (serviceCheckOutController.timeSlot.value == "") {
                      showCustomSnackBar("Time Slot not Selected...!",
                          title: "Warning", isError: true);
                    } else {
                      if (addressController.addressList != null &&
                          addressController.addressList!.isNotEmpty) {
                        if (!Get.isBottomSheetOpen!) {
                          Get.bottomSheet(
                              mechanicalAddressBottomUpView(
                                  context: context,
                                  mechanicalServiceResultData:
                                      mechanicalServiceResultData,
                                  isForCheckout: true),
                              isScrollControlled: true);
                        }
                      } else {
                        addressController.getAddress().then((value) {
                          if (addressController.addressList!.isNotEmpty) {
                            addressController.getDefaultAddress().then((value) {
                              if (!Get.isBottomSheetOpen!) {
                                Get.bottomSheet(
                                    mechanicalAddressBottomUpView(
                                        context: context,
                                        mechanicalServiceResultData:
                                            mechanicalServiceResultData,
                                        isForCheckout: true),
                                    isScrollControlled: true);
                              }
                            });
                          } else {
                            if (!Get.isBottomSheetOpen!) {
                              Get.bottomSheet(
                                  mechanicalAddressBottomUpView(
                                      context: context,
                                      mechanicalServiceResultData:
                                          mechanicalServiceResultData,
                                      isForCheckout: true),
                                  isScrollControlled: true);
                            }
                          }
                        });
                      }
                    }
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      color: botAppBarColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text('Proceed to Payment',
                          style: mediumFont(Colors.black)),
                    ),
                  ),
                );
              });
            })
          ],
        ),
      );
    });
  }
}
