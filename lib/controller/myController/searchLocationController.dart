import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';
//import 'package:google_place/google_place.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';

class SearchLocationController extends GetxController {
  var currentPosition = [].obs;
  var recentSearchList = [].obs;
  // late GooglePlace googlePlace;
  // List<AutocompletePrediction>? predictions = [];
  var predictions = [];
  bool isLoading = false;
  bool isAddressSetting = false;
  bool noValue = true;
  final addressController = Get.find<AddressControllerFile>();
  TextEditingController searchController = TextEditingController();

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

  void autoCompleteSearch({required String searchKey}) async {
    if (searchKey.isNotEmpty) {
      isLoading = true;
      update();
      //   var result = await googlePlace.autocomplete
      //       .get(searchKey, components: [Component('country', 'IN')]);
      //   if (result != null && result.predictions != null) {
      //     predictions = result.predictions;
      //     isLoading = false;
      //     update();
      //   }
      // } else {
      //   predictions!.clear();
    }
    isLoading = false;
    update();
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
    List<geo.Location> location =
        await geo.locationFromAddress(value);
    if (isForAddress) {
      List<geo.Placemark> placemarks =
          await geo.placemarkFromCoordinates(
              location[0].latitude.toDouble(),
              location[0].longitude.toDouble());
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
