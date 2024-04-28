import 'dart:convert';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class NotificationAPI {
  final ApiClient apiClient;

  NotificationAPI({required this.apiClient});

  Future initializeNotification(Map<String, dynamic> data) async {
    try {
      Response response = await apiClient.postData(
          uri: AppConstants.NOTIFICATION_INITIALIZE, body: data);
      if ((response.statusCode == 200) || (response.statusCode == 201)) {
        var json = response.body;
        return jsonDecode(json);
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  Future getNotification({required String readStatus}) async {
    return await apiClient.getData(
        uri: '/notification/user/$readStatus?type=customer');
  }

  Future postSeenNotification({List<String?>? idList}) async {
    return await apiClient.putData(
        uri: '/notification/user/mark-as-read',
        body: {'notificationIds': idList});
  }
}
