import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/data/repository/addressApi.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class AddressControllerFile extends GetxController implements GetxService {
  final AddressApi addressApi;
  List<Address>? addressList;
  var isNoAddress = false.obs;
  Address? defaultAddress;
  var fromPexaShoppe = false.obs;
  List<double> currentPosition = [];
  var userLocationString = ''.obs;
  String? type = 'Home';
  String? mark = "";
  bool isAlter = false;
  final formKey = GlobalKey<FormState>();
  Placemark? place;

  Rx<LoaderHelper> loaderHelper = LoaderHelper().obs;

  AddressControllerFile({required this.addressApi});

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController altNumberController = TextEditingController();

  setIsAltered(bool isAlt) {
    isAlter = isAlt;
    update();
  }

  setMark(String m) {
    mark = m;
    update();
  }

  setAddressType(String? t) {
    type = t;
    update();
  }

  setFromShoppeStatus(bool v) {
    fromPexaShoppe.value = v;
    update();
  }

  setCurrentPositionData(
      {required List<double> currentPosit,
      required Placemark placemarks,
      required String locationString}) {
    if (currentPosition.isNotEmpty) {
      currentPosition.clear();
    }
    currentPosition.addAll(currentPosit);
    place = placemarks;
    List<String> locList = locationString.split(', ');
    if (locList.length > 3) {
      streetController.text =
          '${locList[0]}, ${locationString.split(', ')[locList.length - 3]}';
    } else {
      streetController.text = locationString;
    }
    if (placemarks.postalCode != null) {
      pinCodeController.text = placemarks.postalCode!;
    }
    if (placemarks.administrativeArea != null) {
      stateController.text = placemarks.administrativeArea!;
    }
    if (placemarks.locality != null) {
      cityController.text = placemarks.locality!;
    }
    update();
  }

  Future getCurrentLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    place = placemarks[0];
  }

  setAddressList(List<Address>? list) {
    addressList = [];
    if (list != null && list.isNotEmpty) {
      addressList!.addAll(list);
      for (var element in addressList!) {
        if (element.isDefault!) {
          defaultAddress = element;
        }
      }
    }
    update();
  }

  Future addAdress() async {
    loaderHelper.value.startLoader();
    update();
    Map<String, dynamic> body = {};
    if (numberController.text.toString().length != 10) {
      showCustomSnackBar('Enter the 10 Digits Valid Number...');
      return;
    }

    if (landMarkController.text.trim() == '') {
      mark = '';
    } else {
      mark = landMarkController.text.toString();
    }

    if (altNumberController.text.trim() == '') {
      body = {
        "name": nameController.text.toString(),
        "mobile": int.parse(numberController.text.trim().toString()),
        "house": houseController.text.toString(),
        "street": streetController.text.toString(),
        "city": cityController.text.toString(),
        "state": stateController.text.toString(),
        "pincode": int.parse(pinCodeController.text.trim().toString()),
        "type": type,
        "location": [currentPosition[0], currentPosition[1]],
        "landmark": mark
      };
    } else {
      body = {
        "name": nameController.text.toString(),
        "mobile": int.parse(numberController.text.trim().toString()),
        "altPhone": int.parse(altNumberController.text.trim().toString()),
        "house": houseController.text.toString(),
        "street": streetController.text.toString(),
        "city": cityController.text.toString(),
        "state": stateController.text.toString(),
        "pincode": int.parse(pinCodeController.text.trim().toString()),
        "type": type,
        "location": [currentPosition[0], currentPosition[1]],
        "landmark": mark
      };
    }
    var res = await addressApi.addAddress(body);
    if (res['status'] == 'OK') {
      // Address addressDetails = Address.fromJson(body);
      showCustomSnackBar(res['message'].toString(),
          title: 'Success', isError: false);

      if (addressList!.isEmpty) {
        setDefaultAddress(res['resultData']['_id'].toString())
            .then((value) => getAddress());
      } else {
        // addressList.add(addressDetails);
        // update();
        getAddress();
      }
      loaderHelper.value.cancelLoader();
      update();
      return true;
    } else {
      loaderHelper.value.cancelLoader();
      update();
      showCustomSnackBar(res['message'].toString(),
          title: 'Error', isError: true);
      return false;
    }
  }

  Future getAddress() async {
    loaderHelper.value.startLoader();
    update();
    if (addressList != null) {
      addressList!.clear();
      update();
    }
    isNoAddress.value = false;
    update();
    Response res = (await addressApi.getAllAdress())!;
    if (res.body != null) {
      addressList = AddressListModel.fromJson(res.body).resultData;
      update();
      if (addressList!.isNotEmpty) {
        isNoAddress.value = false;
        update();
        loaderHelper.value.cancelLoader();
        getDefaultAddress();
        update();
        return true;
      } else {
        loaderHelper.value.cancelLoader();
        isNoAddress.value = true;
        update();
        return false;
      }
    } else {
      isNoAddress.value = true;
      update();
      showCustomSnackBar('Getting address failed.',
          title: 'Error', isError: true);
    }
  }

  deleteAddress(String addressId) async {
    var res = await addressApi.deleteAddress(addressId);
    if (res['status'] == 'OK') {
      showCustomSnackBar(res['message'].toString(),
          title: 'Success', isError: false);
      getAddress();
    }
  }

  Future editAddress(
    String? addressId,
  ) async {
    Map<String, dynamic> body;
    if (numberController.text.toString().length != 10) {
      showCustomSnackBar('Enter the 10 Digits Valid Number...');
      return;
    }

    if (landMarkController.text.trim() == '') {
      mark = '';
    } else {
      mark = landMarkController.text.toString();
    }

    if (altNumberController.text.trim() == '') {
      body = {
        "name": nameController.text.toString(),
        "mobile": int.parse(numberController.text.trim().toString()),
        "house": houseController.text.toString(),
        "street": streetController.text.toString(),
        "city": cityController.text.toString(),
        "state": stateController.text.toString(),
        "pincode": int.parse(pinCodeController.text.trim().toString()),
        "type": type,
        "location": [currentPosition[0], currentPosition[1]],
        "landmark": mark
      };
    } else {
      body = {
        "name": nameController.text.toString(),
        "mobile": int.parse(numberController.text.trim().toString()),
        "altPhone": int.parse(altNumberController.text.trim().toString()),
        "house": houseController.text.toString(),
        "street": streetController.text.toString(),
        "city": cityController.text.toString(),
        "state": stateController.text.toString(),
        "pincode": int.parse(pinCodeController.text.trim().toString()),
        "type": type,
        "location": [currentPosition[0], currentPosition[1]],
        "landmark": mark
      };
    }
    var res = await addressApi.editAddress(addressId!, body);
    if (res['status'] == 'OK') {
      showCustomSnackBar(res['message'].toString(),
          title: 'Success', isError: false);
      getAddress();
    }
  }

  Future setDefaultAddress(String addressId) async {
    loaderHelper.value.startLoader();
    update();
    var response = await addressApi.setDefaultAddress(addressId);
    if (response['status'] == 'OK') {
      if (addressList!.isNotEmpty) {
        for (var element in addressList!) {
          if (element.id == addressId) {
            element.isDefault = true;
            defaultAddress = element;
            update();
          } else {
            element.isDefault = false;
            update();
          }
        }
      }
    }
    loaderHelper.value.cancelLoader();
    update();
  }

  Future getDefaultAddress() async {
    if (defaultAddress != null) {
      defaultAddress = Address();
      update();
    }
    var response = await addressApi.getDefaultAddress();

    if (response != null && response['resultData'] != null) {
      defaultAddress = Address.fromJson(response['resultData']);
      update();
    }
  }

  setForEdit(Address address) {
    type = address.type;
    mark = address.landmark;
    currentPosition = [address.location![0], address.location![1]];
    nameController.text = address.name!;
    numberController.text = address.mobile!;
    if (address.altPhone != null && address.altPhone!.isNotEmpty) {
      isAlter = true;
      altNumberController.text = address.altPhone!;
    }
    pinCodeController.text = address.pincode!;
    stateController.text = address.state!;
    cityController.text = address.state!;
    houseController.text = address.house!;
    streetController.text = address.street!;
    landMarkController.text = address.landmark!;
    update();
  }

  resetAddress() {
    if (Get.find<AuthFactorsController>().phoneNumber.value != '') {
      numberController.text =
          Get.find<AuthFactorsController>().phoneNumber.toString();
    } else {
      numberController.clear();
    }
    type = 'Home';
    mark = "";
    isAlter = false;
    place = const Placemark();
    nameController.clear();
    pinCodeController.clear();
    stateController.clear();
    cityController.clear();
    houseController.clear();
    streetController.clear();
    landMarkController.clear();
    update();
  }
}
