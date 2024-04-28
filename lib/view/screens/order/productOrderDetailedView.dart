import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/date_converter.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/data/models/carShoppe/shoppeOrdersModel.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductOrderDetailedView extends StatelessWidget {
  const ProductOrderDetailedView(
      {super.key, this.shoppeOrderResultData, this.isRunning, this.orderId});
  final ShoppeOrderDetail? shoppeOrderResultData;
  final bool? isRunning;
  final String? orderId;

  Future goBack(BuildContext alertContext, BuildContext context) async {
    Navigator.pop(alertContext);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    DateTime expectedDateOfDelivery =
        DateConverter.expectedDeliveryDate(shoppeOrderResultData!.createdAt!);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Order Details',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Bouncing(
                          onPress: () {
                            Get.find<CartControllerFile>().isInCart.value =
                                false;
                            if (Get.find<AuthFactorsController>()
                                .isLoggedIn
                                .value) {
                              Get.find<CartControllerFile>()
                                  .checkProductInCart(
                                      shoppeOrderResultData!.item!.itemId!.id)
                                  .then((value) {
                                Get.find<ProductDetailsController>()
                                    .setProductDetails(
                                        shoppeOrderResultData!.item!.itemId);
                                Get.toNamed(RouteHelper.productDetails);
                              });
                            } else {
                              Get.find<ProductDetailsController>()
                                  .setProductDetails(
                                      shoppeOrderResultData!.item!.itemId);
                              Get.toNamed(RouteHelper.productDetails);
                            }
                          },
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: CustomImage(
                                image: shoppeOrderResultData!
                                                .item!.itemId!.imageUrl !=
                                            null &&
                                        shoppeOrderResultData!
                                                .item!.itemId!.imageUrl!.isNotEmpty
                                    ? shoppeOrderResultData!
                                        .item!.itemId!.imageUrl![0]
                                    : '',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width: 200,
                                    child: Text(
                                        shoppeOrderResultData!.item!.itemId!.name!
                                            .toUpperCase(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: defaultFont(
                                          color: Colors.black,
                                          size: 20,
                                          weight: FontWeight.bold,
                                        ))),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Price Details : ",
                                        style: smallFontW600(Colors.grey),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "List Price :",
                                            style: defaultFont(
                                                color: Colors.black,
                                                size: 15,
                                                weight: FontWeight.w500),
                                          ),
                                          Text(
                                            shoppeOrderResultData!
                                                .item!.itemId!.price
                                                .toString(),
                                            style: smallFont(Colors.black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Selling Price :",
                                            style: defaultFont(
                                                color: Colors.black,
                                                size: 15,
                                                weight: FontWeight.w500),
                                          ),
                                          Text(
                                            shoppeOrderResultData!
                                                .item!.itemId!.offerPrice
                                                .toString(),
                                            style: smallFont(Colors.black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Quantity :",
                                            style: defaultFont(
                                                color: Colors.black,
                                                size: 15,
                                                weight: FontWeight.w500),
                                          ),
                                          Text(
                                            shoppeOrderResultData!.item!.count
                                                .toString(),
                                            style: smallFont(Colors.black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Discount :",
                                            style: defaultFont(
                                                color: Colors.black,
                                                size: 15,
                                                weight: FontWeight.w500),
                                          ),
                                          Text(
                                            shoppeOrderResultData!.discountAmount
                                                .toString(),
                                            style: smallFont(Colors.black),
                                          )
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Total Price :",
                                              style:
                                                  smallFontW600(Colors.black)),
                                          Text(
                                              shoppeOrderResultData!.grandTotal
                                                  .toString(),
                                              style:
                                                  smallFontW600(Colors.black))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                //thickness: 1,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Text(
                    "Order id : ",
                    style: defaultFont(
                        color: Colors.black, size: 15, weight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    shoppeOrderResultData!.orderId!,
                    style: smallFontW600(Colors.black),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Date of order : ",
                    style: defaultFont(
                        color: Colors.black, size: 15, weight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                      '${shoppeOrderResultData!.createdAt!.day}/${shoppeOrderResultData!.createdAt!.month}/${shoppeOrderResultData!.createdAt!.year}',
                      // shoppeOrderResultData.createdAt
                      //     .toString()
                      //     .substring(0, 10),
                      style: smallFontW600(Colors.black))
                ],
              ),
              SizedBox(
                height: shoppeOrderResultData!.status != "Cancelled" ? 10 : 0,
              ),
              shoppeOrderResultData!.status != "Cancelled"
                  ? Row(
                      children: [
                        Text(
                          "Expected Delivery Date : ",
                          style: defaultFont(
                              color: Colors.black,
                              size: 15,
                              weight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                            '${expectedDateOfDelivery.day}/${expectedDateOfDelivery.month}/${expectedDateOfDelivery.year}',
                            // shoppeOrderResultData.createdAt
                            //     .toString()
                            //     .substring(0, 10),
                            style: smallFontW600(Colors.black))
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Status : ",
                    style: defaultFont(
                        color: Colors.black, size: 15, weight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IntrinsicWidth(
                    child: Container(
                      height: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: shoppeOrderResultData!.status == 'Confirmed'
                            ? Colors.blue
                            : shoppeOrderResultData!.status == 'Cancelled'
                                ? Colors.red
                                : shoppeOrderResultData!.status == 'Completed'
                                    ? Colors.green
                                    : shoppeOrderResultData!.status ==
                                            'Dispatched'
                                        ? Colors.yellow[900]
                                        : blackPrimary,
                        borderRadius: BorderRadius.circular(5),
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
                          shoppeOrderResultData!.status == "Rejected"
                              ? 'Yet to Confirmed'
                              : shoppeOrderResultData!.status!,
                          style: smallFontW600(Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                //thickness: 1,
                color: Colors.grey,
              ),
              Container(
                // decoration: BoxDecoration(
                //   color: Colors.white,
                //   borderRadius: BorderRadius.circular(5),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.grey.withOpacity(0.5),
                //       blurRadius: 7,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ],
                // ),
                //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Deliver Address ",
                      style: defaultFont(
                        color: Colors.black,
                        size: 18,
                        weight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        shoppeOrderResultData!.address!.name!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: smallFontW600(Colors.black),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        shoppeOrderResultData!.address!.house!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: smallFont(Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        shoppeOrderResultData!.address!.street!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: smallFont(Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(shoppeOrderResultData!.address!.pincode.toString(),
                        style: smallFontW600(Colors.black))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              isRunning!
                  ? const SizedBox(
                      height: 15,
                    )
                  : const SizedBox(),
              isRunning!
                  ? Bouncing(
                      onPress: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext alertContext) {
                            return AlertDialog(
                              title: Text(
                                'Alert',
                                style: largeFont(Colors.red),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                      'are you sure to cancel this order..?',
                                      style: mediumFont(Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Yes',
                                    style: largeFont(Colors.black),
                                  ),
                                  onPressed: () {
                                    print(shoppeOrderResultData!.id);
                                    Get.find<OrderController>()
                                        .cancelOrder(
                                            serviceCategory:
                                                MainCategory.SHOPPE,
                                            ordID: shoppeOrderResultData!.id,
                                            shortOrderID:
                                                shoppeOrderResultData!.orderId)
                                        .then((value) => goBack(
                                                alertContext, context)
                                            .then((value) => Get.find<
                                                    ProductCategoryController>()
                                                .getOrderRunningDetailsShoppe(
                                                    '1')));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: IntrinsicWidth(
                            child: Container(
                              height: 50,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "Cancel the Order",
                                  style: defaultFont(
                                    color: Colors.black,
                                    size: 18,
                                    weight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
