import 'package:get/get_connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class SearchRepo {
  final ApiClient apiClient;

  SearchRepo({
    required this.apiClient,
  });
  var box = GetStorage();
  Future<void> saveSearchHistory(List<String> searchHistories) async {
    return await box.write(AppConstants.SEARCH_HISTORY, searchHistories);
  }

  List<dynamic>? getSearchAddress() {
    return box.read(AppConstants.SEARCH_HISTORY) ?? [];
  }

  Future<void> clearSearchHistory() async {
    return box.remove(AppConstants.SEARCH_HISTORY);
  }

  Future<Response> searchProduct({List? data, String? value, required String page}) async {
    return await apiClient.postData(
        uri: AppConstants.SEARCH_PRODUCT + page,
        body: <String, dynamic>{"query": value, "location": data});
  }
}
