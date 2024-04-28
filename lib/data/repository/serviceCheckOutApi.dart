import 'package:shoppe_customer/data/api/api_client.dart';
import 'dart:convert';
import 'package:shoppe_customer/helper/enums.dart';

class ServiceCheckOutApi {
  final ApiClient apiClient;

  ServiceCheckOutApi({required this.apiClient});

  Future placeOrder(
      Map<String, dynamic> data, MainCategory mainServiceCategory) async {
    String uri = "";
    if (mainServiceCategory == MainCategory.CARSPA) {
      uri = '/carspa-order/checkout';
    }
    if (mainServiceCategory == MainCategory.MECHANICAL) {
      uri = '/mechanical-order/checkout';
    }
    if (mainServiceCategory == MainCategory.QUICKHELP) {
      uri = '/quickhelp-service/buy';
    }
    try {
      final response = await apiClient.postData(uri: uri, body: data);
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        var json = response.bodyString!;
        return jsonDecode(json);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
