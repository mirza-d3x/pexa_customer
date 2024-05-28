import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/data/models/payment_model.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class PaymentAPI {
  final ApiClient? apiClient;

  PaymentAPI({this.apiClient});

  Future cartCheckout({String? coupon}) async {
    String uri = '/order/razorpay';
    if (coupon != null && coupon != "") {
      return await apiClient!.postData(uri: uri, body: {"couponCode": coupon});
    } else {
      return await apiClient!.postData(
        uri: uri,
      );
    }
  }

  Future shoppePayment(String? productId, String count, String coupon) async {
    Map<String, dynamic> body;
    if (coupon != "") {
      body = <String, dynamic>{
        "product": productId,
        "count": count,
        "couponCode": coupon
      };
    } else {
      body = <String, dynamic>{"product": productId, "count": count};
    }
    print('productId: $productId, count: $count');
    final response =
        await apiClient!.postData(uri: '/order/razorpay-buy', body: body);
    try {
      var json = response.bodyString!;
      print(json);

      return initializePaymentFromJson(json);
    } catch (e) {
      print(e);
    }
  }

  Future<Response> servicePayment(
      {String? categoryId,
      List? location,
      String? timeSlot,
      MainCategory? mainServiceCategory,
      var addOns}) async {
    print('id : $categoryId \n data : $location \n time : $timeSlot');
    if (mainServiceCategory == MainCategory.QUICKHELP) {
      return await apiClient!.postData(
          uri: '/quickhelp-service/buy-razorpay',
          body: {"id": categoryId, "coordinate": location});
    }
    if (mainServiceCategory == MainCategory.CARSPA) {
      dynamic bodyData;
      if (addOns != null) {
        bodyData = {
          "id": categoryId,
          "coordinate": location,
          "timeSlot": timeSlot,
          "addOns": addOns
        };
      } else {
        bodyData = {
          "id": categoryId,
          "coordinate": location,
          "timeSlot": timeSlot,
        };
      }
      print(bodyData);
      return await apiClient!
          .postData(uri: '/carspa-order/razorpay', body: bodyData);
    }
    if (mainServiceCategory == MainCategory.MECHANICAL) {
      dynamic bodyData;
      if (addOns != null) {
        bodyData = {
          "id": categoryId,
          "coordinate": location,
          "timeSlot": timeSlot,
          "addOns": addOns
        };
      } else {
        bodyData = {
          "id": categoryId,
          "coordinate": location,
          "timeSlot": timeSlot,
        };
      }
      return await apiClient!
          .postData(uri: '/mechanical-order/razorpay', body: bodyData);
    } else {
      return const Response(statusText: "Not a service");
    }
  }

  Future mechanicalPayment(String categoryId, List location, timeSlot) async {
    print('id : $categoryId \n data : $location \n time : $timeSlot');
    print('${AppConstants.BASE_URL}/mechanical-order/razorpay');
    var controller = Get.find<AuthFactorsController>();
    try {
      final response = await http.post(
          Uri.parse('${AppConstants.BASE_URL}/mechanical-order/razorpay'),
          headers: {
            "Authorization": 'Bearer ${controller.token.value}',
            "Content-Type": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            "id": categoryId,
            "coordinate": location,
            "timeSlot": timeSlot
          }));
      var json = response.body;
      print(json);
      return initializePaymentFromJson(json);
    } catch (e) {
      print(e);
    }
  }

  Future quickHelpPayment(
      String categoryId, List location, BuildContext context) async {
    print('id : $categoryId \n data : $location ');
    print('${AppConstants.BASE_URL}/quickhelp-service/buy-razorpay');
    var controller = Get.find<AuthFactorsController>();
    try {
      final response = await http.post(
          Uri.parse('${AppConstants.BASE_URL}/quickhelp-service/buy-razorpay'),
          headers: {
            "Authorization": 'Bearer ${controller.token.value}',
            "Content-Type": "application/json",
          },
          body: jsonEncode(
              <String, dynamic>{"id": categoryId, "coordinate": location}));
      var json = response.body;
      print(json);
      if (jsonDecode(json)['status'] == 'OK') {
        return initializePaymentFromJson(json);
      } else {
        SmartDialog.showToast(
          'Worker Not Available',
        );
        Navigator.pop(context);
        return null;
      }
    } catch (e) {
      print(e);
      SmartDialog.showToast(
        'Worker Not Available',
      );
      Navigator.pop(context);
      return null;
    }
  }

  Future placeOrder() async {
    Response? response;
    try {
      response = await apiClient!.postData(uri: '/order/');
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
      var response = await apiClient!.postData(
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
