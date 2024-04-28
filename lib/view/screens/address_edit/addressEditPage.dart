import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class AddressEditView extends StatefulWidget {
  const AddressEditView({super.key, this.addressListResultData, this.backContext});
  final Address? addressListResultData;
  final BuildContext? backContext;

  @override
  _AddressEditViewState createState() => _AddressEditViewState();
}

class _AddressEditViewState extends State<AddressEditView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController altNumberController = TextEditingController();
  String? type = '';
  String mark = "";
  List location = [];
  bool isAlter = false;
  final _formKey = GlobalKey<FormState>();
  final addressController = Get.find<AddressControllerFile>();

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      nameController.text = widget.addressListResultData!.name.toString();
      numberController.text = widget.addressListResultData!.mobile.toString();
      houseController.text = widget.addressListResultData!.house.toString();
      streetController.text = widget.addressListResultData!.street.toString();
      cityController.text = widget.addressListResultData!.city.toString();
      stateController.text = widget.addressListResultData!.state.toString();
      pinCodeController.text = widget.addressListResultData!.pincode.toString();
      type = widget.addressListResultData!.type.toString();
      altNumberController.text =
          widget.addressListResultData!.altPhone.toString() ?? '';
      landMarkController.text =
          widget.addressListResultData!.landmark.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: Colors.white,
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   elevation: 0,
            //   leading: IconButton(
            //     icon: const Icon(
            //       Icons.arrow_back_ios,
            //       color: Colors.black,
            //       size: 15,
            //     ),
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //   ),
            // ),
            appBar: const CustomAppBar(title: 'Address'),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Edit Address',
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
                            border: Border.all(color: Colors.black),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                            color: Colors.grey[300]),
                        child: Center(
                          child: DropdownButton(
                            value: type,
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
                              setState(() {
                                type = newValue;
                              });
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
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Name(Required)*',
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
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Number(Required)*',
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
                              return 'Please enter the Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAlter = !isAlter;
                          });
                        },
                        child: Text(
                          "+ Add Alternative Number",
                          style: smallFontW600(Colors.blue[900]),
                        ),
                      ),
                      isAlter
                          ? const SizedBox(
                              height: 10,
                            )
                          : const SizedBox(),
                      isAlter
                          ? Container(
                              // height: 40,
                              padding: const EdgeInsets.symmetric(vertical: .05),
                              width: MediaQuery.of(context).size.width,
                              child: TextFormField(
                                controller: altNumberController,
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
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              // height: 40,
                              padding: const EdgeInsets.symmetric(vertical: .05),
                              child: TextFormField(
                                controller: pinCodeController,
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
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () async {
                                var position = await GeolocatorPlatform.instance
                                    .getCurrentPosition();
                                List<Placemark> placemarks =
                                    await placemarkFromCoordinates(
                                        position.latitude, position.longitude);
                                Placemark place = placemarks[0];
                                setState(() {
                                  pinCodeController.text =
                                      place.postalCode.toString();
                                  stateController.text =
                                      place.administrativeArea.toString();
                                  cityController.text =
                                      place.locality.toString();
                                  streetController.text =
                                      '${place.subLocality}, ${place.locality.toString()}, ${place.subAdministrativeArea}, ${place.administrativeArea.toString()}';
                                });
                                                            },
                              child: Container(
                                // height: 40,
                                padding: const EdgeInsets.symmetric(vertical: 2.5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5)),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    color: Colors.white
                                    //color: Colors.black38.withOpacity(0.7)),
                                    ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.black,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 2.5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Use Current',
                                            style: smallFontW600(Colors.black),
                                          ),
                                          Text(
                                            'Location',
                                            style: smallFontW600(Colors.black),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(vertical: .05),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: houseController,
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
                      Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(vertical: .05),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: streetController,
                          decoration: const InputDecoration(
                            labelText: 'Street Address(Required)*',
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
                              return 'Please enter the Street address';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              // height: 40,
                              padding: const EdgeInsets.symmetric(vertical: .05),
                              child: TextFormField(
                                controller: stateController,
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
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              // height: 40,
                              padding: const EdgeInsets.symmetric(vertical: .05),
                              child: TextFormField(
                                controller: cityController,
                                decoration: const InputDecoration(
                                  labelText: 'City(Required)*',
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
                                    return 'Please enter the City';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        // height: 40,
                        padding: const EdgeInsets.symmetric(vertical: .05),
                        width: MediaQuery.of(context).size.width,
                        child: TextFormField(
                          controller: landMarkController,
                          decoration: const InputDecoration(
                            labelText: 'Landmark',
                            hintText: 'Landmark',
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
                      Obx(
                        () => Bouncing(
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              if (addressController
                                      .loaderHelper.value.isLoading ==
                                  false) {
                                addressController.loaderHelper.value
                                    .startLoader();
                                if (nameController.text.toString().length >
                                    20) {
                                  showCustomSnackBar(
                                      'Name must not more than 20 characters...',
                                      isError: true);
                                  return;
                                }
                                if (numberController.text.toString().length !=
                                    10) {
                                  showCustomSnackBar(
                                      'Enter the 10 Digits Valid Number...',
                                      isError: true);
                                  return;
                                }
                                List<Location> locations =
                                    await locationFromAddress(
                                        streetController.text.toString());
                                if (locations.isEmpty) {
                                  print('no  location');
                                } else {
                                  Map<String, dynamic> body = {};
                                  if (landMarkController.text.trim() == '') {
                                    mark = ' ';
                                  } else {
                                    mark = landMarkController.text.toString();
                                  }
                                  if (altNumberController.text.trim() == '' ||
                                      altNumberController.text.trim() ==
                                          'null') {
                                    body = {
                                      "name": nameController.text.toString(),
                                      "mobile": int.parse(
                                          numberController.text.toString()),
                                      "house": houseController.text.toString(),
                                      "street":
                                          streetController.text.toString(),
                                      "city": cityController.text.toString(),
                                      "state": stateController.text.toString(),
                                      "pincode": int.parse(
                                          pinCodeController.text.toString()),
                                      "type": type,
                                      "location": [
                                        locations[0].latitude,
                                        locations[0].longitude
                                      ],
                                      "landmark": mark
                                    };
                                  } else {
                                    body = {
                                      "name": nameController.text.toString(),
                                      "mobile": int.parse(
                                          numberController.text.toString()),
                                      "altPhone": int.parse(
                                          altNumberController.text.toString()),
                                      "house": houseController.text.toString(),
                                      "street":
                                          streetController.text.toString(),
                                      "city": cityController.text.toString(),
                                      "state": stateController.text.toString(),
                                      "pincode": int.parse(
                                          pinCodeController.text.toString()),
                                      "type": type,
                                      "location": [
                                        locations[0].latitude,
                                        locations[0].longitude
                                      ],
                                      "landmark": mark
                                    };
                                  }
                                  addressController
                                      .editAddress(
                                          widget.addressListResultData!.id)
                                      .then((value) => goBack(context).then(
                                          (value) =>
                                              addressController.getAddress()));
                                }
                              }
                            }
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
                                color: Theme.of(context).primaryColor),
                            child: Center(
                              child:
                                  addressController.loaderHelper.value.isLoading
                                      ? LoadingAnimationWidget.twistingDots(
                                          leftDotColor: const Color(0xFF4B4B4D),
                                          rightDotColor: Colors.white,
                                          size: 20,
                                        )
                                      : Text(
                                          'SAVE',
                                          style: mediumFont(Colors.black),
                                        ),
                            ),
                          ),
                        ),
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
            ),
          )
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
