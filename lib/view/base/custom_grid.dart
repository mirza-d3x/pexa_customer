import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/helper/fonts.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView(
      {super.key,
      this.padding,
      this.childCount,
      this.elementCrossCount,
      this.data});
  final double? padding;
  final int? childCount;
  final int? elementCrossCount;
  final data;
  var height = 0.0;
  var width = 0.0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          padding == 0
              ? SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
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
                      height: height * 0.3,
                      width: ResponsiveHelper.isDesktop(context)
                          ? Get.width / 6
                          : Get.width,
                    );
                  }, childCount: childCount),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: ResponsiveHelper.isDesktop(context)
                        ? Get.width / 6
                        : Get.width / elementCrossCount!,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.all(padding!),
                  sliver: GetBuilder<CartControllerFile>(
                      builder: (cartControllerFile) {
                    return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return productTile(
                              cartControllerFile, index, context);
                        }, childCount: childCount),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent:
                              ResponsiveHelper.isDesktop(context)
                                  ? Get.width / 6
                                  : Get.width / elementCrossCount!,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                          childAspectRatio: 1,
                        ));
                  }),
                ),
        ]);
  }

  Widget productTile(
      CartControllerFile cartControllerFile, int index, BuildContext context) {
    print("Pixel width :  ${MediaQuery.of(context).size.width *
                MediaQuery.of(context).devicePixelRatio},  Pixel height : ${MediaQuery.of(context).size.height *
                MediaQuery.of(context).devicePixelRatio}");
    return InkWell(
      onTap: () {
        cartControllerFile.isInCart.value = false;
        cartControllerFile.checkProductInCart(data[index].id);
        // Get.find<ProductCategoryController>()
        //     .fetchProductDetails(data[index].id),
        Get.find<ProductDetailsController>().setProductDetails(data[index]);
        Get.toNamed(RouteHelper.productDetails);
      },
      child: Container(
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
                        // data[index].offerPrice ==
                        //         data[index].price
                        //     ? SizedBox()
                        //     : Text(
                        //         '\u{20B9} ' +
                        //             priceToDecimal(
                        //                 data[index].price),
                        //         style: TextStyle(
                        //             fontSize: 14,
                        //             decoration:
                        //                 TextDecoration
                        //                     .lineThrough)),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        Text(
                          '\u{20B9} ' +
                              PriceConverter.priceToDecimal(
                                  data[index].offerPrice.toString()),
                          style: defaultFont(
                            color: Colors.black,
                            size: 18,
                            weight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        // child: Column(
        //   children: [
        //     Expanded(
        //         flex: 3,
        //         child: Container(
        //             child: CustomImage(
        //           image: data[index].imageUrl[0],
        //           fit: BoxFit.contain,
        //         ))),
        //     Expanded(
        //         flex: 2,
        //         child: Container(
        //           color: Colors.grey.withOpacity(0.2),
        //           width: double.infinity,
        //           padding: EdgeInsets.symmetric(
        //               horizontal: 10),
        //           child: Stack(
        //             children: [
        //               Text(
        //                 data[index].name,
        //                 style: smallFont(Colors.black),
        //                 maxLines: 2,
        //                 overflow: TextOverflow.ellipsis,
        //                 textAlign: TextAlign.center,
        //               ),
        //               Positioned(
        //                 right: 0,
        //                 bottom: 0,
        //                 child: Column(
        //                   crossAxisAlignment:
        //                       CrossAxisAlignment.end,
        //                   children: [
        //                     data[index].offerPrice ==
        //                             data[index].price
        //                         ? Container()
        //                         : Row(
        //                             mainAxisAlignment:
        //                                 MainAxisAlignment
        //                                     .end,
        //                             crossAxisAlignment:
        //                                 CrossAxisAlignment
        //                                     .end,
        //                             children: [
        //                               Text(
        //                                   '\u{20B9} ' +
        //                                       priceToDecimal(
        //                                           data[index]
        //                                               .price),
        //                                   style: TextStyle(
        //                                       fontSize:
        //                                           14,
        //                                       decoration:
        //                                           TextDecoration
        //                                               .lineThrough)),
        //                             ],
        //                           ),
        //                     Row(
        //                       mainAxisAlignment:
        //                           MainAxisAlignment.end,
        //                       crossAxisAlignment:
        //                           CrossAxisAlignment.end,
        //                       children: [
        //                         Text(
        //                           '\u{20B9} ' +
        //                               priceToDecimal(data[
        //                                       index]
        //                                   .offerPrice
        //                                   .toString()),
        //                           style: defaultFont(
        //                             color: Colors.black,
        //                             size: 18,
        //                             weight:
        //                                 FontWeight.bold,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ],
        //           ),
        //         )),
        //   ],
        // )
      ),
    );
  }
}
//   productdetails(context, index) {
//     Get.find<ProductDetailsController>().prodCount.value = 1;
//     AlertDialog alert = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(20)),
//       ),
//       //title: Text("Coming soon"),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               //height: Get.height*0.8,
//               width: Get.width * 0.9,
//               child: Column(
//                 children: [
//                   Container(
//                       height: 200,
//                       width: 200,
//                       clipBehavior: Clip.hardEdge,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: CustomImage(
//                         image: data[index].imageUrl[0],
//                         fit: BoxFit.cover,
//                       )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     data[index].name,
//                     style: defaultFont(
//                       color: Colors.black,
//                       size: 20,
//                       weight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Details : '),
//                       Container(
//                           width: Get.width * 0.5,
//                           height: 90,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 ReadMoreText(
//                                   data[index].description,
//                                   trimMode: TrimMode.Line,
//                                   trimCollapsedText: 'Show more',
//                                   trimExpandedText: 'Show less',
//                                   // maxLines: 5,
//                                   // overflow: TextOverflow.ellipsis,
//                                   trimLines: 5,
//                                   style: defaultFont(
//                                     color: Colors.black,
//                                     size: 15,
//                                     weight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text('Quantity : '),
//                       Row(
//                         children: [
//                           TextButton(
//                               onPressed: () {
//                                 Get.find<ProductDetailsController>()
//                                     .subtractProductCount();
//                               },
//                               child: Text(
//                                 '-',
//                                 style: defaultFont(
//                                   color: Colors.black,
//                                   size: 20,
//                                   weight: FontWeight.w400,
//                                 ),
//                               )),
//                           Container(
//                               height: 30,
//                               width: 30,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black.withOpacity(0.3),
//                                   width: 1,
//                                 ),
//                               ),
//                               //width: Get.width*0.5,
//                               child: Obx(
//                                 () => Text(
//                                   Get.find<ProductDetailsController>()
//                                       .prodCount
//                                       .toString(),
//                                   style: defaultFont(
//                                     color: Colors.black,
//                                     size: 15,
//                                     weight: FontWeight.w400,
//                                   ),
//                                 ),
//                               )),
//                           TextButton(
//                               onPressed: () {
//                                 Get.find<ProductDetailsController>()
//                                     .addProductCount();
//                               },
//                               child: Text(
//                                 '+',
//                                 style: defaultFont(
//                                   color: Colors.black,
//                                   size: 20,
//                                   weight: FontWeight.w400,
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           '₹ ' + data[index].price.toString() + '.00',
//                           style: GoogleFonts.nunito(
//                             color: Colors.black,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w300,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                         Text(
//                           '₹ ' + data[index].offerPrice.toString() + '.00',
//                           style: defaultFont(
//                             color: Colors.black,
//                             size: 20,
//                             weight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ]),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   InkWell(
//                     onTap: Get.find<ProductDetailsController>().isInCart.value
//                         ? () {
//                             Navigator.of(context, rootNavigator: true)
//                                 .pop('dialog');
//                             Get.find<CartControllerFile>()
//                                 .getCartDetails(true)
//                                 .then((value) => Get.to(() => CartScreen(
//                                       fromNav: false,
//                                       fromMain: true,
//                                       prodId: data[index].id,
//                                     )));
//                           }
//                         : () {
//                             if (data[index].quantity > 0) {
//                               if (Get.find<ProductDetailsController>()
//                                       .prodCount
//                                       .value <=
//                                   data[index].quantity) {
//                                 Navigator.of(context, rootNavigator: true)
//                                     .pop('dialog');
//                                 Get.find<CartControllerFile>()
//                                     .addOrUpdateToCart(
//                                         data[index].id,
//                                         Get.find<ProductDetailsController>()
//                                             .prodCount
//                                             .value,
//                                         'add');
//                               } else {
//                                 Navigator.of(context, rootNavigator: true)
//                                     .pop('dialog');
//                                 Get.snackbar('Warning',
//                                     'Quantity must be less than the Stock...!',
//                                     snackPosition: SnackPosition.TOP,
//                                     duration: Duration(milliseconds: 1000),
//                                     backgroundColor: Colors.red,
//                                     colorText: Colors.white,
//                                     snackStyle: SnackStyle.FLOATING);
//                               }
//                             } else {
//                               Navigator.of(context, rootNavigator: true)
//                                   .pop('dialog');
//                               Get.snackbar('Warning', 'No Stock...!',
//                                   snackPosition: SnackPosition.TOP,
//                                   duration: Duration(milliseconds: 1000),
//                                   backgroundColor: Colors.red,
//                                   colorText: Colors.white,
//                                   snackStyle: SnackStyle.FLOATING);
//                             }
//                           },
//                     child: Container(
//                         height: 50,
//                         width: Get.width * 0.9,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         alignment: Alignment.center,
//                         child: Obx(
//                           () => Text(
//                             Get.find<ProductDetailsController>().isInCart.value
//                                 ? 'Go to Cart'
//                                 : 'Add to Cart',
//                             style: defaultFont(
//                               color: Colors.white,
//                               size: 20,
//                               weight: FontWeight.w500,
//                             ),
//                           ),
//                         )),
//                   ),
//                   SizedBox(height: 20),
//                   InkWell(
//                     onTap: () {
//                       Navigator.of(context, rootNavigator: true).pop('dialog');
//                       Get.to(() => ShoppeCheckout(), arguments: {
//                         'product': data[index],
//                         'quantity':
//                             Get.find<ProductDetailsController>().prodCount.value
//                       });
//                     },
//                     child: Container(
//                         height: 50,
//                         width: Get.width * 0.9,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Theme.of(context).secondaryHeaderColor,
//                         ),
//                         alignment: Alignment.center,
//                         child: Text(
//                           'Buy Now',
//                           style: defaultFont(
//                             color: Theme.of(context).primaryColor,
//                             size: 20,
//                             weight: FontWeight.w500,
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // actions: [
//       //your actions (I.E. a button)
//       // ],
//     );
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }
