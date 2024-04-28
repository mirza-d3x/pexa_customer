import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/data/models/carShoppe/cartListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class CartProductTile extends StatelessWidget {
  CartProductTile({super.key, this.cartItem, this.index});
  CartItem? cartItem;
  final int? index;

  final cartController = Get.find<CartControllerFile>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().calculatePricePercentage(
          cartController.cartList![index!].product!.price as int,
          cartController.cartList![index!].product!.offerPrice as int);
    });
    return GetBuilder<CartControllerFile>(builder: (cartController) {
      cartItem = cartController.cartList![index!];
      return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  height: 95,
                  width: 95,
                  child: CustomImage(
                      image: cartController.cartList![index!].product!.imageUrl !=
                                  null &&
                              cartController
                                      .cartList![index!].product!.imageUrl!.isNotEmpty
                          ? cartController.cartList![index!].product!.imageUrl![0]
                              .toString()
                          : "",
                      fit: BoxFit.cover),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        child: Text(
                            cartController.cartList![index!].product!.name!
                                .toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: mediumFont(Colors.black)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Price Details',
                        style: smallFontW600(Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price (1 item)',
                            style: smallFont(Colors.black),
                          ),
                          const Spacer(),
                          Text(
                              '₹ ${cartController.cartList![index!].product!.price}',
                              style: smallFontW600(Colors.black))
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discount',
                            style: smallFont(Colors.black),
                          ),
                          const Spacer(),
                          Text(
                              '₹ ${cartController
                                              .cartList![index!].product!.price! -
                                          cartController.cartList![index!]
                                              .product!.offerPrice!}',
                              style: smallFontW600(Colors.black))
                        ],
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Delivery Charge',
                      //       style: smallFont(Colors.black),
                      //     ),
                      //     Spacer(),
                      //     Text('00', style: smallFontW600(Colors.black))
                      //   ],
                      // ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Quantity',
                            style: smallFont(Colors.black),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Bouncing(
                                  onPress: () {
                                    if (cartController.cartList![index!].count! >
                                        1) {
                                      cartController.setQuantity(
                                          count: cartItem!.count! - 1,
                                          index: index!);
                                      cartController
                                          .addOrUpdateToCart(
                                              cartController
                                                  .cartList![index!].product!.id,
                                              cartController
                                                  .cartList![index!].count as int?,
                                              'update')
                                          .then((value) => cartController
                                              .getCartDetails(false));
                                    }
                                  },
                                  child: Text(
                                    '-',
                                    style: mediumFont(Colors.black),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  cartController.cartList![index!].count
                                      .toString(),
                                  style: smallFontW600(Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Bouncing(
                                  onPress: () {
                                    if (cartItem!.count! <
                                        cartItem!.product!.quantity!) {
                                      cartController.setQuantity(
                                          count: cartItem!.count! + 1,
                                          index: index!);
                                      cartController
                                          .addOrUpdateToCart(
                                              cartItem!.product!.id,
                                              cartItem!.count as int?,
                                              'update')
                                          .then((value) => cartController
                                              .getCartDetails(false));
                                    } else {
                                      showCustomSnackBar(
                                          'Quantity should be less than the stock..!',
                                          isError: true,
                                          title: 'Error');
                                    }
                                  },
                                  child: Text(
                                    '+',
                                    style: mediumFont(Colors.black),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total',
                            style: smallFont(Colors.black),
                          ),
                          const Spacer(),
                          Text(
                              '₹ ${cartController.cartList![index!].product!
                                              .offerPrice! *
                                          cartController.cartList![index!].count!}',
                              style: mediumFont(Colors.black))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Bouncing(
              onPress: () {
                cartController
                    .removeProdFromCart(
                        cartController.cartList![index!].product!.id!)
                    .then((value) => cartController.getCartDetails(false).then(
                        (value) => Get.find<ProductDetailsController>()
                            .deletePercentage(index!)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: Colors.grey, width: 1)),
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Text(
                    'Delete',
                    style: mediumFont(Colors.black87),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     padding: EdgeInsets.all(10),
//     margin: EdgeInsets.only(bottom: 5),
//     decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.8),
//             blurRadius: 7,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//         borderRadius: BorderRadius.all(Radius.circular(5))),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//
//         SizedBox(
//           height: 100,
//           width: 100,
//           child: Stack(
//             children: [
//               Center(
//                 child: Container(
//                   clipBehavior: Clip.hardEdge,
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                   ),
//                   height: 95,
//                   width: 95,
//                   child: CustomImage(
//                       image: cartController.cartList[index].product.imageUrl[0].toString(),
//                       fit: BoxFit.cover),
//                 ),
//               ),
//               Positioned(
//                   top: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       cartController
//                           .removeProdFromCart(cartController.cartList[index].product.id)
//                           .then((value) => cartController
//                               .getCartDetails(false)
//                               .then((value) =>
//                                   Get.find<ProductDetailsController>()
//                                       .deletePercentage(index)));
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.all(Radius.circular(5))),
//                       height: 25,
//                       width: 25,
//                       child: Center(
//                         child: Icon(
//                           Icons.delete,
//                           color: Colors.red[900],
//                           size: 20,
//                         ),
//                       ),
//                     ),
//                   ))
//             ],
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: SizedBox(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(left: 5),
//                   child: SizedBox(
//                     height: 100,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 20,
//                         ),
//                         SizedBox(
//                           width: 120,
//                           child: Text(
//                               cartController.cartList[index].product.name.toUpperCase(),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: false,
//                               style: mediumFont(Colors.black)),
//                         ),
//                         SizedBox(
//                           height: 2.5,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                                 '₹ ' +
//                                     cartController.cartList[index].product.price.toString(),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: verySmallFontwithLine(Colors.grey)),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Text(
//                               '₹ ' +
//                                   cartController.cartList[index].product.offerPrice
//                                       .toString(),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: smallFontW600(Colors.black),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Obx(
//                               () => Text(
//                                 '(${Get.find<ProductDetailsController>().pricePercentage[index]}% off)',
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: smallFontW600(Colors.green),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 35,
//                   width: 35,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(5)),
//                       border: Border.all(color: Colors.grey)),
//                   child: Center(
//                     child: DropdownButton(
//                       hint: Text("1"),
//                       value: prodQty,
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                           decoration: TextDecoration.none),
//                       icon: SizedBox(),
//                       items:
//                           ['1', '2', '3', '4', '5', '6'].map((String items) {
//                         return DropdownMenuItem(
//                           value: items,
//                           child: Text(items),
//                         );
//                       }).toList(),
//                       onChanged: (String newValue) {
//                         setState(() {
//                           if (int.parse(newValue) >
//                               cartController.cartList[index].product.quantity) {
//                             Get.snackbar('Error',
//                                 'Quantity should be less than the stock..!',
//                                 snackPosition: SnackPosition.TOP,
//                                 duration: Duration(seconds: 2),
//                                 backgroundColor: Colors.red,
//                                 colorText: Colors.black,
//                                 snackStyle: SnackStyle.FLOATING);
//                             return;
//                           } else {
//                             prodQty = newValue;
//                           }
//                           cartController
//                               .addOrUpdateToCart(cartController.cartList[index].product.id,
//                                   int.parse(prodQty), 'update')
//                               .then((value) =>
//                                   cartController.getCartDetails(false));
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//       ],
//     ),
//   );
// }
}
