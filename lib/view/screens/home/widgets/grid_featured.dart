import 'dart:async';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class FeaturedTile extends StatelessWidget {
  FeaturedTile({super.key, this.index, this.type});
  final int? index;
  final categoryModelController = Get.find<ProductCategoryController>();
  final String? type;
  static bool check = true;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // print(categoryResultData.productId.id);
        // print('*********');
        Get
            .find<CartControllerFile>()
            .isInCart
            .value = false;

        // Get.find<CartControllerFile>().checkProductInCart(type == "feature"
        //     ? categoryModelController.featured.resultData[index].id
        //     : categoryModelController.offered.resultData[index].id);
        // Get.find<ProductCategoryController>().fetchProductDetails(
        //     type == "feature"
        //         ? categoryModelController.featured.resultData[index].id
        //         : categoryModelController.offered.resultData[index].id)
        if (type == "feature") {
          if (Get
              .find<AuthFactorsController>()
              .isLoggedIn
              .value) {
            Get.find<CartControllerFile>().checkProductInCart(
                categoryModelController
                    .featured!.resultData![index!].productId!.id);
          }
          Get.find<ProductDetailsController>().setProductDetails(
              categoryModelController.featured!.resultData![index!].productId);
        } else {
          if (Get
              .find<AuthFactorsController>()
              .isLoggedIn
              .value) {
            Get.find<CartControllerFile>().checkProductInCart(
                categoryModelController
                    .offered!.resultData![index!].productId!.id);
          }
          Get.find<ProductDetailsController>().setProductDetails(
              categoryModelController.offered!.resultData![index!].productId);
        }
        Get.toNamed(RouteHelper.productDetails);
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: CustomImage(
                      // height: height * 0.128,
                      image: type == "feature"
                          ? categoryModelController.featured!
                          .resultData![index!].productId!.imageUrl![0]
                          : categoryModelController.offered!.resultData![index!]
                          .productId!.imageUrl![0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(

                    alignment: Alignment.center,
                    // height: height * 0.0507,
                    // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        type == "feature"
                            ? categoryModelController
                            .featured!.resultData![index!].productId!.name!
                            : categoryModelController
                            .offered!.resultData![index!].productId!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: defaultFont(
                          color: Colors.black,
                          size: 13,
                          weight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
              ],
            ),
          ),
          type == 'feature'
              ? const SizedBox()
              : Positioned(
            top: 5,
            right: -3,
            child: Container(
              color: Colors.yellow,
              /*  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/carSpa/offer_bg.png'),
                            fit: BoxFit.fill)
                        // color: botAppBarColor,
                        // borderRadius: BorderRadius.only(
                        //   bottomRight: Radius.circular(15),
                        // ),
                        ),*/
              padding:
              const EdgeInsets.only(top: 2, left: 6, right: 8, bottom: 2),
              child: Center(
                child: Text(
                  '${((categoryModelController.offered!.resultData![index!]
                      .productId!.price! -
                      categoryModelController
                          .offered!
                          .resultData![index!]
                          .productId!
                          .offerPrice!) *
                      100 /
                      categoryModelController.offered!
                          .resultData![index!].productId!.price!)
                      .toStringAsFixed(0)}% off',
                  style: defaultFont(
                    color: Colors.black,
                    size: 8,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(

            bottom: 0,
            right: 0,
            child:

            GetBuilder<CartControllerFile>(builder: (cartControllerFile)
                {
                 return GestureDetector(
                   onTap:(){
                     if (Get.find<AuthFactorsController>().isLoggedIn.value) {
                       cartControllerFile
                           .addOrUpdateToCart(
                           type == 'offered'?
                           categoryModelController.offered!
                               .resultData![index!].productId!.id
                               :  categoryModelController.featured!
                               .resultData![index!].productId!.id,
                          1,
                           'add')
                           .then((value) => cartControllerFile
                           .checkProductInCart(
                           type == 'offered'?
                           categoryModelController.featured!
                               .resultData![index!].productId!.id
                               :  categoryModelController.offered!
                               .resultData![index!].productId!.id,
                          ));
                       showCustomSnackBar("Added to cart");

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
             ),
          )
        ],
      ),
    );
  }
 cartButton(ProductDetailsController productDetailController) {
    return Container(
      child: GetBuilder<CartControllerFile>(builder: (cartControllerFile) {
        return SizedBox(
          height: 22,
          width: 30,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom
              (backgroundColor: Colors.blue,
                shape: const RoundedRectangleBorder(
                borderRadius:BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)))),
              onPressed:() {
          if (Get.find<AuthFactorsController>().isLoggedIn.value) {
          if (cartControllerFile.isInCart.value) {
            cartControllerFile.getCartDetails(true).then(
                    (value) => Get.toNamed(RouteHelper.cart, arguments: {
                  'fromNav': true,
                  'fromMain': false,
                  'prodId':
                  productDetailController.productDetails!.id,
                }));
          } else {
            if (productDetailController.productDetails!.quantity! >
                0) {
              if (productDetailController.prodCount <=
                  (productDetailController.productDetails!.quantity!)) {
                cartControllerFile
                    .addOrUpdateToCart(
                    productDetailController.productDetails!.id,
                    productDetailController.prodCount.value,
                    'add')
                    .then((value) => cartControllerFile
                    .checkProductInCart(productDetailController
                    .productDetails!.id));
              } else {
                SmartDialog.showToast(
                  'Not much stock available, please reduce the quantity',
                );
              }
            } else {
              if (check) {
                check = false;
                SmartDialog.showToast(
                  'Out of Stock',
                );
                Timer(const Duration(seconds: 2), () async {
                  check = true;
                });
              }
            }
          }
          } else {
          showCustomSnackBar("You have to login first.",
              title: 'Warning', isError: true);
          }
        },child:
          cartControllerFile.isInCart.value
          ?const Icon(Icons.add,color: Colors.white,size: 10,)
              :const Icon(Icons.remove,size: 10,color: Colors.white,)
          ),
        );
      }),
    );
  }
}



