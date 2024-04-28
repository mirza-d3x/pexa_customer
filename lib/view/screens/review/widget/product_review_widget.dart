// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shoppe_customer/helper/price_converter.dart';
// import 'package:shoppe_customer/models/review_body.dart';
// import 'package:shoppe_customer/models/service_ordder_model.dart';
// import 'package:shoppe_customer/util/dimensions.dart';
// import 'package:shoppe_customer/util/styles.dart';
// import 'package:shoppe_customer/view/base/custom_button.dart';
// import 'package:shoppe_customer/view/base/custom_image.dart';
// import 'package:shoppe_customer/view/base/custom_snackbar.dart';
// import 'package:shoppe_customer/view/base/my_text_field.dart';

// class ProductReviewWidget extends StatefulWidget {
//   final List<ServiceOrderModel> orderDetailsList;
//   ProductReviewWidget({@required this.orderDetailsList});

//   @override
//   State<ProductReviewWidget> createState() => _ProductReviewWidgetState();
// }

// class _ProductReviewWidgetState extends State<ProductReviewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProductController>(builder: (productController) {
//       return Scrollbar(child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Center(child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: ListView.builder(
//           itemCount: widget.orderDetailsList.length,
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//           itemBuilder: (context, index) {
//             return Container(
//               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
//               margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
//               decoration: BoxDecoration(
//                 boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 1))],
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
//               ),
//               child: Column(children: [

//                 // Product details
//                 Row(
//                   children: [
//                     (widget.orderDetailsList[index].serviceId.thumbUrl[0] != null && widget.orderDetailsList[index].serviceId.thumbUrl[0].isNotEmpty) ?
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                       child: CustomImage(
//                         height: 70, width: 85, fit: BoxFit.cover,
//                         image: '${widget.orderDetailsList[index].}',
//                       ),
//                     ) : SizedBox(),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

//                     Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(widget.orderDetailsList[index].serviceId.name, style: robotoMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
//                         SizedBox(height: 10),

//                         Text(PriceConverter.convertPrice(widget.orderDetailsList[index].grandTotal), style: robotoBold),
//                       ],
//                     )),
//                     Row(children: [
//                       Text(
//                         '${'quantity'.tr}: ',
//                         style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         widget.orderDetailsList[index].addOn.length.toString(),
//                         style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ]),
//                   ],
//                 ),
//                 Divider(height: 20),

//                 // Rate
//                 Text(
//                   'rate_the_food'.tr,
//                   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

//                 SizedBox(
//                   height: 30,
//                   child: ListView.builder(
//                     itemCount: 5,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, i) {
//                       return InkWell(
//                         child: Icon(
//                           productController.ratingList[index] < (i + 1) ? Icons.star_border : Icons.star,
//                           size: 25,
//                           color: productController.ratingList[index] < (i + 1) ? Theme.of(context).disabledColor
//                               : Theme.of(context).primaryColor,
//                         ),
//                         onTap: () {
//                           if(!productController.submitList[index]) {
//                             productController.setRating(index, i + 1);
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//                 Text(
//                   'share_your_opinion'.tr,
//                   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
//                 MyTextField(
//                   maxLines: 3,
//                   capitalization: TextCapitalization.sentences,
//                   isEnabled: !productController.submitList[index],
//                   hintText: 'write_your_review_here'.tr,
//                   fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
//                   onChanged: (text) => productController.setReview(index, text),
//                 ),
//                 SizedBox(height: 20),

//                 // Submit button
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
//                   child: !productController.loadingList[index] ? CustomButton(
//                     buttonText: productController.submitList[index] ? 'submitted'.tr : 'submit'.tr,
//                     onPressed: productController.submitList[index] ? null : () {
//                       if(!productController.submitList[index]) {
//                         if (productController.ratingList[index] == 0) {
//                           showCustomSnackBar('give_a_rating'.tr);
//                         } else if (productController.reviewList[index].isEmpty) {
//                           showCustomSnackBar('write_a_review'.tr);
//                         } else {
//                           FocusScopeNode currentFocus = FocusScope.of(context);
//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }
//                           ReviewBody reviewBody = ReviewBody(
//                             productId: widget.orderDetailsList[index].id.toString(),
//                             rating: productController.ratingList[index].toString(),
//                             comment: productController.reviewList[index],
//                             orderId: widget.orderDetailsList[index].orderId.toString(),
//                           );
//                           productController.submitReview(index, reviewBody).then((value) {
//                             if (value.isSuccess) {
//                               showCustomSnackBar(value.message, isError: false);
//                               productController.setReview(index, '');
//                             } else {
//                               showCustomSnackBar(value.message);
//                             }
//                           });
//                         }
//                       }
//                     },
//                   ) : Center(child: CircularProgressIndicator()),
//                 ),

//               ]),
//             );
//           },
//         ))),
//       ));
//     });
//   }
// }
