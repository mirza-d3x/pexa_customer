import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class ShoppeProductTile extends StatelessWidget {
  ShoppeProductTile({
    super.key,
    this.padding,
    this.childCount,
    this.elementCrossCount,
    this.data,
    this.index,
    this.type,
  });
  final int? index;
  final data;
  final double? padding;
  final int? childCount;
  final int? elementCrossCount;
  final String? type;
  final categoryModelController = Get.find<ProductCategoryController>();
  var iniCount = Get.find<ProductDetailsController>().prodCount.value = 1;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartControllerFile>(builder: (cartControllerFile) {
      return InkWell(
        onTap: () {
          cartControllerFile.isInCart.value = false;
          if (Get.find<AuthFactorsController>().isLoggedIn.value) {
            cartControllerFile.checkProductInCart(data[index].id);
          }
          // Get.find<ProductCategoryController>()
          //     .fetchProductDetails(data[index].id),
          Get.find<ProductDetailsController>().setProductDetails(data[index]);
          Get.toNamed(RouteHelper.productDetails);
        },
        child: Container(
          height: 150,
          width: 150,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          // height: height * 0.1,
          // width: 117.81,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  // padding: EdgeInsets.all(5),
                  child: CustomImage(
                    image: data[index].imageUrl[0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xFFececec),
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data[index].name,
                        style: smallFontW600(Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      data[index].offerPrice == data[index].price
                          ? const SizedBox()
                          : Row(
                              children: [
                                const Spacer(),
                                Text(
                                    '\u{20B9} ' +
                                        PriceConverter.priceToDecimal(
                                            data[index].price),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        decoration: TextDecoration.lineThrough))
                              ],
                            ),
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                            '\u{20B9} ' +
                                PriceConverter.priceToDecimal(
                                    data[index].offerPrice.toString()),
                            style: defaultFont(
                              color: Colors.black,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10,),
                          GetBuilder<ProductDetailsController>(builder: (productDetailController)
                          {
                            return GestureDetector(
                              onTap:(){
                                if (Get.find<AuthFactorsController>().isLoggedIn.value) {
                                /*  cartControllerFile
                                      .addOrUpdateToCart(
                                      productDetailController.productDetails!.id,
                                      productDetailController.prodCount.value,
                                      'add')
                                      .then((value) => cartControllerFile
                                      .checkProductInCart(
                                      productDetailController
                                          .productDetails!.id
                                  ));
                                  showCustomSnackBar("Added to cart");*/
                                  if (data[index].quantity! >
                                      0) {
                                    if (productDetailController.prodCount <=
                                        (data[index].quantity!)) {
                                      cartControllerFile
                                          .addOrUpdateToCart(
                                          data[index]!.id,
                                          productDetailController.prodCount.value,
                                          'add')
                                          .then((value) => cartControllerFile
                                          .checkProductInCart(data[index].id));
                                      showCustomSnackBar("Added to cart");
                                    } else {
                                      showCustomSnackBar("You have to login first.",
                                          title: 'Warning', isError: true);
                                    }
                                  }

                                }
                                else {
                                  showCustomSnackBar("You have to login first.",
                                      title: 'Warning', isError: true);
                                }
                              },
                              child: Container(
                                height: 22,
                                width: 30,
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: const Icon(Icons.add, color: Colors.white, size: 14,),
                              ),
                            );
                          }
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
