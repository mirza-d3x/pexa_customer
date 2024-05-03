import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/data/models/product_details.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/paymentController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ShoppePayment extends StatefulWidget {
  ShoppePayment({super.key, required this.product});
  ProductId? product;

  @override
  State<ShoppePayment> createState() => _ShoppePaymentState();
}

class _ShoppePaymentState extends State<ShoppePayment> {
  late Razorpay _razorpay;
  var payment = Get.find<PaymentController>();
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

  void openCheckout() async {
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
    payment
        .shoppeCheckout(
            widget.product!.id,
            Get.find<BuyNowController>().buyNowQuantity.toString(),
            Get.find<CouponController>().couponName.value)
        .then((value) {
      var options = {
        'key': key,
        'amount': payment.result[0].amount,
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
        'order_id': payment.result[0].id,
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.find<ProductCategoryController>().isBuying.value = false;
    Get.find<ProductCategoryController>().update();
    showCustomSnackBar("Payment Successful");
    // SmartDialog.showToast(
    //   "Payment Successful",
    // );
    Get.offAll(() => const SuccessPage());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.find<ProductCategoryController>().isBuying.value = false;
    Get.find<ProductCategoryController>().update();
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
    var product = widget.product;
    // Get.find<CouponController>().clearValue();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Payment'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<CouponController>(builder: (couponController) {
          return GetBuilder<ProductCategoryController>(
              builder: (productCategoryController) {
            return GetBuilder<PaymentController>(builder: (payment) {
              return GetBuilder<BuyNowController>(builder: (buyNowController) {
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
                              offset:
                                  const Offset(0, 3), // changes position of shadow
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
                              const Text('Price (1 item)'),
                              const Spacer(),
                              Text(PriceConverter.priceToDecimal(
                                  product!.price.toString()))
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Offer Price'),
                              const Spacer(),
                              Text(PriceConverter.priceToDecimal(
                                  product.offerPrice))
                              //product.offerPrice.toString() + '.00')
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Discount'),
                              const Spacer(),
                              Text(PriceConverter.priceToDecimal(
                                  product.price! - product.offerPrice!))
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Delivery Charge'),
                              const Spacer(),
                              Text(PriceConverter.priceToDecimal(
                                  productCategoryController
                                      .buyNowShipping.value))
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Quantity'),
                              const Spacer(),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        buyNowController.subQuantity(
                                            price: product.offerPrice,
                                            deliveryCharge:
                                                productCategoryController
                                                    .buyNowShipping.value);
                                      },
                                      child: Text(
                                        '-',
                                        style: defaultFont(
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w400,
                                        ),
                                      )),
                                  Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        //borderRadius: BorderRadius.circular(10),
                                        //color: Colors.black,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(buyNowController
                                          .buyNowQuantity
                                          .toString())),
                                  TextButton(
                                      onPressed: () {
                                        buyNowController.addQuantity(
                                            price: product.offerPrice!,
                                            deliveryCharge:
                                                productCategoryController
                                                    .buyNowShipping.value);
                                      },
                                      child: Text(
                                        '+',
                                        style: defaultFont(
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.w400,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          couponController.isApplied.value
                              ? Row(
                                  children: [
                                    const Text('Coupon Discount'),
                                    const Spacer(),
                                    Text(couponController.discount.toString())
                                  ],
                                )
                              : const SizedBox(),
                          const Divider(
                            color: Colors.black,
                          ),
                          // couponController.isApplied.value
                          //     ? Row(
                          //         children: [
                          //           Text('Total'),
                          //           Spacer(),
                          //           Text(priceToDecimal(
                          //               couponController.finalAmount.value))
                          //         ],
                          //       )
                          //     :
                          Row(
                            children: [
                              const Text('Total'),
                              const Spacer(),
                              Text(PriceConverter.priceToDecimal(
                                  buyNowController.totalAmount.value
                                      .toString()))
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.black),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.86,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black38, width: 1),
                              ),
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                controller: couponController.controller.value,
                                onChanged: (value) {
                                  if (couponController.couponName !=
                                          couponController
                                              .controller.value.text &&
                                      couponController.showDetails.value) {
                                    couponController
                                        .updateShowErrorDetails(false);
                                  }
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText:
                                        'Enter Coupon Code or Gift card no.',
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (couponController
                                                      .controller.value.text
                                                      .trim() !=
                                                  null ||
                                              couponController
                                                      .controller.value.text
                                                      .trim() !=
                                                  '') {
                                            couponController
                                                .checkCoupon(buyNowController
                                                    .totalAmount.value)
                                                .then((value) {
                                              if (value != null &&
                                                  value.applicable) {
                                                buyNowController.setTotalAmount(
                                                    couponController
                                                        .finalAmount.value);
                                              }
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.send,
                                            color: Colors.black))),
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
                                              style:
                                                  smallFontW600(Colors.green),
                                            ),
                                            // SizedBox(
                                            //   width: Dimensions
                                            //       .PADDING_SIZE_EXTRA_SMALL,
                                            // ),
                                            IconButton(
                                                onPressed: () {
                                                  couponController.clearValue();
                                                  buyNowController.buyNowTotal(
                                                      price: product.offerPrice!,
                                                      deliveryCharge:
                                                          productCategoryController
                                                              .buyNowShipping
                                                              .value);
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
                      width: MediaQuery.of(context).size.width,
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black38, width: 1),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    Row(children: [
                                      Radio(
                                          activeColor: Theme.of(context)
                                              .secondaryHeaderColor,
                                          value: 'cod',
                                          groupValue: payment.paymentMode.value,
                                          onChanged: (dynamic value) {
                                            print(value);
                                            if (product.modes != null &&
                                                product.modes!.cod!) {
                                              payment.updatePaymentMode('cod');
                                            }
                                          }),
                                      Text(
                                        'Cash on Delivery',
                                        style: smallFont(product.modes !=
                                                    null &&
                                                product.modes!.cod!
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color
                                            : Theme.of(context).disabledColor),
                                      ),
                                    ]),
                                    (product.modes != null && product.modes!.cod!)
                                        ? const SizedBox()
                                        : Text(
                                            'Cash on delivery is not available for this product',
                                            style: smallFont(Theme.of(context)
                                                .disabledColor),
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
                                            if (product.modes != null &&
                                                product.modes!.online!) {
                                              payment
                                                  .updatePaymentMode('online');
                                            }
                                          }),
                                      Text(
                                        'Pay Online',
                                        style: smallFont(product.modes !=
                                                    null &&
                                                product.modes!.online!
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color
                                            : Theme.of(context).disabledColor),
                                      ),
                                    ]),
                                    (product.modes != null &&
                                            product.modes!.online!)
                                        ? const SizedBox()
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: Get.width * 0.05),
                                            child: Text(
                                              'Online payment is not available for this product right now.',
                                              style: smallFont(Theme.of(context)
                                                  .disabledColor),
                                            ),
                                          ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
            });
          });
        }),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GetBuilder<PaymentController>(builder: (payment) {
          return GetBuilder<CouponController>(builder: (couponController) {
            return GetBuilder<ProductCategoryController>(
                builder: (productCategoryController) {
              return GetBuilder<BuyNowController>(builder: (buyNowController) {
                return InkWell(
                  onTap: () {
                    if (payment.paymentMode.value == 'online' ||
                        payment.paymentMode.value == 'cod') {
                      productCategoryController.isBuying.value = true;
                      productCategoryController.update();
                      if (productCategoryController.isBuying.value) {
                        if (payment.paymentMode.value == 'cod') {
                          if (couponController.isApplied.value == true) {
                            Map<String, dynamic> body = {
                              "product": product!.id,
                              "count": buyNowController.buyNowQuantity.value,
                              "couponCode": couponController.couponName.value
                            };
                            productCategoryController.buyNowProduct(body).then(
                                (value) => (value)
                                    ? {Get.to(() => const SuccessPage())}
                                    : null);
                          } else {
                            Map<String, dynamic> body = {
                              "product": product!.id,
                              "count": buyNowController.buyNowQuantity.value
                            };
                            productCategoryController.buyNowProduct(body).then(
                                (value) => (value)
                                    ? {Get.to(() => const SuccessPage())}
                                    : null);
                          }
                        } else if (payment.paymentMode.value == 'online') {
                          print('online');
                          openCheckout();
                          print(product!.id);
                          //Get.toNamed('/payment');
                        } else {
                          SmartDialog.showToast(
                            'Select Payment Mode',
                          );
                        }
                      }
                    } else {
                      SmartDialog.showToast(
                        'Select Payment Mode',
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
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
                      child: productCategoryController.isBuying.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              payment.paymentMode.value == 'online'
                                  ? 'Pay ${PriceConverter.priceToDecimal(buyNowController.totalAmount.value)}'
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


class PriceDetailsWidget

 extends StatelessWidget {
  const PriceDetailsWidget
  
  ({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}