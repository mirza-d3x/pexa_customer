import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class AuthApi extends GetxService {
  final ApiClient apiClient;

  AuthApi({required this.apiClient});
  final boxUser = GetStorage();

  Future<Response> login({String? phone}) async {
    return await apiClient.postData(
      uri: '/auth/login',
      body: {'phone': phone, 'loginType': 'customer'},
      // headers: {
      //   "Content-Type": "application/x-www-form-urlencoded",
      // },
    );
  }

  Future<Response> verifyOTP({String? phone, String? otp}) async {
    return await apiClient.postData(
      uri: '/auth/verify-otp',
      body: {'phone': phone, 'otpCode': otp},
      // encoding: Encoding.getByName('utf-8'),
      // headers: {
      //   "Content-Type": "application/x-www-form-urlencoded",
      // },
    );
  }

  Future<Response> fetchUserDetails(String id) async {
    return await apiClient.getData(uri: AppConstants.GET_USER_DETAILS + id);
  }

  Future addModelIdToProfile(String? modelId, String? carType) async {
    try {
      final response = await apiClient.putData(
          uri: '/user/' + boxUser.read('userId'),
          body: {'model_id': modelId, 'carType': carType});
      if (response.statusCode == 200) {
        return (response.bodyString);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Response> updateDetailsUser(
      String email, String name, String userId, String location) async {
    return await apiClient.putData(uri: '/user/$userId', body: {
      'email': email,
      'name': name,
      'locationName': [location],
    });
  }

  Future<Response> updateUserLocation(
      String? locationData, String userId) async {
    return await apiClient.putData(uri: '/user/$userId', body: {
      'locationName': [locationData]
    });
  }
}
