import 'package:get/get.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/data/models/fetchImages.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class HomeApi extends GetxService {
  final ApiClient apiClient;
  HomeApi({required this.apiClient});

  Future<Response> fetchData() async {
    return await apiClient.getData(uri: AppConstants.HOME_DATA);
  }

  Future fetchBanner(String name) async {
    var response =
        await apiClient.getData(uri: AppConstants.FETCH_HOME_BANNER + name);
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = response.bodyString!;
        print(response.bodyString);
        return fetchBannerFromJson(json);
      } else {
        print(response.bodyString);
        return null;
      }
    } catch (e) {
      print(response.bodyString);
      print('fetchBanners error');
      print(e);
    }
  }

  Future<Response> getExploreDataList() async {
    return await apiClient.getData(uri: '/explore-tile');
  }
}
