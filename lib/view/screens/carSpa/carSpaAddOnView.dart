import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/carSpa/widget/carSpaAddressBottomUpView.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaServiceAddOnView extends StatelessWidget {
  CarSpaServiceAddOnView({super.key, required this.carSpaServiceResultData});
  final carModelController = Get.find<CarModelController>();
  final ServiceId? carSpaServiceResultData;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // craSpaController.carSpaAddOns.clear();
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
            body: GetBuilder<CarSpaController>(builder: (craSpaController) {
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
                              image: carSpaServiceResultData!.imageUrl![0],
                              fit: BoxFit.fitWidth,
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
                              Text(
                                '${carModelController.carBrandName!} ${carModelController.carModelName!}',
                                style: verySmallFontW600(Colors.grey),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .70,
                                child: Text(
                                  carSpaServiceResultData!.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: smallFontW600(Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .60,
                                child: Text(
                                  carSpaServiceResultData!.list!,
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
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
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
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Select the service you wish to add with your package',
                                style: verySmallFont(Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                           /* SizedBox(
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
                                  SizedBox(
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
                                        style: verySmallFont(Colors.grey),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),*/
                            Expanded(
                                child: carSpaServiceResultData!.addOns!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: carSpaServiceResultData!
                                            .addOns!.length,
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
                                                  craSpaController
                                                          .carSpaAddOnRadioState[
                                                      index] = !craSpaController
                                                          .carSpaAddOnRadioState[
                                                      index];
                                                  craSpaController.changeTotal(
                                                      craSpaController
                                                              .carSpaAddOnRadioState[
                                                          index],
                                                      carSpaServiceResultData!
                                                          .addOns![index].price as int?);
                                                  craSpaController.addOnADDorRemove(
                                                      craSpaController
                                                              .carSpaAddOnRadioState[
                                                          index],
                                                      {
                                                        "name":
                                                            carSpaServiceResultData!
                                                                .addOns![index]
                                                                .name,
                                                        "price":
                                                            carSpaServiceResultData!
                                                                .addOns![index]
                                                                .price,
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
                                                                          .grey[
                                                                      600]!),
                                                              borderRadius: const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              color: craSpaController
                                                                          .carSpaAddOnRadioState[
                                                                      index]
                                                                  ? Colors.black
                                                                      .withOpacity(
                                                                          0.7)
                                                                  : Colors
                                                                      .white),
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
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
                                                      carSpaServiceResultData!
                                                          .addOns![index].name!,
                                                      style: smallFont(
                                                          Colors.black),
                                                    )),
                                                    Text(
                                                        '₹ ${carSpaServiceResultData!
                                                                .addOns![index]
                                                                .price}',
                                                        style: smallFontW600(
                                                            Colors.black))
                                                  ],
                                                ),
                                              )
                                            ],
                                          );
                                        })
                                    : Center(
                                        child: Text(
                                          "No addons added..!",
                                          style: mediumFont(Colors.black),
                                        ),
                                      )),
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
            bottomNavigationBar:
                GetBuilder<CarSpaController>(builder: (carSpaController) {
              return BottomAppBar(
                elevation: 0,
                color: Theme.of(context).colorScheme.background,
                child: Container(
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
                                    "₹ ${carSpaController.carSpaAddOnTotal.toString()}",
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
                          GetBuilder<AddressControllerFile>(
                              builder: (addressController) {
                            return Bouncing(
                              onPress: () async {
                                if (Get.find<AuthFactorsController>()
                                    .isLoggedIn
                                    .value) {
                                  addressController.getAddress().then((value) {
                                    if (addressController
                                        .addressList!.isNotEmpty) {
                                      addressController
                                          .getDefaultAddress()
                                          .then((value) {
                                        if (!Get.isBottomSheetOpen!) {
                                          Get.bottomSheet(
                                              carSpaAddressBottomUpView(
                                                  context: context,
                                                  carSpaServiceResultData:
                                                      carSpaServiceResultData,
                                                  isForCheckout: false),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                              ));
                                        }
                                      });
                                    } else {
                                      if (!Get.isBottomSheetOpen!) {
                                        Get.bottomSheet(
                                            carSpaAddressBottomUpView(
                                                context: context,
                                                carSpaServiceResultData:
                                                    carSpaServiceResultData,
                                                isForCheckout: false));
                                      }
                                    }
                                  });
                                } else {
                                  showCustomSnackBar(
                                      'Please Login to Continue...!',
                                      title: 'Failed',
                                      isError: true);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(20)),
                                  color: botAppBarColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
