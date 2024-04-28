import 'dart:convert';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/data/models/carShoppe/productListModel.dart';
import 'package:shoppe_customer/data/models/carShoppe/shoppeOrdersModel.dart';
import 'package:shoppe_customer/data/models/carShoppe/subCategory_model.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class ProductAPI extends GetxService {
  final ApiClient apiClient;

  ProductAPI({required this.apiClient});

  Future categoryAPI() async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.FETCH_PRODUCT_CATEGORIES,
      );
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        return response;
        // return categoryModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future subCategoryAPI(String catId) async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.PRODUCT_SUB_CATEGORY + catId,
      );
      if ((response.statusCode == 200) | (response.statusCode == 201)) {
        var json = response.bodyString!;
        return subCategoryModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getAllProductList(String page) async {
    return await apiClient.getData(
      uri: AppConstants.FETCH_ALL_PRODUCT + page,
      // body: jsonEncode(
      //     <String, dynamic>{"sub_category_id": subId, "location": data})
    );
  }

  Future getProductByCategory(String? categoryId, String page, List data) async {
    return await apiClient.postData(
        uri: AppConstants.FETCH_PRODUCT_BY_CATEGORY + page,
        body: <String, dynamic>{"category_id": categoryId, "location": data});
  }

  Future getProductList(String? subId, List data, String page) async {
    try {
      final response = await apiClient.postData(
          uri: AppConstants.FETCH_PRODUCT_LIST + page,
          body: <String, dynamic>{"sub_category_id": subId, "location": data});
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        return productListModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getProductDetails(String prodId) async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.GET_PRODUCT_DETAIL + prodId,
      );
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

  Future getRunningOrderStatus(String page) async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.GET_RUNNING_ORDER_STATUS + page,
      );
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        print(json);
        return shoppeOrderModelFromJson(json);
      } else {
        print(response.bodyString);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future getHistoryOrderStatus(String page) async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.GET_ORDER_STATUS_HISTORY + page,
      );
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        return shoppeOrderModelFromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future cancelOrder(String ordId) async {
    try {
      final response = await apiClient.putData(
          uri: AppConstants.CANCEL_ORDER + ordId,
          body: <String, dynamic>{"status": "Cancelled"});
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

  Future buyNowProduct(Map<String, dynamic> body) async {
    try {
      final response =
          await apiClient.postData(uri: AppConstants.ORDER_NOW, body: body);
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

  Future<Response> getShippingDetails() async {
    return await apiClient.getData(
      uri: AppConstants.GET_SHIPPING_DETAILS,
    );
  }

  Future<Response> fetchFuturedProduct(String type) async {
    return await apiClient.getData(uri: AppConstants.FEATURED_PRODUCT + type);
  }
}
