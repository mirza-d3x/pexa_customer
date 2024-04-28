import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';

Widget addressWidget(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ]),
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipment Address',
            style: defaultFont(
              color: Colors.black,
              size: 20,
              weight: FontWeight.w400,
            )),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
        ),
        GetBuilder<AddressControllerFile>(builder: (addressController) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: true,
                activeColor: Theme.of(context).secondaryHeaderColor,
                groupValue: true,
                onChanged: (dynamic value) {},
              ),
              addressController.addressList == null
                  ? SizedBox(
                      height: 80,
                      child: Center(
                        child: (addressController.isNoAddress.value)
                            ? Text(
                                'No Saved Address',
                                style: mediumFont(Colors.black),
                              )
                            : LoadingAnimationWidget.twistingDots(
                                leftDotColor: const Color(0xFF4B4B4D),
                                rightDotColor: const Color(0xFFf7d417),
                                size: 50,
                              ),
                      ),
                    )
                  : Container(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Colors.white,
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.grey
                        //         .withOpacity(0.5),
                        //     blurRadius: 7,
                        //     offset: Offset(0,
                        //         3), // changes position of shadow
                        //   ),
                        // ],
                      ),
                      child: addressController.defaultAddress != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(addressController.defaultAddress!.name!,
                                        style: defaultFont(
                                          color: Colors.black,
                                          size: 18,
                                          weight: FontWeight.w400,
                                        )),
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
                                            addressController
                                                .defaultAddress!.type!,
                                            style: mediumFont(
                                              Colors.black,
                                            ))),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2.5,
                                ),
                                Text(
                                    '${addressController.defaultAddress!.house!}, ${addressController
                                            .defaultAddress!.street!}, ${addressController.defaultAddress!.pincode}',
                                    style: defaultFont(
                                      color: Colors.black,
                                      size: 16,
                                      weight: FontWeight.w400,
                                    )),
                                const SizedBox(
                                  height: 2.5,
                                ),
                                Text(
                                  addressController.defaultAddress!.mobile
                                      .toString(),
                                  style: defaultFont(
                                    color: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 80,
                              child: Center(
                                child: Text('No address is set as default',
                                    style: mediumFont(Colors.black)),
                              ),
                            ),
                    ),
            ],
          );
        }),
        const Divider(
          color: Colors.black26,
          thickness: 1,
        ),
        InkWell(
          onTap: () {
            //_onAlertButtonPressed1(context);
            Get.toNamed(RouteHelper.addressDetailsPage,
                arguments: {'context': context});
          },
          child: Container(
            child: Container(
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(color: Colors.black38, width: 1),
                ),
                alignment: Alignment.center,
                child: const Text('Edit Address')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.addressDetailsPage,
                arguments: {'context': context});
          },
          child: Container(
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.black38, width: 1),
              ),
              alignment: Alignment.center,
              child: const Text('Add New Address')),
        ),
      ],
    ),
  );
}
