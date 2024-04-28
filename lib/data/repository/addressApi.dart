import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as Http;
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class AddressApi {
  final ApiClient apiClient;
  var controller = Get.find<AuthFactorsController>();

  AddressApi({required this.apiClient});

  Future addAddress(Map<String, dynamic> data) async {
    try {
      final response = await apiClient.postData(
        uri: '/address',
        body: data,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.bodyString!);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> getAllAdress() async {
    Response? response;
    try {
      response = await apiClient.getData(uri: '/address/all');
      if (response.statusCode == 200) {
        return response;
      } else {
        return response;
      }
    } catch (e) {
      print(e);
      return response;
    }
  }

  Future deleteAddress(String addressId) async {
    try {
      final response = await apiClient.deleteData(uri: '/address/$addressId');
      if (response.statusCode == 200) {
        return jsonDecode(response.bodyString!);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future editAddress(String addressId, Map<String, dynamic> data) async {
    try {
      final response =
          await apiClient.putData(uri: '/address/$addressId', body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.bodyString!);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future setDefaultAddress(String addressId) async {
    try {
      final response = await Http.put(
        Uri.parse('${AppConstants.BASE_URL}/address/default/$addressId'),
        headers: {
          "Authorization": 'Bearer ${controller.token.value}',
          "Content-Type": "application/json",
        },
      );
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
      showCustomSnackBar("Setting default address didn't go well.",
          isError: true);
    }
  }

  Future getDefaultAddress() async {
    try {
      final response = await apiClient.getData(uri: '/address');
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        var json = response.bodyString!;
        return jsonDecode(json);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
