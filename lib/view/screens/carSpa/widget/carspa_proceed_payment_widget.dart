import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaAddressBottomUpView.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaProceedPaymentWidget extends StatelessWidget {
  CarSpaProceedPaymentWidget({super.key, this.carSpaServiceResultData});
  final ServiceId? carSpaServiceResultData;
  final carSpaController = Get.find<CarSpaController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.find<CouponController>().isApplied.value
          ? 64
          : Get.find<CarSpaController>().offerApplicable.value
              ? 68
              : 45,
      child: GetBuilder<AddressControllerFile>(
        builder: (addressController) {
          return Bouncing(
            onPress: () {
              if (Get.find<ServiceCheckOutController>().timeSlot.value == "") {
                showCustomSnackBar('Time Slot not Selected...!',
                    title: 'Warning', isError: true);
              } else {
                addressController.getAddress().then(
                  (value) {
                    if (addressController.addressList!.isNotEmpty) {
                      addressController.getDefaultAddress().then(
                        (value) {
                          if (!Get.isBottomSheetOpen!) {
                            Get.bottomSheet(
                              carSpaAddressBottomUpView(
                                  context: context,
                                  carSpaServiceResultData:
                                      carSpaServiceResultData,
                                  isForCheckout: true),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      if (!Get.isBottomSheetOpen!) {
                        Get.bottomSheet(
                          carSpaAddressBottomUpView(
                            context: context,
                            carSpaServiceResultData: carSpaServiceResultData,
                            isForCheckout: true,
                          ),
                        );
                      }
                    }
                  },
                );
              }
            },
            child: Container(
              height: 40,
              width: 100,
              // width: 200,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                child: Text(
                  'Confirm',
                  style: mediumFont(Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
