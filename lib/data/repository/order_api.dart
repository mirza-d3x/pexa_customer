import 'package:get/get.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/helper/enums.dart';

class OrderApi extends GetxService {
  final ApiClient? apiClient;
  OrderApi({this.apiClient});

  Future getOrderStatus(
      {required String page, MainCategory? category, OrderPage? status}) async {
    return await apiClient!.getData(
        uri: '${'${'/' +
            EnumConverter.getCategoryString(category)}/customer?status=' +
            EnumConverter.getStatusString(status)}&page=$page');
  }

  Future getOrderDetails({MainCategory? category, required String orderId}) async {
    return await apiClient!.getData(
        uri:
            '${'/' + EnumConverter.getCategoryString(category)}/id/$orderId');
  }

  Future cancelOrder({String? orderId, MainCategory? category}) async {
    if (category == MainCategory.SHOPPE) {
      return await apiClient!.putData(
          uri: '${'/' +
              EnumConverter.getCategoryString(category)}/id/${orderId!}',
          body: <String, dynamic>{"status": "Cancelled"});
    } else {
      return await apiClient!.putData(
          uri: '${'/' +
              EnumConverter.getCategoryString(category)}/status/${orderId!}',
          body: <String, dynamic>{"status": "Cancelled"});
    }
  }

  Future updateRating(
      {MainCategory? category, Map<String, dynamic>? body}) async {
    return await apiClient!.putData(
        uri: '${'/' + EnumConverter.getCategoryString(category)}/feedback',
        body: body);
  }
}
