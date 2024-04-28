import 'dart:developer';

import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/data/models/carShoppe/shippingModel.dart';
import 'package:shoppe_customer/data/models/couponModel.dart';

class BuyNowController extends GetxController implements GetxService {
  var buyNowQuantity = 1.obs;
  var totalAmount = 0.0.obs;
  List<ShippingResultData> shippingDetailsList = [];

  void addQuantity({required num price, num? deliveryCharge}) {
    buyNowQuantity.value = buyNowQuantity.value + 1;
    update();
    buyNowTotal(price: price, deliveryCharge: deliveryCharge);
  }

  void subQuantity({num? price, num? deliveryCharge}) {
    if (buyNowQuantity.value > 1) {
      buyNowQuantity.value = buyNowQuantity.value - 1;
      update();
      buyNowTotal(price: price!, deliveryCharge: deliveryCharge);
    }
  }

  setShippingData(List<ShippingResultData> list) {
    shippingDetailsList.addAll(list);
    update();
  }

  buyNowTotal({required num price, num? deliveryCharge}) {
    CouponModelResultData? couponDetails =
        Get.find<CouponController>().couponModel;
    var subTotal = 0.0;
    if (shippingDetailsList[0].minimum! < (price * buyNowQuantity.value)) {
      subTotal = double.parse((price * buyNowQuantity.value).toString());
      Get.find<ProductCategoryController>().setShippingPrice(0);
    } else {
      subTotal = double.parse(
          ((price * buyNowQuantity.value) + shippingDetailsList[0].rate!)
              .toString());
      Get.find<ProductCategoryController>()
          .setShippingPrice(shippingDetailsList[0].rate as int);
    }

    if (Get.find<CouponController>().isApplied.value) {
      if (isCouponApplicable(
          couponDetails: couponDetails!, totalAmount: subTotal)) {
        if (couponDetails.coupon!.discountType == 'flat') {
          totalAmount.value =
              (subTotal - couponDetails.coupon!.discountAmount!).toDouble();
          update();
        } else {
          double percentage =
              double.parse(couponDetails.coupon!.discountAmount.toString());
          double percentageTotal =
              double.parse((subTotal * (percentage / 100)).toString());
          if (subTotal > couponDetails.coupon!.minOrder!) {
            if (percentageTotal < couponDetails.coupon!.maxAmount!) {
              totalAmount.value = (subTotal - percentageTotal).toDouble();
              Get.find<CouponController>().updateDicountAmount(percentageTotal);
              update();
            } else {
              totalAmount.value =
                  (subTotal - couponDetails.coupon!.maxAmount!).toDouble();
              update();
              Get.find<CouponController>().updateDicountAmount(
                  double.parse(couponDetails.coupon!.maxAmount.toString()));
            }
          }
        }
      } else {
        log("coupon is not applicable");
        Get.find<CouponController>().clearValue();
        //buyNowTotal(price: null);
      }
    } else {
      totalAmount.value = subTotal;
      update();
    }
    setTotalAmount(totalAmount.value);
  }

  setTotalAmount(double total) {
    totalAmount.value = total;
    update();
  }

  setBuyNowQuantity(int val) {
    buyNowQuantity.value = val;
    update();
  }

  isCouponApplicable(
      {required double totalAmount,
      required CouponModelResultData couponDetails}) {
    double.parse(couponDetails.coupon!.minOrder.toString());
    if ((totalAmount +
            double.parse(couponDetails.coupon!.discountAmount.toString())) >
        double.parse(couponDetails.coupon!.minOrder.toString())) {
      return true;
    } else {
      return false;
    }
  }
}
