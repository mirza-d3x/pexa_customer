import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class ServiceRepo extends GetxService {
  final ApiClient apiClient;
  ServiceRepo({required this.apiClient});

  Future<Response> getAllServiceCategory({MainCategory? mainCategory}) async {
    var uri = "";
    if (mainCategory == MainCategory.CARSPA) {
      uri = AppConstants.CARSPA_CATEGORY_LIST;
    }
    if (mainCategory == MainCategory.MECHANICAL) {
      uri = AppConstants.MECHANICAL_CATEGORY_LIST;
    }
    return await apiClient.getData(uri: uri);
  }

  Future<Response> getServiceList(
      {MainCategory? mainCategory, required String catId, String? carType}) async {
    var uri = "";
    if (mainCategory == MainCategory.CARSPA) {
      uri = AppConstants.CARSPA_SERVICES_FOR_CARS;
    }
    if (mainCategory == MainCategory.MECHANICAL) {
      uri = AppConstants.MECHANICAL_SERVICES;
    }
    return await apiClient.getData(uri: uri + catId);
    // return await apiClient.getData(uri: uri + catId + '?carType=' + carType);
  }

  Future<Response> getCarSpaServiceOtherThanCar({String? catId}) async {
    return await apiClient.postData(
        uri: AppConstants.CARSPA_SERVICES_EXCEPT_CARS,
        body: <String, dynamic>{
          "id": catId,
        });
  }

  Future<Response> getServiceTimeSlot(
      {String? serId, String? date, MainCategory? mainCategory}) async {
    var uri = "";
    if (mainCategory == MainCategory.CARSPA) {
      uri = AppConstants.CARSPA_TIMESLOTS;
    }
    if (mainCategory == MainCategory.MECHANICAL) {
      uri = AppConstants.MECHANICAL_TIMESLOTS;
    }
    return await apiClient.postData(uri: uri, body: <String, dynamic>{
      "id": serId,
      "coordinate": [
        Get.find<AddressControllerFile>().defaultAddress!.location![1],
        Get.find<AddressControllerFile>().defaultAddress!.location![0]
      ],
      "date": date
    });
  }

  Future<Response> getAvailableOffers(
      {String? serId, int? amount, MainCategory? mainCategory}) async {
    var uri = "";
    if (mainCategory == MainCategory.CARSPA) {
      uri = AppConstants.CARSPA_AVAILABLE_OFFERS;
    }
    if (mainCategory == MainCategory.MECHANICAL) {
      uri = AppConstants.MECHANICAL_AVAILABLE_OFFERS;
    }
    return await apiClient.postData(
        uri: uri, body: <String, dynamic>{"serviceID": serId, "total": amount});
  }

  Future<Response> applyOffers(
      {String? serId,
      int? amount,
      String? offerId,
      MainCategory? mainCategory}) async {
    var uri = "";
    if (mainCategory == MainCategory.CARSPA) {
      uri = AppConstants.CARSPA_APPLY_OFFERS;
    }
    if (mainCategory == MainCategory.MECHANICAL) {
      uri = AppConstants.MECHANICAL_APPLY_OFFERS;
    }
    return await apiClient.postData(uri: uri, body: <String, dynamic>{
      "offerId": offerId,
      "total": amount,
      "serviceId": serId
    });
  }
}
