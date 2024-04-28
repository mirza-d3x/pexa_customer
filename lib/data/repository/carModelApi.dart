import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/data/models/car_model/car_model.dart';
import 'package:shoppe_customer/data/models/user/carBrand_model.dart';
import 'dart:convert';

import 'package:shoppe_customer/util/app_constants.dart';

class CarModelApi {
  final ApiClient apiClient;
  final boxId = GetStorage();

  CarModelApi({required this.apiClient});

  Future fetchAllCarList() async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.ALL_CAR_MAKE_MODEL,
      );
      if (response.statusCode == 200) {
        var json = response.body;
        return CarModel.fromJson(json);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<CarBrandModel?> carBrands() async {
    try {
      final response = await apiClient.getData(
        uri: AppConstants.CAR_MAKE_LIST,
      );
      if (response.statusCode == 200) {
        var json = response.bodyString!;
        return carBrandModelFromJson(json);
      } else {
        return jsonDecode(response.bodyString!);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> fetchCarModels(String id) async {
    try {
      final response =
          await apiClient.getData(uri: '${AppConstants.CAR_MODEL_LIST}$id');
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future carModelUpdateUser(String id) async {
    try {
      final response = await apiClient
          .postData(uri: '/user/' + boxId.read('userId'), body: {'model': id});
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to load ');
      }
    } catch (e) {}
  }

  Future fetchCarModelDetail(String modelId) async {
    try {
      final response = await apiClient.getData(uri: '/model/id/$modelId');
      if (response.statusCode == 200) {
        return jsonDecode(response.bodyString!);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchCarBrandDetail(String modelId) async {
    try {
      final response = await apiClient.getData(uri: '/make/id/$modelId');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.bodyString!);
        return jsonResponse;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
