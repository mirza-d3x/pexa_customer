import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class ServerApi {
  ApiClient apiClient = Get.find<ApiClient>();
  ServerApi({required this.apiClient});

  Future checkServer() async {
    try {
      final response = await InternetAddress.lookup('shoppe.carclenx.com');
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("Check server error : $e");
      }
      return null;
    }
  }

  Future<Response?> initialDatas() async {
    Response? response;
    try {
      response = await apiClient.getData(uri: AppConstants.FETCH_APP_CONSTANTS);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print("Initial constants : $e");
      }
      return response;
    }
  }
}
