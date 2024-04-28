import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/images.dart';

Widget mechanicalAddressBottomUpView(
    {BuildContext? context,
    ServiceId? mechanicalServiceResultData,
    bool? isForCheckout}) {
  return DraggableScrollableSheet(
      initialChildSize: 0.30,
      maxChildSize: 0.30,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return IntrinsicHeight(
          child: Container(
            // height: MediaQuery.of(context).size.height * .40,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child:
                GetBuilder<AddressControllerFile>(builder: (addressController) {
              if (addressController.addressList!.isEmpty) {
                addressController.getAddress();
              }
              return GetBuilder<ServiceCheckOutController>(
                  builder: (checkOutController) {
                return checkOutController.loaderHelper.isLoading
                    ? SizedBox(
                        height: Get.height * .40,
                        child: const Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          isForCheckout!
                              ? Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        'Selected Address',
                                        style: mediumFont(Colors.black),
                                      ),
                                    ),
                                  ],
                                )
                              : Bouncing(
                                  onPress: () {
                                    Get.back();
                                    addressController
                                        .setFromShoppeStatus(false);
                                    Get.toNamed(RouteHelper.addressDetailsPage,
                                        arguments: {'context': context});
                                  },
                                  child: IntrinsicWidth(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7)),
                                        color: botAppBarColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Add / Change Address',
                                          style: mediumFont(Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          addressController.addressList!.isEmpty
                              ? SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: (addressController.isNoAddress.value)
                                        ? Text('No Saved Address',
                                            style: mediumFont(Colors.black))
                                        : SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(Images.spinner,
                                                fit: BoxFit.fill)),
                                  ),
                                )
                              : addressController.defaultAddress != null
                                  ? Container(
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(7)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
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
                                                style: mediumFont(Colors.black),
                                              ),
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
                                              style: smallFont(Colors.black)),
                                          const SizedBox(
                                            height: 2.5,
                                          ),
                                          Text(
                                            addressController
                                                .defaultAddress!.mobile
                                                .toString(),
                                            style: smallFontW600(Colors.black),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      height: 80,
                                      child: Center(
                                        child: Text(
                                            'No address is set as default',
                                            style: mediumFont(Colors.black)),
                                      ),
                                    ),
                          const SizedBox(
                            height: 20,
                          ),
                          GetBuilder<ServiceCheckOutController>(
                              builder: (checkOutController) {
                            return GetBuilder<MechanicalController>(
                                builder: (mechanicalController) {
                              return GetBuilder<MechanicalTimeSlotController>(
                                  builder: (mechanicalTimeSlotController) {
                                return Bouncing(
                                  onPress: addressController.addressList!.isEmpty
                                      ? null
                                      : () {
                                          if (checkOutController
                                                  .loaderHelper.isLoading ==
                                              false) {
                                            if (isForCheckout) {
                                              if (Get.find<CouponController>()
                                                  .isApplied
                                                  .value) {
                                                Map<String, dynamic> data = {
                                                  "id": checkOutController
                                                      .serviceId.value,
                                                  "coordinate": [
                                                    addressController
                                                        .defaultAddress!
                                                        .location![1],
                                                    addressController
                                                        .defaultAddress!
                                                        .location![0]
                                                  ],
                                                  "timeSlot": checkOutController
                                                      .timeSlot.value,
                                                  "addOns": mechanicalController
                                                      .mechanicalAddOns,
                                                  "date":
                                                      mechanicalTimeSlotController
                                                          .dateShow
                                                          .toString(),
                                                  "couponCode": Get.find<
                                                          CouponController>()
                                                      .couponName
                                                      .value
                                                };
                                                mechanicalTimeSlotController
                                                            .paymentIndex
                                                            .value ==
                                                        1
                                                    ? Get.toNamed(RouteHelper
                                                        .mechanicalPayment)
                                                    : checkOutController
                                                        .placeOrder(
                                                            data,
                                                            MainCategory
                                                                .MECHANICAL)
                                                        .then((value) {
                                                        if (value == true) {
                                                          Get.to(() =>
                                                              const SuccessPage());
                                                        } else {
                                                          showCustomSnackBar(
                                                              "Something went wrong, Order got cancelled!!!");
                                                        }
                                                      });
                                              } else if (mechanicalController
                                                  .offerApplicable.value) {
                                                Map<String, dynamic> data = {
                                                  "id": checkOutController
                                                      .serviceId.value,
                                                  "coordinate": [
                                                    addressController
                                                        .defaultAddress!
                                                        .location![1],
                                                    addressController
                                                        .defaultAddress!
                                                        .location![0]
                                                  ],
                                                  "timeSlot": checkOutController
                                                      .timeSlot.value,
                                                  "addOns": mechanicalController
                                                      .mechanicalAddOns,
                                                  "date":
                                                      mechanicalTimeSlotController
                                                          .dateShow
                                                          .toString(),
                                                  "offerId":
                                                      mechanicalController
                                                          .offerCouponId.value
                                                };
                                                print(data);
                                                mechanicalTimeSlotController
                                                            .paymentIndex
                                                            .value ==
                                                        1
                                                    ? Get.toNamed(RouteHelper
                                                        .mechanicalPayment)
                                                    : checkOutController
                                                        .placeOrder(
                                                            data,
                                                            MainCategory
                                                                .MECHANICAL)
                                                        .then((value) {
                                                        if (value == true) {
                                                          Get.to(() =>
                                                              const SuccessPage());
                                                        }
                                                      });
                                              } else {
                                                Map<String, dynamic> data = {
                                                  "id": checkOutController
                                                      .serviceId.value,
                                                  "coordinate": [
                                                    addressController
                                                        .defaultAddress!
                                                        .location![1],
                                                    addressController
                                                        .defaultAddress!
                                                        .location![0]
                                                  ],
                                                  "timeSlot": checkOutController
                                                      .timeSlot.value,
                                                  "addOns": mechanicalController
                                                      .mechanicalAddOns,
                                                  "date":
                                                      mechanicalTimeSlotController
                                                          .dateShow
                                                          .toString()
                                                };
                                                mechanicalTimeSlotController
                                                            .paymentIndex
                                                            .value ==
                                                        1
                                                    ? Get.toNamed(
                                                        RouteHelper
                                                            .mechanicalPayment,
                                                        arguments: {
                                                            'body': data
                                                          })
                                                    : checkOutController
                                                        .placeOrder(
                                                            data,
                                                            MainCategory
                                                                .MECHANICAL)
                                                        .then((value) {
                                                        if (value == true) {
                                                          Get.to(() =>
                                                              const SuccessPage());
                                                        }
                                                      });
                                              }
                                            } else {
                                              Get.find<CouponController>()
                                                  .clearValue();
                                              mechanicalController.clearOffer();
                                              checkOutController.setServiceId(
                                                  mechanicalServiceResultData!
                                                      .id!);
                                              mechanicalTimeSlotController
                                                  .initialLoad(
                                                      checkOutController
                                                          .serviceId.value);

                                              Get.back();
                                              Get.toNamed(
                                                  RouteHelper
                                                      .mechanicalTimeSlot,
                                                  arguments: {
                                                    'mechanicalServiceResultData':
                                                        mechanicalServiceResultData,
                                                  });
                                            }
                                          }
                                        },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    margin: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(7)),
                                      color:
                                          addressController.addressList!.isEmpty
                                              ? Colors.grey[300]
                                              : botAppBarColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: checkOutController
                                              .loaderHelper.isLoading
                                          ? LoadingAnimationWidget.twistingDots(
                                              leftDotColor:
                                                  const Color(0xFF4B4B4D),
                                              rightDotColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              size: 30,
                                            )
                                          : Text(
                                              'Proceed',
                                              style: mediumFont(Colors.black),
                                            ),
                                    ),
                                  ),
                                );
                              });
                            });
                          })
                        ],
                      );
              });
            }),
          ),
        );
      });
}
