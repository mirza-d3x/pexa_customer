import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/paymentController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ServicePaymentWidget extends StatefulWidget {
  const ServicePaymentWidget({super.key, this.body, this.mainServiceCategory});
  final Map<String, dynamic>? body;
  final MainCategory? mainServiceCategory;

  @override
  State<ServicePaymentWidget> createState() => _ServicePaymentWidgetState();
}

class _ServicePaymentWidgetState extends State<ServicePaymentWidget> {
  late Razorpay _razorpay;
  var paymentController = Get.find<PaymentController>();
  var timeSlot = Get.find<ServiceCheckOutController>().timeSlot.value;
  var categoryId = Get.find<ServiceCheckOutController>().serviceId.value;
  var data = Get.find<locationPermissionController>().currentPosition;
  final couponController = Get.find<CouponController>();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    String? key;
    if (Get.find<ConnectivityController>().initialDataModel != null) {
      for (var element
          in Get.find<ConnectivityController>().initialDataModel!.resultData!) {
        if (element.type == "rzp_key") {
          key = element.value;
        }
      }
    } else {
      Get.find<ConnectivityController>().getInitialData().then(
        (value) {
          for (var element in Get.find<ConnectivityController>()
              .initialDataModel!
              .resultData!) {
            if (element.type == "rzp_key") {
              key = element.value;
            }
          }
        },
      );
    }
    RxList addOns = RxList();
    if (widget.mainServiceCategory == MainCategory.MECHANICAL) {
      addOns = Get.find<MechanicalController>().mechanicalAddOns;
    }
    if (widget.mainServiceCategory == MainCategory.CARSPA) {
      addOns = Get.find<CarSpaController>().carSpaAddOns;
    }
    paymentController
        .serviceCheckout(
            categoryId: categoryId,
            data: data,
            addOns: addOns,
            timeSlot: timeSlot,
            mainServiceCategory: widget.mainServiceCategory)
        .then((value) {
      if (value) {
        var options = {
          'key': key,
          'amount': couponController.isApplied.isTrue
              ? couponController.finalAmount.value
              : paymentController.result[0].amount,
          'name': 'Pexa',
          'description': '360° Car Care',
          'prefill': {
            'contact':
                Get.find<AuthFactorsController>().phoneNumber.value.toString(),
            'email':
                Get.find<AuthFactorsController>().userDetails!.email.toString()
          },
          'theme': {
            'hide_topbar': true,
          },
          'order_id': paymentController.result[0].id,
        };

        try {
          log((couponController.isApplied.isTrue
                  ? couponController.finalAmount.value
                  : paymentController.result[0].amount)
              .toString());
          print(options);
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        Navigator.of(context).pop();
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    SmartDialog.showToast(
      "Payment Successful",
    );
    // if (widget.mainServiceCategory == MainCategory.QUICKHELP) {
    Get.offAll(() => const SuccessPage());
    // } else {
    //   Get.find<ServiceCheckOutController>()
    //       .placeOrder(widget.body, widget.mainServiceCategory)
    //       .then((value) => Get.offAll(() => SuccessPage()));
    // }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SmartDialog.showToast(
      // "ERROR: " + response.code.toString() + " - " + response.message,
      response.message!,
    );
    print("${response.code} - ${response.message!}");
    // Get.offAllNamed('/');
    Get.back();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SmartDialog.showToast(
      "EXTERNAL_WALLET: ${response.walletName!}",
    );
  }

  @override
  Widget build(BuildContext context) {
    print('data $data');
    print('timeSlot $timeSlot');
    print('categoryId $categoryId');
    return const Scaffold(
      appBar: CustomAppBar(title: 'Payments'),
      // body: Center(
      //   child: InkWell(
      //       onTap: () {
      //         openCheckout();
      //       },
      //       child: Text('CarSpaPayments')),
      // ),
    );
  }
}
