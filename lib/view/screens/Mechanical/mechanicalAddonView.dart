import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalAddressBottomUpView.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalServiceAddOnView extends StatelessWidget {
  const MechanicalServiceAddOnView({super.key, required this.serviceDetails});
  // final carModelController = Get.find<CarModelController>();
  // final mechanicalTimeSlotController = Get.find<MechanicalTimeSlotController>();
  // final checkOutController = Get.find<ServiceCheckOutController>();
  final ServiceId? serviceDetails;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<MechanicalController>().mechanicalAddOns.clear();
    //   if (Get.find<locationPermissionController>().locationEnabled.value !=
    //           true ||
    //       Get.find<locationPermissionController>().permissionData.value !=
    //           true) {
    //     Get.find<locationPermissionController>().checkLocationStatus();
    //   }
    // });

    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            appBar: const CustomAppBar(
              title: "Add Services",
              // backgroundColor: Theme.of(context).backgroundColor,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: GetBuilder<MechanicalController>(
                builder: (mechanicalController) {
              return Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CustomImage(
                              image: serviceDetails!.imageUrl![0],
                              radius: 7,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetBuilder<CarModelController>(
                                  builder: (carModelController) {
                                return Text(
                                  '${carModelController.carBrandName!} ${carModelController.carModelName!}',
                                  style: verySmallFontW600(Colors.grey),
                                );
                              }),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .70,
                                child: Text(
                                  serviceDetails!.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: smallFontW600(Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .60,
                                child: Text(
                                  serviceDetails!.list!,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: verySmallFont(Colors.grey),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(7)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 7,
                              offset:
                                  const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                        child: Image.asset(
                                      'assets/carSpa/addmore.png',
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ADD MORE SERVICES',
                                        style: mediumFont(Colors.black),
                                      ),
                                      Text(
                                          'Select the service you\nwish to add with your package',
                                          style: verySmallFont(Colors.grey))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: serviceDetails!.addOns!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Divider(
                                          color: Colors.grey[300],
                                          thickness: 1,
                                        ),
                                        InkWell(
                                          splashColor: Colors.yellow,
                                          onTap: () {
                                            mechanicalController
                                                    .mechanicalAddOnRadioState[
                                                index] = !mechanicalController
                                                    .mechanicalAddOnRadioState[
                                                index];
                                            mechanicalController.changeTotal(
                                                mechanicalController
                                                        .mechanicalAddOnRadioState[
                                                    index],
                                                serviceDetails!
                                                    .addOns![index].price as int?);
                                            mechanicalController.addOnADDorRemove(
                                                mechanicalController
                                                        .mechanicalAddOnRadioState[
                                                    index],
                                                {
                                                  "name": serviceDetails!
                                                      .addOns![index].name,
                                                  "price": serviceDetails!
                                                      .addOns![index].price,
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 30,
                                                width: 30,
                                                child: Center(
                                                  child: Container(
                                                    height: 17,
                                                    width: 17,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[600]!),
                                                        borderRadius:
                                                            const BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                        color: mechanicalController
                                                                    .mechanicalAddOnRadioState[
                                                                index]
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.7)
                                                            : Colors.white),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                serviceDetails!
                                                    .addOns![index].name!,
                                                style: smallFont(Colors.black),
                                              )),
                                              Text(
                                                '₹ ${serviceDetails!
                                                        .addOns![index].price}',
                                                style:
                                                    smallFontW600(Colors.black),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              );
            }),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).colorScheme.background,
              elevation: 0,
              child: GetBuilder<MechanicalController>(
                  builder: (mechanicalController) {
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                    "₹ ${mechanicalController.mechanicalAddOnTotal.toString()}",
                                    style: largeFont(Colors.black),
                                  ),
                                  Text(
                                    " (inc. tax)",
                                    style: smallFont(Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          GetBuilder<locationPermissionController>(
                              builder: (currentLocationController) {
                            return GetBuilder<MechanicalTimeSlotController>(
                                builder: (mechanicalTimeSlotController) {
                              return GetBuilder<ServiceCheckOutController>(
                                  builder: (checkOutController) {
                                return Bouncing(
                                  onPress: () async {
                                    if (Get.find<AuthFactorsController>()
                                        .isLoggedIn
                                        .value) {
                                      if (!Get.isBottomSheetOpen!) {
                                        Get.find<ServiceCheckOutController>()
                                            .setServiceId(serviceDetails!.id!);
                                        Get.bottomSheet(
                                            mechanicalAddressBottomUpView(
                                                context: context,
                                                mechanicalServiceResultData:
                                                    serviceDetails,
                                                isForCheckout: false),
                                            isScrollControlled: true);
                                      }
                                    } else {
                                      showCustomSnackBar(
                                          'Please Login to Continue...!',
                                          title: 'Failed',
                                          isError: true);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(7)),
                                      color: botAppBarColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 7,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            });
                          })
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
