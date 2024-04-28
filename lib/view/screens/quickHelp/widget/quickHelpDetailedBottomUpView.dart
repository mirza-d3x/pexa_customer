import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:shoppe_customer/view/screens/success/success.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

quickHelpDetailsBottomUpView(BuildContext context, int? index, List data,
    ServiceId? quickHelpServiceResultData) {
  Get.find<locationPermissionController>().getUserLocation();

  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * .85,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child:
              GetBuilder<QuickHelpController>(builder: (quickHelpController) {
            return quickHelpController.loaderHelper.isLoading
                ? const LoadingScreen()
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Pexa',
                                    style: verySmallFontW600(Colors.black),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .75,
                                    child: Text(
                                      quickHelpServiceResultData!.name!,
                                      style: const TextStyle(fontSize: 20),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  )
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.clear))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .95,
                        child: Text(
                          'Pexa ${quickHelpServiceResultData.name!.toUpperCase()} consists of the services listed below....',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: smallFontW600(Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ListView.builder(
                              controller: scrollController,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(5)),
                                            color: botAppBarColor),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          data[index],
                                          style: smallFontW600(Colors.black),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.8),
                                blurRadius: 7,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Payment Mode",
                                    style: mediumFont(Colors.black),
                                  ),
                                  SizedBox(
                                    height: 38,
                                    width: 150,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Bouncing(
                                          onPress: () {
                                            quickHelpController
                                                .setPaymentMode(1);
                                          },
                                          child: Container(
                                            height: (quickHelpController
                                                        .paymentIndex.value ==
                                                    1)
                                                ? 37
                                                : 34,
                                            width: 74,
                                            decoration: BoxDecoration(
                                                color: (quickHelpController
                                                            .paymentIndex
                                                            .value ==
                                                        1)
                                                    ? blackPrimary
                                                    : Colors.grey[300],
                                                borderRadius: const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            child: Center(
                                              child: Text('Online',
                                                  style: (quickHelpController
                                                              .paymentIndex
                                                              .value ==
                                                          1)
                                                      ? mediumFont(Colors.white)
                                                      : mediumFont(
                                                          Colors.black)),
                                            ),
                                          ),
                                        ),
                                        Bouncing(
                                          onPress: () {
                                            quickHelpController
                                                .setPaymentMode(2);
                                          },
                                          child: Container(
                                            height: (quickHelpController
                                                        .paymentIndex.value ==
                                                    2)
                                                ? 37
                                                : 34,
                                            width: 74,
                                            decoration: BoxDecoration(
                                              color: (quickHelpController
                                                          .paymentIndex.value ==
                                                      2)
                                                  ? Colors.black
                                                  : Colors.grey[300],
                                              borderRadius: const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(5),
                                                  topRight: Radius.circular(5)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Cash',
                                                style: TextStyle(
                                                    color: (quickHelpController
                                                                .paymentIndex
                                                                .value ==
                                                            2)
                                                        ? Colors.white
                                                        : Colors.black
                                                            .withOpacity(0.5)),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              // height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.amber,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      "Your current location is set by default for the service."),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      GetBuilder<locationPermissionController>(
                                          builder: (currentLocationController) {
                                        if (currentLocationController.place ==
                                            null) {
                                          currentLocationController
                                              .determinePosition();
                                        }
                                        return Text(
                                          '${currentLocationController.place!.subLocality}, ${currentLocationController.place!.locality.toString()}, ${currentLocationController.place!.subAdministrativeArea}, ${currentLocationController.place!.administrativeArea.toString()}',
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w700),
                                        );
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "total",
                                      style: smallFontW600(Colors.black),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                            "₹ ${quickHelpServiceResultData.price.toString()}",
                                            style: largeFont(Colors.black)),
                                        Text(" (inc. tax)",
                                            style: smallFont(Colors.black)),
                                      ],
                                    )
                                  ],
                                ),
                                GetBuilder<locationPermissionController>(
                                    builder: (currentLocationController) {
                                  return GetBuilder<QuickHelpController>(
                                      builder: (quickHelpController) {
                                    return Bouncing(
                                      onPress: () async {
                                        print(quickHelpServiceResultData.id);
                                        if (Get.find<AuthFactorsController>()
                                            .isLoggedIn
                                            .value) {
                                          if (currentLocationController
                                              .currentPosition.isNotEmpty) {
                                            if (!quickHelpController
                                                .loaderHelper.isLoading) {
                                              if (quickHelpController
                                                      .paymentIndex.value ==
                                                  2) {
                                                quickHelpController
                                                    .quickHelpBuyNow(
                                                        quickHelpServiceResultData
                                                            .id,
                                                        currentLocationController
                                                            .currentPosition)
                                                    .then((value) => (value)
                                                        ? {
                                                            Get.back(),
                                                            Get.to(() =>
                                                                const SuccessPage())
                                                          }
                                                        : {
                                                            showCustomSnackBar(
                                                                "Sorry... Currently no workers available",
                                                                title:
                                                                    "Warning",
                                                                isError: true)
                                                          });
                                              } else {
                                                Get.back();
                                                Get.find<
                                                        ServiceCheckOutController>()
                                                    .setServiceId(
                                                        quickHelpServiceResultData
                                                            .id!);
                                                Get.toNamed(
                                                    RouteHelper
                                                        .quickHelpPayments,
                                                    arguments: {
                                                      'id':
                                                          quickHelpServiceResultData
                                                              .id,
                                                    });
                                              }
                                            }
                                          } else {
                                            currentLocationController
                                                .determinePosition();
                                            Get.back();
                                          }
                                        } else {
                                          showCustomSnackBar(
                                              'Please Login to Continue...!',
                                              title: 'Failed',
                                              isError: true);
                                          Get.back();
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(7)),
                                          color: botAppBarColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Place Order',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                }),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  );
          }),
        );
      });
}
