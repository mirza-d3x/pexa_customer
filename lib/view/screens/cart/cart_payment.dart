import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/paymentController.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPayment extends StatefulWidget {
  const CartPayment({super.key});

  @override
  State<CartPayment> createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  late Razorpay _razorpay;
  // var payment = Get.find<PaymentController>();
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout({String? coupon}) async {
    Get.find<PaymentController>().cartCheckout(coupon: coupon).then((value) {
      if (value) {
        String? key;
        if (Get.find<ConnectivityController>().initialDataModel != null) {
          for (var element in Get.find<ConnectivityController>()
              .initialDataModel!
              .resultData!) {
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
        var options = {
          'key': key,
          'amount': Get.find<PaymentController>().result[0].amount,
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
          'order_id': Get.find<PaymentController>().result[0].id,
        };

        try {
          Get.find<CartControllerFile>().setBuyingStatus(true);
          _razorpay.open(options);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.find<CartControllerFile>().setBuyingStatus(false);
    showCustomSnackBar("Payment Successful");
    Get.find<CartControllerFile>().clearCart();
    // SmartDialog.showToast(
    //   "Payment Successful",
    // );
    Get.offAll(() => const SuccessPage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.find<CartControllerFile>().setBuyingStatus(false);
    showCustomSnackBar("Payment Cancelled", isError: true);
    //   SmartDialog.showToast(
    //       // "ERROR: " + response.code.toString() + " - " + response.message,
    //       "Payment Cancelled");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SmartDialog.showToast(
      "EXTERNAL_WALLET: ${response.walletName!}",
    );
  }

  @override
  Widget build(BuildContext context) {
    // payment.paymentMode.value = '';
    // var product = widget.product;
    // Get.find<CouponController>().clearValue();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<CouponController>(builder: (couponController) {
          return GetBuilder<CartControllerFile>(builder: (cartController) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price Details',
                          style: defaultFont(
                            color: Colors.black,
                            size: 15,
                            weight: FontWeight.w400,
                          )),
                      const Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          const Text('Total Price'),
                          const Spacer(),
                          Text(PriceConverter.priceToDecimal(
                              cartController.cartTotalPrice))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Total Discounted'),
                          const Spacer(),
                          Text(PriceConverter.priceToDecimal(
                              cartController.cartTotalDiscount))
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Delivery Charge'),
                          const Spacer(),
                          Text(PriceConverter.priceToDecimal(
                              cartController.cartShipping))
                        ],
                      ),
                      couponController.isApplied.value
                          ? Row(
                              children: [
                                const Text('Coupon Discount'),
                                const Spacer(),
                                Text(
                                  PriceConverter.priceToDecimal(
                                    couponController.discount.toString(),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox(),
                      const Divider(
                        color: Colors.black,
                      ),
                      // Get.find<CouponController>().isApplied.value
                      //     ? Row(
                      //         children: [
                      //           Text('Total'),
                      //           Spacer(),
                      //           Text(priceToDecimal(Get.find<CouponController>()
                      //               .finalAmount
                      //               .value))
                      //         ],
                      //       )
                      //     :
                      Row(
                        children: [
                          const Text('Total'),
                          const Spacer(),
                          Text(PriceConverter.priceToDecimal(
                              cartController.cartGrandTotal.toString()))
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                                                  .trim() !=
                                              null ||
                                          couponController.controller.value.text
                                                  .trim() !=
                                              '') {
                                        couponController.checkCoupon(
                                            cartController.cartGrandTotal
                                                .toDouble());
                                      }
                                    },
                                    icon:
                                        const Icon(Icons.send, color: Colors.black))),
                          )),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            )),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text('Payment Options'),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black38, width: 1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child:
                            GetBuilder<PaymentController>(builder: (payment) {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Radio(
                                        activeColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        value: 'cod',
                                        groupValue: payment.paymentMode.value,
                                        onChanged: (dynamic value) {
                                          print(value);
                                          if (cartController.cartResult
                                              .resultData!.availableModes!.cod!) {
                                            payment.updatePaymentMode('cod');
                                          }
                                        }),
                                    Text(
                                      'Cash on Delivery',
                                      style: smallFont(cartController.cartResult
                                              .resultData!.availableModes!.cod!
                                          ? Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color
                                          : Theme.of(context).disabledColor),
                                    ),
                                  ]),
                                  cartController.cartResult.resultData!
                                          .availableModes!.cod!
                                      ? const SizedBox()
                                      : Container(
                                          margin: const EdgeInsets.only(left: 50),
                                          child: Text(
                                            'Some of the product in your cart doesn\'t support Cash on Delivery.',
                                            style: smallFont(Theme.of(context)
                                                .disabledColor),
                                          ),
                                        ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(
                                color: Colors.black,
                              ),
                              Column(
                                children: [
                                  Row(children: [
                                    Radio(
                                        activeColor: Theme.of(context)
                                            .secondaryHeaderColor,
                                        value: 'online',
                                        groupValue: payment.paymentMode.value,
                                        onChanged: (dynamic value) {
                                          print(value);
                                          if (cartController
                                              .cartResult
                                              .resultData!
                                              .availableModes!
                                              .online!) {
                                            payment.updatePaymentMode('online');
                                          }
                                        }),
                                    Text('Pay Online',
                                        style: smallFont(cartController
                                                .cartResult
                                                .resultData!
                                                .availableModes!
                                                .online!
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color
                                            : Theme.of(context).disabledColor)),
                                  ]),
                                  cartController.cartResult.resultData!
                                          .availableModes!.online!
                                      ? const SizedBox()
                                      : Container(
                                          margin: const EdgeInsets.only(left: 50),
                                          child: Text(
                                            'Online payment is not available for this product right now.',
                                            style: smallFont(Theme.of(context)
                                                .disabledColor),
                                          ),
                                        ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          });
        }),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GetBuilder<CartControllerFile>(builder: (cartController) {
          return GetBuilder<AddressControllerFile>(
              builder: (addressController) {
            return GetBuilder<PaymentController>(builder: (payment) {
              return GetBuilder<CouponController>(builder: (couponController) {
                return InkWell(
                  onTap: () {
                    if (!cartController.isBuying.value) {
                      if (payment.paymentMode.value == '') {
                        showCustomSnackBar('Please select payment type');
                      } else {
                        if (addressController.addressList!.isNotEmpty) {
                          if (couponController.isApplied.value) {
                            if (payment.paymentMode.value == 'online') {
                              openCheckout(
                                  coupon: couponController.couponName.value);
                            } else {
                              Get.find<CartControllerFile>()
                                  .placeOrderWithCoupon(
                                      couponController.couponName.value)
                                  .then((value) => (value)
                                      ? {Get.to(() => const SuccessPage())}
                                      : null);
                            }
                          } else {
                            if (payment.paymentMode.value == 'online') {
                              openCheckout();
                            } else {
                              Get.find<CartControllerFile>().placeOrder().then(
                                  (value) => (value)
                                      ? {Get.to(() => const SuccessPage())}
                                      : null);
                            }
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: cartController.isBuying.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              payment.paymentMode.value == 'online'
                                  ? 'Pay ${PriceConverter.priceToDecimal(cartController.cartGrandTotal)}'
                                  : 'Checkout',
                              style: defaultFont(
                                  weight: FontWeight.w600, size: 18),
                            ),
                    ),
                  ),
                );
              });
            });
          });
        }),
      ),
    );
  }
}
