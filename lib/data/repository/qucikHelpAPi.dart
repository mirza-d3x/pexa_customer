import 'dart:convert';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/models/QucikHelp/qucikHelpCategory.dart';
import 'package:shoppe_customer/data/models/QucikHelp/quickHelpServiceModel.dart';
import 'package:get/get.dart';

class QuickHelpAPI {
  final ApiClient apiClient;
  final controller = Get.find<AuthFactorsController>();

  QuickHelpAPI({required this.apiClient});

  Future getQucikHelpCategory() async {
    try {
      final response = await apiClient.getData(uri: '/quickhelp-category/');
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        var json = response.bodyString!;
        return quickHelpCategoryModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getQuickHelpService(String catId) async {
    try {
      final response = await apiClient.getData(
          uri: '/quickhelp-service/categoryId/$catId');
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        var json = response.bodyString!;
        return quickHelpServiceModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future quickHelpBuyNow(String? id, List data) async {
    try {
      final response = await apiClient.postData(
          uri: '/quickhelp-service/buy',
          body: <String, dynamic>{"id": id, "coordinate": data});
      if (response.statusCode == 200) {
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
