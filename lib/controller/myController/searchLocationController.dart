import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:http/http.dart' as http;
import 'package:shoppe_customer/data/models/google_places_model/google_places_model.dart';

class SearchLocationController extends GetxController {
  SearchLocationController() {
    getUserCurrentLocation();
  }
  var currentPosition = [].obs;
  var recentSearchList = [].obs;
  var predictions = [];
  RxBool isLoading = true.obs;
  bool isAddressSetting = false;
  bool noValue = true;
  final addressController = Get.find<AddressControllerFile>();
  TextEditingController searchController = TextEditingController();
  late final NearPlaces nearPlaces;

  clearRecentSearch() {
    recentSearchList.clear();
    update();
  }

  resetSearch() {
    noValue = true;
    searchController.clear();
    // predictions!.clear();
    update();
  }

  addToRecentHistory(String? val) {
    recentSearchList.add(val);
    recentSearchList.value =
        LinkedHashSet<String>.from(recentSearchList).toList();
  }

  getUserCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _getLocationName(position);
    } catch (error, stackTrace) {
      log("Error while getting User current location",
          error: error, stackTrace: stackTrace);
    }
  }

  Future _getLocationName(Position position) async {
    try {
      const apiKey = "AIzaSyCcT9L1qGXL7RE-UP7qML3_U8bLRgUahyw";
      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$apiKey');
      final response = await http.get(url);

      // log(" status_code: ${response.statusCode} Response: ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        nearPlaces = NearPlaces.fromJson(data);
        isLoading = RxBool(false);
        update();
      } else {
        log(" status_code: ${response.statusCode} Response: ${response.body}");
      }
    } catch (error, stackTrace) {
      log("Error while getting Data from Google Api",
          error: error, stackTrace: stackTrace);
    }
  }

  void updateNovalue(bool v) {
    noValue = v;
    update();
  }

  FocusNode focusNode = FocusNode();
  searchFocus(BuildContext context) {
    FocusScope.of(context).requestFocus(focusNode);
    update();
  }

  Future getCoordinatesFromAddress(
      {required String value, bool isForAddress = false}) async {
    isAddressSetting = true;
    update();
    List<geo.Location> location = await geo.locationFromAddress(value);
    if (isForAddress) {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
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
      Get.find<locationPermissionController>().setLocationString(value);
      Get.find<locationPermissionController>().setCurrentLocation(location[0]);
      update();
    }
    isAddressSetting = false;
    update();
  }
}
