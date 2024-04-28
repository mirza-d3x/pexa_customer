import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class locationPermissionController extends GetxController
    implements GetxService {
  var currentPosition = [].obs;
  var locationList = [].obs;
  var userChanged = false.obs;
  String? userLocationString = '';
  String? tempUserLocationString = '';

  LoaderHelper loaderHelper = LoaderHelper();
  var locationEnabled = false.obs;
  var permissionData = false.obs;
  bool isSettingLocation = false;
  Placemark? place;
  Placemark? tempPlace;
  // var permission;
  late bool serviceEnabled;
  LocationPermission? permission;

  final addressController = Get.find<AddressControllerFile>();

  @override
  void onInit() {
    checkLocationStatus();
    // getUserLocation(isForAddress: false);
    // this.determinePosition();
    super.onInit();
  }

  setUserChangedValue(bool v) {
    userChanged.value = v;
    update();
  }

  setCurrentLocation(Location position) {
    currentPosition.value =
        [position.longitude.toDouble(), position.latitude.toDouble()].toList();
    update();
  }

  setLocationString(String locationString) {
    userLocationString = locationString;
    update();
  }

  Future getUserLocation({bool? isForAddress = false}) async {
    // loaderHelper.startLoader();
    isSettingLocation = true;
    update();

    if (userChanged.value == false) {
      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 5));
      } catch (e) {
        position = await Geolocator.getLastKnownPosition();
      }
      print(position);
      if (isForAddress!) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position!.latitude.toDouble(), position.longitude.toDouble());
        addressController.setCurrentPositionData(
            currentPosit: [
              position.latitude.toDouble(),
              position.longitude.toDouble()
            ],
            placemarks: placemarks[0],
            locationString:
                '${placemarks[0].subLocality!},${placemarks[0].locality!}');
      } else {
        currentPosition.value = [
          position!.longitude.toDouble(),
          position.latitude.toDouble()
        ].toList();
        Get.find<ProductCategoryController>().productLocationList.value = [
          position.latitude.toDouble(),
          position.longitude.toDouble()
        ].toList();
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude.toDouble(), position.longitude.toDouble());
        if (isForAddress) {
          tempPlace = placemarks[0];
          tempUserLocationString = place!.subLocality!.isNotEmpty
              ? place!.subLocality
              : '${place!.name!},${place!.locality!}';
          update();
        } else {
          place = placemarks[0];
          userLocationString = place!.subLocality!.isNotEmpty
              ? place!.subLocality
              : '${place!.name!},${place!.locality!}';
          update();
        }
      }

      // _getAddressFromLatLng(position);

    }
    // }
    // loaderHelper.cancelLoader();
    isSettingLocation = false;
    update();
  }

  Future getCoordinatesFromAddress(
      {required String value, bool isForAddress = false}) async {
    loaderHelper.startLoader();
    isSettingLocation = true;
    update();
    List<Location> location = await locationFromAddress(value);
    if (isForAddress) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          location[0].latitude.toDouble(), location[0].longitude.toDouble());
      addressController.setCurrentPositionData(currentPosit: [
        location[0].latitude.toDouble(),
        location[0].longitude.toDouble()
      ], locationString: value, placemarks: placemarks[0]);
    } else {
      currentPosition.value = [
        location[0].longitude.toDouble(),
        location[0].latitude.toDouble()
      ].toList();
      Get.find<ProductCategoryController>().productLocationList.value = [
        location[0].latitude.toDouble(),
        location[0].longitude.toDouble()
      ].toList();
      userChanged.value = true;
      userLocationString = value;
      update();
    }
    loaderHelper.cancelLoader();
    isSettingLocation = false;
    update();
  }

  Future checkLocationStatus() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      locationEnabled.value = false;
      permissionData.value = false;
      loaderHelper.cancelLoader();
      update();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      locationEnabled.value = false;
      permissionData.value = false;
      loaderHelper.cancelLoader();
      update();
      return false;
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      locationEnabled.value = true;
      permissionData.value = true;
      loaderHelper.cancelLoader();
      update();
      return true;
    } else {
      return false;
    }
  }

  Future determinePosition({bool? isforAddress = false}) async {
    loaderHelper.startLoader();
    update();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      loaderHelper.cancelLoader();
      update();
      showCustomSnackBar("Enable the location",
          isError: true, title: 'Warning');
      return Future.error('Location services are disabled.');
    } else {
      // requestPermission();
      loaderHelper.cancelLoader();
      update();
    }
    permission = await Geolocator.checkPermission();
    update();
    if (permission == LocationPermission.denied) {
      locationEnabled.value = false;
      requestPermission();
      loaderHelper.cancelLoader();
      update();
      showCustomSnackBar("Enable the location",
          isError: true, title: 'Warning');
    } else if (permission != null &&
        permission == LocationPermission.deniedForever) {
      locationEnabled.value = false;
      requestPermission();
      loaderHelper.cancelLoader();
      update();
      showCustomSnackBar("Enable the location",
          isError: true, title: 'Warning');
    } else if (permission != null && permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      locationEnabled.value = true;
      loaderHelper.cancelLoader();
      update();
      if (isforAddress!) {
        getUserLocation(isForAddress: isforAddress);
      } else {
        getUserLocation(isForAddress: isforAddress);
        Get.find<ProductCategoryController>().setLocationForProductFetch();
      }
    } else {
      locationEnabled.value = false;
      loaderHelper.cancelLoader();
      update();
    }
    loaderHelper.cancelLoader();
    update();
    // return await Geolocator.getCurrentPosition();
  }

  requestPermission() async {
    // permission = await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission()
        .whenComplete(() => getUserLocation(isForAddress: true));
    // if (!await Permission.locationAlways.isGranted) {
    //   var t = await Permission.locationAlways.request();
    // }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      userLocationString = '${place.subLocality!},${place.locality!}';
      var currentAddress =
          '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      print(currentAddress);
    }).catchError((e) {
      print(e.toString());
      debugPrint(e);
    });
  }
}
