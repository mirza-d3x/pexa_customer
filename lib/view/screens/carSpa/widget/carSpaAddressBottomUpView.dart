import 'dart:developer';

import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/screens/address_edit/addressDetailsPage.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget carSpaAddressBottomUpView(
    {BuildContext? context,
    ServiceId? carSpaServiceResultData,
    required bool isForCheckout}) {
  final addressController = Get.find<AddressControllerFile>();
  final checkOutController = Get.find<ServiceCheckOutController>();
  final carSpaController = Get.find<CarSpaController>();
  final carSpaTimeSlotController = Get.find<CarSpaTimeSlotController>();
  return Container(
      // height: Get.height * 0.30,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      // Get.find<locationPermissionController>()
                      //     .determinePosition();
                      // Get.find<SearchLocationController>().resetSearch();
                      Get.toNamed(RouteHelper.locationSearch, arguments: {
                        'page': Get.currentRoute,
                        'isForAddress': false
                      });
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 18,
                            color: Colors.yellow[600],
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                              child: Row(
                            children: [
                              GetBuilder<locationPermissionController>(
                                  builder: (currentLocationController) {
                                return currentLocationController
                                        .userLocationString
                                        .toString()
                                        .contains(',')
                                    ? Text(
                                        ('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}')
                                                    .length >
                                                20
                                            ? '${('${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}').substring(0, 19)}...'
                                            : currentLocationController
                                                            .userLocationString!
                                                            .split(',')[0] ==
                                                        '' &&
                                                    currentLocationController
                                                        .userLocationString!
                                                        .split(',')
                                                        .isEmpty
                                                ? 'Unknown Place'
                                                : '${currentLocationController.userLocationString!.split(',')[0]},${currentLocationController.userLocationString!.split(',')[1]}',
                                        style: smallFont(Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    : Text(
                                        currentLocationController
                                                    .userLocationString
                                                    .toString()
                                                    .length >
                                                20
                                            ? currentLocationController
                                                .userLocationString
                                                .toString()
                                                .substring(0, 10)
                                            : currentLocationController
                                                .userLocationString
                                                .toString(),
                                        style: smallFont(Colors.black),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      );
                              }),
                              const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 20,
                              )
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                isForCheckout
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
                          Navigator.pop(context!);
                          addressController.fromPexaShoppe.value = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddressDetailsPage(
                                      backContext: context,
                                    )),
                          );
                          // Get.to(() => AddressDetailsPage(backContext: context,));
                        },
                        child: IntrinsicWidth(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(4)),
                                border: Border.all(color: Colors.yellow)
                                /* boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],*/
                                ),
                            child: Center(
                              child: Text(
                                'Change',
                                style: mediumFont(Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          /*isForCheckout
              ? Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'Selected Address',
                        style: mediumFont(Colors.black),
                      ),
                    ),
                  ],
                )
              : Bouncing(
                  onPress: () {
                    Navigator.pop(context!);
                    addressController.fromPexaShoppe.value = false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddressDetailsPage(
                                backContext: context,
                              )),
                    );
                    // Get.to(() => AddressDetailsPage(backContext: context,));
                  },
                  child: IntrinsicWidth(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.yellow)
                       */ /* boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],*/ /*
                      ),
                      child: Center(
                        child: Text(
                          'Change',
                          style: mediumFont(Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),*/
          const SizedBox(
            height: 20,
          ),
          addressController.addressList!.isEmpty
              ? SizedBox(
                  height: 80,
                  child: Center(
                    child: (addressController.isNoAddress.value)
                        ? Text(
                            'No Saved Address',
                            style: mediumFont(Colors.black),
                          )
                        : SizedBox(
                            height: 35,
                            width: 35,
                            child:
                                Image.asset(Images.spinner, fit: BoxFit.fill)),
                  ),
                )
              : addressController.defaultAddress != null
                  ? Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                addressController.defaultAddress!.name!,
                                style: mediumFont(Colors.black),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.1, horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child: Text(
                                      addressController.defaultAddress!.type!,
                                      style: mediumFont(Colors.black))),
                            ],
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                              '${addressController.defaultAddress!.house!}, ${addressController.defaultAddress!.street!}, ${addressController.defaultAddress!.pincode}',
                              style: smallFont(Colors.black)),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            addressController.defaultAddress!.mobile.toString(),
                            style: smallFontW600(Colors.black),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 80,
                      child: Center(
                        child: Text('No address is set as default',
                            style: mediumFont(Colors.black)),
                      ),
                    ),
          const SizedBox(
            height: 20,
          ),
          Bouncing(
            onPress: addressController.addressList!.isEmpty
                ? null
                : () {
                    try {
                      if (isForCheckout) {
                        if (Get.find<CouponController>().isApplied.value) {
                          Map<String, dynamic> data = {
                            "id": checkOutController.serviceId.value,
                            "coordinate": [
                              addressController.defaultAddress!.location![1],
                              addressController.defaultAddress!.location![0]
                            ],
                            "timeSlot": checkOutController.timeSlot.value,
                            "addOns": carSpaController.carSpaAddOns,
                            "date": Get.find<CarSpaTimeSlotController>()
                                .dateShow
                                .toString(),
                            "couponCode":
                                Get.find<CouponController>().couponName.value
                          };
                          print(data);
                          carSpaTimeSlotController.paymentIndex.value == 1
                              ? Get.toNamed(RouteHelper.carSpaPayment,
                                  arguments: data)
                              : checkOutController
                                  .placeOrder(data, MainCategory.CARSPA)
                                  .then((value) =>
                                      Get.to(() => const SuccessPage()));
                        } else if (Get.find<CarSpaController>()
                            .offerApplicable
                            .value) {
                          Map<String, dynamic> data = {
                            "id": checkOutController.serviceId.value,
                            "coordinate": [
                              addressController.defaultAddress!.location![1],
                              addressController.defaultAddress!.location![0]
                            ],
                            "timeSlot": checkOutController.timeSlot.value,
                            "addOns": carSpaController.carSpaAddOns,
                            "date": Get.find<CarSpaTimeSlotController>()
                                .dateShow
                                .toString(),
                            "offerId":
                                Get.find<CarSpaController>().offerCouponId.value
                          };
                          print(data);

                          carSpaTimeSlotController.paymentIndex.value == 1
                              ? Get.toNamed(RouteHelper.carSpaPayment)
                              : checkOutController
                                  .placeOrder(data, MainCategory.CARSPA)
                                  .then((value) =>
                                      Get.to(() => const SuccessPage()));
                        } else {
                          Map<String, dynamic> data = {
                            "id": checkOutController.serviceId.value,
                            "coordinate": [
                              addressController.defaultAddress!.location![1],
                              addressController.defaultAddress!.location![0]
                            ],
                            "timeSlot": checkOutController.timeSlot.value,
                            "addOns": carSpaController.carSpaAddOns,
                            "date": Get.find<CarSpaTimeSlotController>()
                                .dateShow
                                .toString()
                          };
                          print(data);
                          carSpaTimeSlotController.paymentIndex.value == 1
                              ? Get.toNamed(RouteHelper.carSpaPayment,
                                  arguments: {'body': data})
                              : checkOutController
                                  .placeOrder(data, MainCategory.CARSPA)
                                  .then((value) =>
                                      Get.to(() => const SuccessPage()));
                        }
                      } else {
                        Get.find<CouponController>().clearValue();
                        carSpaController.clearOffer();

                        Get.find<CarSpaTimeSlotController>()
                            .initialLoad(carSpaServiceResultData!.id);

                        Get.find<ServiceCheckOutController>()
                            .setServiceId(carSpaServiceResultData.id!);
                        Get.back();
                        Get.toNamed(RouteHelper.carSpaTimeSlotPage, arguments: {
                          'carSpaServiceResultData': carSpaServiceResultData,
                        });
                      }
                    } catch (error, stackTrace) {
                      log("Error", error: error, stackTrace: stackTrace);
                    }
                  },
            child: Container(
              height: 40,
              width: 150,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                color: addressController.addressList!.isEmpty
                    ? Colors.grey[300]
                    : botAppBarColor,
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
                  'Proceed',
                  style: mediumFont(Colors.black),
                ),
              ),
            ),
          )
        ],
      ));
}
