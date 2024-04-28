import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class CartApi {
  final ApiClient apiClient;

  final controller = Get.find<AuthFactorsController>();

  CartApi({required this.apiClient});

  Future addOrUpdateCart(String? prodId, int? count) async {
    try {
      final response = await apiClient.postData(
          uri: '/cart/',
          body: <String, dynamic>{"product": prodId, "count": count});
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

  Future<Response> getCartDetails() async {
    return await apiClient.getData(uri: '/cart/');
    // try {
    //   final response =
    //   if (response.statusCode == 200) {
    //     var json = response.bodyString;
    //     return cartListModelFromJson(json);
    //   } else {
    //     return null;
    //   }
    // } catch (e) {
    //   return null;
    // }
  }

  Future<Response> getShippingDetails() async {
    return await apiClient.getData(
      uri: AppConstants.GET_SHIPPING_DETAILS,
    );
  }

  Future removeCart(String prodId) async {
    try {
      final response =
          await apiClient.deleteData(uri: '/cart/product/$prodId');
      if (response.statusCode == 200) {
        var json = response.bodyString;
        return (json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future placeOrder() async {
    Response? response;
    try {
      response = await apiClient.postData(uri: '/order/');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      return response;
    }
  }

  Future placeOrderWithCode(String code) async {
    try {
      var response = await apiClient.postData(
          uri: '/order/', body: <String, dynamic>{"couponCode": code});
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = response.bodyString!;
        return jsonDecode(json);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      return null;
    }
  }
}
