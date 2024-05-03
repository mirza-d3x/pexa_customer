import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/couponModel.dart';
import 'package:shoppe_customer/data/repository/coupenCheckApi.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';

class CouponController extends GetxController implements GetxService {
  var isApplied = false.obs;
  var showDetails = false.obs;
  var couponName = ''.obs;
  var discount = 0.0.obs;
  var finalAmount = 0.0.obs;
  var minAmount = 0.0.obs;
  CouponModelResultData? couponModel;
  Rx<TextEditingController> controller = TextEditingController().obs;
  final CouponApi couponApi;

  CouponController({required this.couponApi});

  updateShowErrorDetails(bool status) {
    showDetails.value = status;
    update();
  }

  updateDicountAmount(double amount) {
    discount.value = amount;
    update();
  }

  Future checkCoupon(double amount) async {
    if (couponModel != null) {
      couponModel = CouponModelResultData();
      update();
    }

    if (controller.value.text.trim() != '') {
      var response = await couponApi.checkCoupon(
          amount, controller.value.text.trim().toString());

      if (response != null) {
        if (response['resultData'] != null) {
          couponModel = CouponModelResultData.fromJson(response['resultData']);
          update();
          minAmount.value =
              double.parse(couponModel!.coupon!.minOrder.toString());
          couponName.value = couponModel!.coupon!.couponCode!;
          discount.value = double.parse(couponModel!.discountAmount.toString());

          finalAmount.value =
              double.parse(couponModel!.discountedAmount.toString());
          update();
          if (!couponModel!.applicable!) {
            showDetails.value = true;
            isApplied.value = false;
            update();
          } else {
            showDetails.value = false;
            isApplied.value = true;
            // controller.value.text = '';
            update();
            Get.find<CarSpaController>().clearOffer();
            Get.find<MechanicalController>().clearOffer();
          }
          return couponModel;
        } else {
          isApplied.value = false;
          showDetails.value = false;
          controller.value.text = '';
          update();
          SmartDialog.showToast(
            'Invalid Coupon',
          );
          return null;
        }
      }
    }
  }

  clearValue() {
    showDetails.value = false;
    isApplied.value = false;
    controller.value.text = '';
    update();
  }
}
