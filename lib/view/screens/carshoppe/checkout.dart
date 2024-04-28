import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';

class ShoppeCheckout extends StatelessWidget {
  const ShoppeCheckout({super.key});
  @override
  Widget build(BuildContext context) {
    //var product = Get.arguments['product'];

    return Scaffold(
        backgroundColor: const Color(0xFFF0F4F7),
        appBar: const CustomAppBar(
          title: 'Checkout',
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            GetBuilder<ProductDetailsController>(
                builder: (productDetailController) {
              return Container(
                // height: MediaQuery.of(context).size.height * 0.3,
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
                    ]),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.height * 0.1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomImage(
                                image: productDetailController
                                                .productDetails!.imageUrl !=
                                            null &&
                                        productDetailController.productDetails!
                                                .imageUrl!.isNotEmpty
                                    ? productDetailController
                                        .productDetails!.imageUrl![0]
                                    : "",
                                fit: BoxFit.cover,
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        GetBuilder<BuyNowController>(
                            builder: (buyNowController) {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    productDetailController.productDetails!.name!,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: defaultFont(
                                      color: Colors.black,
                                      size: 20,
                                      weight: FontWeight.bold,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      ResponsiveHelper.isMobile(context)
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
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
                                            productDetailController
                                                .productDetails!.price
                                                .toString()))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Offer Price'),
                                        const Spacer(),
                                        Text(PriceConverter.priceToDecimal(
                                            productDetailController
                                                .productDetails!.offerPrice))
                                        //product.offerPrice.toString() + '.00')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Discount'),
                                        const Spacer(),
                                        Text(PriceConverter.priceToDecimal(
                                            productDetailController
                                                    .productDetails!.price! -
                                                productDetailController
                                                    .productDetails!.offerPrice!))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Delivery Charge'),
                                        const Spacer(),
                                        Text(PriceConverter.priceToDecimal(
                                            Get.find<
                                                    ProductCategoryController>()
                                                .buyNowShipping
                                                .value))
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
                                                      price:
                                                          productDetailController
                                                              .productDetails!
                                                              .offerPrice,
                                                      deliveryCharge: Get.find<
                                                              ProductCategoryController>()
                                                          .buyNowShipping
                                                          .value);
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
                                                      color: Colors.black,
                                                      width: 1),
                                                  //borderRadius: BorderRadius.circular(10),
                                                  //color: Colors.black,
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(buyNowController
                                                    .buyNowQuantity.value
                                                    .toString())),
                                            TextButton(
                                                onPressed: () {
                                                  buyNowController.addQuantity(
                                                      price:
                                                          productDetailController
                                                              .productDetails!
                                                              .offerPrice!,
                                                      deliveryCharge: Get.find<
                                                              ProductCategoryController>()
                                                          .buyNowShipping
                                                          .value);
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
                                    Get.find<CouponController>().isApplied.value
                                        ? Row(
                                            children: [
                                              const Text('Coupon Discount'),
                                              const Spacer(),
                                              Text(Get.find<CouponController>()
                                                  .discount
                                                  .toString())
                                            ],
                                          )
                                        : const SizedBox(),
                                    const Divider(
                                      color: Colors.black,
                                    ),
                                    Get.find<CouponController>().isApplied.value
                                        ? Row(
                                            children: [
                                              const Text('Total'),
                                              const Spacer(),
                                              Text(PriceConverter
                                                  .priceToDecimal(Get.find<
                                                          CouponController>()
                                                      .finalAmount
                                                      .value))
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              const Text('Total'),
                                              const Spacer(),
                                              Text(
                                                  PriceConverter.priceToDecimal(
                                                      buyNowController
                                                          .totalAmount.value
                                                          .toString()))
                                            ],
                                          )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //     height: 30,
                    //     width: MediaQuery.of(context).size.width * 0.86,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5),
                    //       color: Colors.white,
                    //       border: Border.all(color: Colors.black38, width: 1),
                    //     ),
                    //     alignment: Alignment.center,
                    //     child: Text('Delete'))
                  ],
                ),
              );
            }),
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
                  ]),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shipment Address',
                      style: defaultFont(
                        color: Colors.black,
                        size: 20,
                        weight: FontWeight.w400,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<AddressControllerFile>(
                      builder: (addressController) {
                    return Row(
                      children: [
                        Radio(
                          value: true,
                          activeColor: Theme.of(context).secondaryHeaderColor,
                          groupValue: true,
                          onChanged: (dynamic value) {},
                        ),
                        addressController.addressList == null ||
                                addressController.addressList!.isEmpty
                            ? SizedBox(
                                height: 80,
                                child: Center(
                                  child: (addressController.isNoAddress.value)
                                      ? Text(
                                          'No Saved Address',
                                          style: mediumFont(Colors.black),
                                        )
                                      : LoadingAnimationWidget.twistingDots(
                                          leftDotColor: const Color(0xFF4B4B4D),
                                          rightDotColor:
                                              const Color(0xFFf7d417),
                                          size: 50,
                                        ),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.all(15),
                                width: MediaQuery.of(context).size.width * 0.7,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  color: Colors.white,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey
                                  //         .withOpacity(0.5),
                                  //     blurRadius: 7,
                                  //     offset: Offset(0,
                                  //         3), // changes position of shadow
                                  //   ),
                                  // ],
                                ),
                                child: addressController.defaultAddress != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  addressController
                                                      .defaultAddress!.name!,
                                                  style: defaultFont(
                                                    color: Colors.black,
                                                    size: 18,
                                                    weight: FontWeight.w400,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 0.1,
                                                      horizontal: 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[200],
                                                      borderRadius:
                                                          const BorderRadius.all(
                                                              Radius.circular(
                                                                  5))),
                                                  child: Text(
                                                      addressController
                                                          .defaultAddress!.type!,
                                                      style: mediumFont(
                                                          Colors.black))),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 2.5,
                                          ),
                                          Text(
                                              '${addressController
                                                      .defaultAddress!.house!}, ${addressController
                                                      .defaultAddress!.street!}, ${addressController
                                                      .defaultAddress!.pincode}',
                                              style: defaultFont(
                                                color: Colors.black,
                                                size: 18,
                                                weight: FontWeight.w400,
                                              )),
                                          const SizedBox(
                                            height: 2.5,
                                          ),
                                          Text(
                                            addressController
                                                .defaultAddress!.mobile
                                                .toString(),
                                            style: defaultFont(
                                              color: Colors.black,
                                              size: 18,
                                              weight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(
                                        height: 80,
                                        child: Center(
                                          child: Text(
                                              'No address is set as default',
                                              style: mediumFont(Colors.black)),
                                        ),
                                      ),
                              ),
                      ],
                    );
                  }),
                  const Divider(
                    color: Colors.black26,
                    thickness: 1,
                  ),
                  InkWell(
                    onTap: () {
                      //_onAlertButtonPressed1(context);
                      Get.toNamed(RouteHelper.addressDetailsPage,
                          arguments: {'context': context});
                    },
                    child: Container(
                      child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Edit Address')),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.addressDetailsPage,
                          arguments: {'context': context});
                    },
                    child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(color: Colors.black38, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Add New Address')),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        )),
        bottomNavigationBar: Container(
          height: 130,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          child:
              GetBuilder<AddressControllerFile>(builder: (addressController) {
            return Column(children: [
              GetBuilder<ProductDetailsController>(
                  builder: (productDetailController) {
                return InkWell(
                  onTap: (() {
                    if (addressController.defaultAddress != null) {
                      Get.toNamed(RouteHelper.shoppePayment, arguments: {
                        'product': productDetailController.productDetails
                      });
                    } else {
                      showCustomSnackBar("Please set a default address.",
                          isError: true);
                    }
                  }),

                  //!Important Code

                  // onTap: Get.find<CouponController>().isApplied.value
                  //     ? () {
                  //         Map<String, dynamic> body = {
                  //           "product": product.id,
                  //           "count":
                  //               Get.find<BuyNowController>().buyNowQuantity.value,
                  //           "couponCode":
                  //               Get.find<CouponController>().couponName.value
                  //         };
                  //         Get.find<ProductCategoryController>()
                  //             .buyNowProduct(body)
                  //             .then((value) =>
                  //                 (value) ? {Get.to(() => SuccessPage())} : null);
                  //       }
                  //     : () {
                  //         Map<String, dynamic> body = {
                  //           "product": product.id,
                  //           "count":
                  //               Get.find<BuyNowController>().buyNowQuantity.value
                  //         };
                  //         Get.find<ProductCategoryController>()
                  //             .buyNowProduct(body)
                  //             .then((value) =>
                  //                 (value) ? {Get.to(() => SuccessPage())} : null);
                  //       },

                  //!Important Code
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: addressController.defaultAddress != null
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: const Text('Proceed'),
                  ),
                );
              }),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text('Cancel'),
                ),
              ),
            ]);
          }),
        ));
  }
}
