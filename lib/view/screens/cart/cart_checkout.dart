import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/carShoppe/cartListModel.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/cart/widget/address_widget.dart';

class CartCheckout extends StatelessWidget {
  CartCheckout({super.key});

  var productDetailController = Get.find<ProductDetailsController>();
  String prodQty = '';
  List<CartItem>? cartItem;

  @override
  Widget build(BuildContext context) {
    final addressController = Get.find<AddressControllerFile>();
    if (addressController.addressList == null ||
        addressController.addressList!.isEmpty) {
      addressController.getAddress();
    }
    //var product = Get.arguments['product'];
    Get.find<BuyNowController>().buyNowQuantity.value =
        Get.find<ProductDetailsController>().prodCount.value;
    // Get.find<BuyNowController>().buyNowTotal(
    //     price: productDetailController.productDetails.offerPrice,
    //     deliveryCharge:
    //         Get.find<ProductCategoryController>().buyNowShipping.value);
    // Get.find<ProductCategoryController>().getShippingDetails(
    //     productDetailController.productDetails.offerPrice.toString());
    // Get.find<CouponController>().clearValue();

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppBar(
          title: 'Checkout',
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            addressWidget(context),
            const SizedBox(
              height: 20,
            ),
            Container(
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
              child: GetBuilder<CartControllerFile>(builder: (cartController) {
                cartItem = cartController.cartList;
                return Column(
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text("Grand Total : "),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '₹ ${cartController.cartGrandTotal}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 10, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  cartController.cartGrandTotal <=
                                          cartController.cartMinimumOrderAmount
                                      ? "* Delivery charge of ₹${cartController.cartShipping
                                              .round()} is included"
                                      : "Free delivery",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    color: cartController.cartGrandTotal <= 2000
                                        ? Colors.amber.shade900
                                        : Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.delivery_dining,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      padding: const EdgeInsets.all(10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartItem!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(thickness: 2),
                      itemBuilder: (context, index) {
                        return productDetailWidget(
                            context: context,
                            cartItem: cartItem![index],
                            index: index);
                      },
                    ),
                  ],
                );
              }),
            ),
          ]),
        )),
        bottomNavigationBar: Container(
          height: 130,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: [
            InkWell(
              onTap: (() {
                if (addressController.defaultAddress != null) {
                  Get.toNamed(RouteHelper.cartPayment);
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
            ),
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
          ]),
        ));
  }

  Widget productDetailWidget(
      {BuildContext? context, CartItem? cartItem, int? index}) {
    return GetBuilder<CartControllerFile>(builder: (cartController) {
      return GetBuilder<BuyNowController>(builder: (buyNowController) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                      height: Get.height * 0.06,
                      width: Get.height * 0.06,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomImage(
                          image: cartItem!.product!.imageUrl != null &&
                                  cartItem.product!.imageUrl!.isNotEmpty
                              ? cartItem.product!.imageUrl![0]
                              : "",
                          fit: BoxFit.cover,
                        ),
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(cartItem.product!.name!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: defaultFont(
                          color: Colors.black,
                          size: 18,
                          weight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Payments Support'),
                      Row(
                        children: [
                          Icon(
                            cartItem.product!.modes!.cod!
                                ? Icons.check
                                : Icons.clear,
                            color: cartItem.product!.modes!.cod!
                                ? Colors.green
                                : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('COD')
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            cartItem.product!.modes!.online!
                                ? Icons.check
                                : Icons.clear,
                            color: cartItem.product!.modes!.online!
                                ? Colors.green
                                : Colors.red,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text('Online')
                        ],
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width * 0.44,
                        child: Row(
                          children: [
                            const Text('Quantity :'),
                            SizedBox(
                              width: 40,
                              child: TextButton(
                                  onPressed: () {
                                    if (cartItem.count! > 1) {
                                      cartController.setQuantity(
                                          index: index!,
                                          count: cartItem.count! - 1);
                                      cartController
                                          .addOrUpdateToCart(
                                              cartItem.product!.id,
                                              cartItem.count as int?,
                                              'update')
                                          .then((value) => cartController
                                              .getCartDetails(false));
                                    }
                                  },
                                  child: Text(
                                    '-',
                                    style: defaultFont(
                                      color: Colors.black,
                                      size: 20,
                                      weight: FontWeight.w400,
                                    ),
                                  )),
                            ),
                            Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  //borderRadius: BorderRadius.circular(10),
                                  //color: Colors.black,
                                ),
                                alignment: Alignment.center,
                                child: Text(cartItem.count.toString())),
                            SizedBox(
                              width: 40,
                              child: TextButton(
                                  onPressed: () {
                                    if (cartItem.count! <
                                        cartItem.product!.quantity!) {
                                      cartController.setQuantity(
                                          count: cartItem.count! + 1,
                                          index: index!);
                                      cartController
                                          .addOrUpdateToCart(
                                              cartItem.product!.id,
                                              cartItem.count as int?,
                                              'update')
                                          .then((value) => cartController
                                              .getCartDetails(false));
                                    } else {
                                      showCustomSnackBar(
                                          'Quantity should be less than the stock..!',
                                          title: "Error",
                                          isError: true);
                                    }
                                  },
                                  child: Text(
                                    '+',
                                    style: defaultFont(
                                      color: Colors.black,
                                      size: 20,
                                      weight: FontWeight.w400,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Get.find<CouponController>().isApplied.value
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: MediaQuery.of(context!).size.width * 0.44,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('Total'),
                                    const Spacer(),
                                    Text(PriceConverter.priceToDecimal(
                                        Get.find<CouponController>()
                                            .finalAmount
                                            .value)),
                                    const Spacer()
                                  ],
                                ),
                              ),
                            )
                          : Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: MediaQuery.of(context!).size.width * 0.4,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('Total :'),
                                    const Spacer(),
                                    Text('₹ ${cartItem.product!.offerPrice! *
                                                cartItem.count!}'),
                                    const Spacer()
                                  ],
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      });
    });
  }
}
