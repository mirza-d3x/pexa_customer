import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/applyOfferMechanical.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanical_payment_chooser_widget.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalBottomAppBarRow2.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalShowDate.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalTimeSlotTile.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalTimeSlotScreen extends StatelessWidget {
  MechanicalTimeSlotScreen({super.key, this.mechanicalServiceResultData});
  final checkOutController = Get.find<ServiceCheckOutController>();
  final ServiceId? mechanicalServiceResultData;

  @override
  Widget build(BuildContext context) {
    // if (Get.find<CurrentLocationController>().currentPosition.isEmpty) {
    //   Get.find<CurrentLocationController>().getUserLocation().then((value) =>
    //       mechanicalTimeSlotController
    //           .initialLoad(mechanicalServiceResultData.id));
    // } else {
    //   mechanicalTimeSlotController.initialLoad(mechanicalServiceResultData.id);
    // }
    // checkOutController.serviceId.value = mechanicalServiceResultData.id;
    return Get.find<ConnectivityController>().status
        ? Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: const CustomAppBar(
              title: "Order Details",
              // backgroundColor: Theme.of(context).backgroundColor,
            ),
            body: GetBuilder<MechanicalTimeSlotController>(
                builder: (mechanicalTimeSlotController) {
              return GetBuilder<MechanicalController>(
                  builder: (mechanicalController) {
                return GetBuilder<CouponController>(
                    builder: (couponController) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Service Date',
                            style: mediumFont(Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Bouncing(
                            onPress: () {
                              mechanicalTimeSlotController.changeDate(
                                  context, mechanicalServiceResultData);
                            },
                            child: const MechanicalShowDate(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Service Slots',
                            style: mediumFont(Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          mechanicalTimeSlotController.isLoad.value
                              ? SizedBox(
                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Checking available time slots..."),
                                      Center(
                                        child: SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Image.asset(Images.spinner,
                                                fit: BoxFit.fill)),
                                      ),
                                    ],
                                  ),
                                )
                              : mechanicalController
                                          .mechanicalTimeSlot.isEmpty &&
                                      mechanicalTimeSlotController
                                          .dateLoad.value
                                  ? SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: Text(
                                          "Time Slots are not available..!",
                                          style: mediumFont(Colors.red),
                                        ),
                                      ),
                                    )
                                  : GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: mechanicalTimeSlotController
                                          .timeList.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 4,
                                              childAspectRatio: 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MechanicalTimeSlotTile(
                                          index: index,
                                        );
                                      }),
                          const SizedBox(
                            height: 20,
                          ),
                          ApplyMechanicalOffer(
                            mechanicalServiceResultData:
                                mechanicalServiceResultData,
                          ),
                          couponController.isApplied.value
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (couponController.couponName.value),
                                          style: mediumFont(Colors.black),
                                        ),
                                        Text(
                                          ' coupon is applied..!',
                                          style: smallFontW600(Colors.green),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Bouncing(
                                            onPress: () {
                                              couponController.clearValue();
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red[900],
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        'saved ${couponController.discount} INR',
                                        style: smallFontW600(Colors.black))
                                  ],
                                )
                              : const SizedBox(),
                          couponController.showDetails.value
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'this Coupon will be applicable only for the minimum purchase '
                                      'amount of ${couponController.minAmount.value}',
                                      style: verySmallFontW600(Colors.red),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                )
                              : const SizedBox(),
                          mechanicalController.offerApplicable.value
                              ? SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Offer Applied',
                                              style:
                                                  smallFontW600(Colors.green)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Bouncing(
                                              onPress: () {
                                                mechanicalController
                                                    .clearOffer();
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red[900],
                                                size: 20,
                                              ))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          'saved ${mechanicalController.discount} INR',
                                          style: smallFontW600(Colors.black))
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
                });
              });
            }),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: Theme.of(context).colorScheme.background,
              child: GetBuilder<CouponController>(builder: (couponController) {
                return Container(
                  height: couponController.isApplied.value
                      ? 110
                      : Get.find<MechanicalController>().offerApplicable.value
                          ? 120
                          : 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MechanicalPaymentChooserWidget(),
                      MechanicalBottomAppBarRow2()
                    ],
                  ),
                );
              }),
            ))
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
