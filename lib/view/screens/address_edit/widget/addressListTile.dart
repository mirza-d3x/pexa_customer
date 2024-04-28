import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile(
      {super.key, this.addressListResultData, this.index, this.backContext});
  final Address? addressListResultData;
  final int? index;
  final BuildContext? backContext;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressControllerFile>(builder: (addressController) {
      return Container(
        width: MediaQuery.of(context).size.width,
        //padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(5)),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     blurRadius: 1,
          //     offset: Offset(4, 4), // changes position of shadow
          //   ),
          // ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .50,
                    child: Text(
                      addressListResultData!.name!,
                      style: largeFont(Colors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: (addressListResultData!.isDefault != null &&
                                  addressListResultData!.isDefault!)
                              ? defaultButton()
                              : setDefaultButton(addressController)),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
            //  SizedBox(
            //   height:10,
            // ),
            // SizedBox(
            //   width: 10,
            // ),
            // Container(
            //     padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(0.5),
            //             blurRadius: 7,
            //             offset: Offset(0, 3), // changes position of shadow
            //           ),
            //         ],
            //         borderRadius: BorderRadius.all(Radius.circular(5))),
            //     child: Text(addressListResultData.type,
            //       style: mediumFont(Colors.black),)),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .65,
              child: Text(
                '${addressListResultData!.house!}, ${addressListResultData!.street!}, ${addressListResultData!.pincode}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: mediumFont(Colors.black),
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            Text(
              addressListResultData!.mobile.toString(),
              style: mediumFont(Colors.black),
            ),
            const SizedBox(
              height: 2.5,
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      addressController.setForEdit(addressListResultData!);
                      Get.toNamed(RouteHelper.addressViewPage, arguments: {
                        'backContext': backContext,
                        'isEdit': true,
                        'index': index
                      });
                      // Get.toNamed(RouteHelper.addressEditPage,
                      //     arguments: {'backContext': backContext});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     blurRadius: 7,
                          //     offset: Offset(
                          //         0, 3), // changes position of shadow
                          //   ),
                          // ],
                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.blue[900],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Edit Address',
                            style: mediumFont(Colors.blue[900]),
                          )
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Container(
                  //   width: MediaQuery
                  //       .of(context).size.width,
                  //   height: 1,
                  //   color: Colors.grey[300],
                  // ),
                  // Divider(
                  //   color: Colors.black,
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      (addressListResultData!.isDefault != null &&
                              addressListResultData!.isDefault!)
                          ? showCustomSnackBar(
                              'Default address can not be deleted!',
                              title: 'Error',
                              isError: true)
                          : addressController
                              .deleteAddress(addressListResultData!.id!);
                    },
                    child: Container(
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.5),
                            //     blurRadius: 7,
                            //     offset: Offset(
                            //         0, 3), // changes position of shadow
                            //   ),
                            // ],
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              size: 15,
                              color: Colors.red[900],
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('Delete', style: mediumFont(Colors.red[900]))
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget setDefaultButton(AddressControllerFile addressController) {
    return Bouncing(
      onPress: () {
        print(addressListResultData!.id);
        if (addressController.loaderHelper.value.isLoading == false) {
          addressController
              .setDefaultAddress(addressListResultData!.id!)
              .then((value) => addressController.getAddress());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
          child: Text(
            'Set Default',
            style: mediumFont(Colors.black),
          ),
        ),
      ),
    );
  }

  Container defaultButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 2.5),
        width: 100,
        decoration: BoxDecoration(
            color: botAppBarColor,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     blurRadius: 7,
            //     offset: Offset(
            //         0, 3), // changes position of shadow
            //   ),
            // ],
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Center(
            child: Text(
          'Default',
          style: mediumFont(Colors.black),
        )));
  }
}
