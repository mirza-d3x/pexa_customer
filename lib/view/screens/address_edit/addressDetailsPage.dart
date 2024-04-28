import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/address_edit/widget/addressListTile.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({super.key, this.backContext});
  final BuildContext? backContext;

  findDefaultAddress() {
    Get.find<AddressControllerFile>().getDefaultAddress();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConnectivityController>(
        builder: (connectivityController) => (connectivityController.status)
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: const CustomAppBar(title: 'Address'),
                body: GetBuilder<AddressControllerFile>(
                    builder: (addressController) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 25),
                    child: Column(
                      children: [
                        Bouncing(
                          onPress: () {
                            addressController.resetAddress();
                            Get.toNamed(RouteHelper.addressViewPage,
                                arguments: {
                                  'backContext': backContext,
                                  'isEdit': false
                                });
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                color: Theme.of(context).cardColor
                                //color: botAppBarColor
                                ),
                            child: Center(
                                child: Text(
                              '+ Add New Address',
                              style: mediumFont(Colors.black),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            addressController.addressList!.isNotEmpty
                                ? Text(
                                    '${addressController.addressList!.length} saved Addresses',
                                    style: mediumFont(Colors.grey),
                                  )
                                : const SizedBox(),
                            addressController.addressList!.isNotEmpty
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Expanded(
                            flex: 1,
                            child: addressController.addressList!.isEmpty
                                ? Center(
                                    child: (addressController.isNoAddress.value)
                                        ? Text(
                                            'No Saved Addressess',
                                            style: mediumFont(Colors.red),
                                          )
                                        : LoadingAnimationWidget.twistingDots(
                                            leftDotColor:
                                                const Color(0xFF4B4B4D),
                                            rightDotColor:
                                                const Color(0xFFf7d417),
                                            size: 50,
                                          ),
                                    // : SizedBox(
                                    // height: 35,
                                    // width: 35,
                                    // child: Image.asset(Images.spinner,
                                    //     fit: BoxFit.fill)),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Colors.white,
                                    child: ListView.separated(
                                      itemCount:
                                          addressController.addressList!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            AddressListTile(
                                              index: index,
                                              addressListResultData:
                                                  addressController
                                                      .addressList![index],
                                              backContext: backContext,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Divider(
                                            color: Colors.black54,
                                          ),
                                        );
                                      },
                                    ),
                                  )),
                      ],
                    ),
                  );
                }),
              )
            : const Scaffold(
                body: NoInternetScreenView(),
              ));
  }
}
