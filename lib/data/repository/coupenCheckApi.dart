import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:shoppe_customer/util/app_constants.dart';

class CouponApi extends GetxService {
  final ApiClient apiClient;

  CouponApi({required this.apiClient});

  Future checkCoupon(double amount, String code) async {
    try {
      final response = await apiClient.postData(
          uri: '/coupon/code/$code',
          body: <String, dynamic>{"amount": amount});
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        return jsonDecode(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getAllCoupon(double amount, String code) async {
    try {
      final response = await apiClient.getData(uri: AppConstants.ALL_COUPON);
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        return jsonDecode(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getAllOffers() async {
    try {
      return await apiClient.getData(uri: AppConstants.ALL_OFFER);
    } catch (e) {
      print("Get all offer api error : $e");
      return null;
    }
  }
}
