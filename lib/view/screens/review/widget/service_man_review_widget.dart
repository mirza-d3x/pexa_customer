import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/rating_controller.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';
import 'package:shoppe_customer/data/models/worker_details/worker_details_model.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/my_text_field.dart';
import 'package:shoppe_customer/view/base/rating_bar.dart';
import 'package:shoppe_customer/view/screens/happy_code_screen/happy_code_widget.dart';

class ServiceManReviewWidget extends StatelessWidget {
  final WorkerDetails? deliveryMan;
  final bool isCompleted;
  final ServiceOrderModel? orderDetails;
  final MainCategory? category;
  const ServiceManReviewWidget(
      {super.key, required this.deliveryMan,
      required this.isCompleted,
      required this.orderDetails,
      required this.category});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: SizedBox(
          width: Dimensions.WEB_MAX_WIDTH,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            isCompleted &&
                    (orderDetails!.status == 'Completed' ||
                        orderDetails!.status == 'In_Progress')
                ? GetBuilder<RatingController>(builder: (ratingController) {
                    return Container(
                      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            orderDetails!.happyCode != null
                                ? HappyCodeWidget(
                                    happyCode: orderDetails!.happyCode)
                                : const SizedBox(),
                            Text(
                              'Rate the service',
                              style: robotoRegular.copyWith(
                                  // color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeLarge),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                            orderDetails!.feedBack == null ||
                                    orderDetails!.feedBack == Feedback
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                          itemCount: 5,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, i) {
                                            return InkWell(
                                              child: Icon(
                                                ratingController.count < (i + 1)
                                                    ? Icons.star_border
                                                    : Icons.star,
                                                size: 30,
                                                color: ratingController.count <
                                                        (i + 1)
                                                    ? Theme.of(context)
                                                        .disabledColor
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              ),
                                              onTap: () {
                                                ratingController
                                                    .updateCount(i + 1);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_LARGE),

                                      // Text(
                                      //   'Share your opinion',
                                      //   style: robotoRegular.copyWith(
                                      //       fontSize: Dimensions.fontSizeLarge),
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                      MyTextField(
                                        maxLines: 5,
                                        capitalization:
                                            TextCapitalization.sentences,
                                        controller: ratingController
                                            .reviewDescriptionController,
                                        hintText: 'Write your opinion here',
                                        fillColor: Theme.of(context)
                                            .disabledColor
                                            .withOpacity(0.2),
                                      ),
                                      const SizedBox(height: 40),

                                      // Submit button
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.PADDING_SIZE_LARGE),
                                        child: Column(
                                          children: [
                                            !ratingController
                                                    .loaderHelper.isLoading
                                                ? CustomButton(
                                                    buttonText: 'Submit',
                                                    onPressed: () {
                                                      ratingController
                                                          .updateReview(
                                                              category:
                                                                  category,
                                                              orderId:
                                                                  orderDetails!
                                                                      .id)
                                                          .then((value) {
                                                        if (value) {
                                                          showCustomSnackBar(
                                                              'Thank you for helping with your valuable review.',
                                                              isError: false);
                                                        }
                                                      });
                                                    },
                                                  )
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          'You have rated the service with : ',
                                          style: smallFont(
                                              Theme.of(context).hintColor),
                                        ),
                                        RatingBar(
                                          rating: double.parse(
                                              orderDetails!.feedBack != null
                                                  ? (orderDetails!
                                                              .feedBack!.rating ?? 0)
                                                      .toString()
                                                  : "0"),
                                          size: 15,
                                          ratingCount: null,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                    ),
                                    Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).disabledColor,
                                          ),
                                          color:
                                              Theme.of(context).colorScheme.background,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Text(
                                        orderDetails!.feedBack != null
                                            ? orderDetails!
                                                        .feedBack!.description !=
                                                    null
                                                ? orderDetails!
                                                    .feedBack!.description!
                                                : ""
                                            : "",
                                        style: smallFont(Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL,
                                    )
                                  ]),
                          ]),
                    );
                  })
                : const SizedBox(),
          ]),
        ),
      ),
    ));
  }
}
