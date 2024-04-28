import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';

class AddressEditPage extends StatelessWidget {
  AddressEditPage({super.key, this.backContext, this.isEdit, this.index});
  final BuildContext? backContext;
  bool? isEdit;
  int? index;

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(title: 'Address'),
            body:
                GetBuilder<AddressControllerFile>(builder: (addressController) {
              return SingleChildScrollView(
                child: Form(
                  key: addressController.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(isEdit! ? 'Edit Address' : 'Add Address',
                            style: defaultFont(
                                color: Colors.black,
                                size: 30,
                                weight: FontWeight.bold)),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[300]),
                          child: Center(
                            child: DropdownButton(
                              value: addressController.type,
                              style: mediumFont(Colors.black),
                              icon: const Icon(Icons.arrow_drop_down),
                              items:
                                  ['Home', 'Work', 'Other'].map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                addressController.setAddressType(newValue);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          // height: 40,
                          padding: const EdgeInsets.symmetric(vertical: .05),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: addressController.nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name(Required)*',
                              contentPadding: EdgeInsets.all(10),
                              focusColor: Colors.black38,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.black38,
                              )),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                width: 1,
                                color: Colors.black38,
                              )),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          // height: 40,
                          padding: const EdgeInsets.symmetric(vertical: .05),
                          child: TextFormField(
                            controller: addressController.numberController,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: const InputDecoration(
                              labelText: 'Phone(Required)*',
                              contentPadding: EdgeInsets.all(10),
                              focusColor: Colors.black38,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length != 10) {
                                return 'Please enter a valid Number';
                              }
                              return null;
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        GestureDetector(
                          onTap: () {
                            addressController
                                .setIsAltered(!addressController.isAlter);
                          },
                          child: Text(
                            "+ Add Alternative Number",
                            style: smallFontW600(Colors.blue[900]),
                          ),
                        ),
                        addressController.isAlter
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox(),
                        addressController.isAlter
                            ? Container(
                                // height: 40,
                                padding: const EdgeInsets.symmetric(vertical: .05),
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  controller:
                                      addressController.altNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Alternative Number',
                                    contentPadding: EdgeInsets.all(10),
                                    focusColor: Colors.black38,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black38)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black38)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          // height: 40,
                          padding: const EdgeInsets.symmetric(vertical: .05),
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            controller: addressController.houseController,
                            decoration: const InputDecoration(
                              labelText: 'House No/Build No(Required)*',
                              contentPadding: EdgeInsets.all(10),
                              focusColor: Colors.black38,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the House No/Build No';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 7,
                                child: InkWell(
                                  onTap: () {
                                    // Get.find<locationPermissionController>()
                                    //     .determinePosition();
                                    // Get.find<SearchLocationController>()
                                    //     .resetSearch();
                                    Get.toNamed(RouteHelper.locationSearch,
                                        arguments: {
                                          'page': Get.currentRoute,
                                          'isForAddress': true
                                        });
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: .05),
                                    child: TextFormField(
                                      enabled: false,
                                      controller:
                                          addressController.streetController,
                                      decoration: const InputDecoration(
                                        labelText: 'Street Address(Required)*',
                                        contentPadding: EdgeInsets.all(10),
                                        focusColor: Colors.black38,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38)),
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your Street Address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Visibility(
                          visible: false,
                          child: Row(children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                // height: 40,
                                padding: const EdgeInsets.symmetric(vertical: .05),
                                child: TextFormField(
                                  controller:
                                      addressController.pinCodeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Pincode(Required)*',
                                    contentPadding: EdgeInsets.all(10),
                                    focusColor: Colors.black38,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black38)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.black38)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1)),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the Pincode';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ]),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Visibility(
                          visible: false,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // height: 40,
                                  padding: const EdgeInsets.symmetric(vertical: .05),
                                  child: TextFormField(
                                    controller:
                                        addressController.stateController,
                                    decoration: const InputDecoration(
                                      labelText: 'State(Required)*',
                                      contentPadding: EdgeInsets.all(10),
                                      focusColor: Colors.black38,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black38)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.black38)),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the State';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 5,
                              // ),
                              Visibility(
                                visible: false,
                                child: Expanded(
                                  flex: 2,
                                  child: Container(
                                    // height: 40,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: .05),
                                    child: TextFormField(
                                      controller:
                                          addressController.cityController,
                                      decoration: const InputDecoration(
                                        labelText: 'City(Required)*',
                                        contentPadding: EdgeInsets.all(10),
                                        focusColor: Colors.black38,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter the City';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          // height: 40,
                          padding: const EdgeInsets.symmetric(vertical: .05),
                          width: Get.width,
                          child: TextFormField(
                            controller: addressController.landMarkController,
                            decoration: const InputDecoration(
                              labelText: 'Landmark',
                              contentPadding: EdgeInsets.all(10),
                              focusColor: Colors.black38,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black38)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        addressController.loaderHelper.value.isLoading
                            ? Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5)),
                                    color: Theme.of(context).primaryColor),
                                child: Center(
                                  child: LoadingAnimationWidget.twistingDots(
                                    leftDotColor: const Color(0xFF4B4B4D),
                                    rightDotColor: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )
                            : CustomButton(
                                onPressed: () async {
                                  if (addressController.formKey.currentState!
                                      .validate()) {
                                    if (addressController
                                            .loaderHelper.value.isLoading ==
                                        false) {
                                      if (isEdit!) {
                                        addressController
                                            .editAddress(addressController
                                                .addressList![index!].id)
                                            .then((value) => goBack(context)
                                                .then((value) =>
                                                    addressController
                                                        .getAddress()));
                                      } else {
                                        addressController.addAdress().then(
                                            (value) => value
                                                ? {
                                                    goBack(context).then(
                                                        (value) =>
                                                            addressController
                                                                .getAddress())
                                                  }
                                                : null);
                                      }
                                    }
                                  }
                                },
                                buttonText: 'SAVE',
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300]!,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  )
                                ],
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                'Cancel',
                                style: mediumFont(Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
