import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/homa_api.dart';

class BannerController extends GetxController implements GetxService {
  List<dynamic>? banner = [];
  var shoppeListing = [].obs;
  var shoppeCategoriesListing = [].obs;
  var carspaBanners = [].obs;
  var mechanicalBanners = [].obs;
  var quickhelpBanners = [].obs;
  final HomeApi homeApi;

  BannerController({required this.homeApi});

  Future bannerData(String name) async {
    var response = await homeApi.fetchBanner(name);
    if (response != null) {
      splitBannerList(name, response);
    }
    update();
  }

  setHomeBanner(var bannerList) {
    banner = bannerList;
    update();
  }

  splitBannerList(String name, var response) {
    if (name == 'Newbanners') {
      banner = response.resultData.imageUrl;
    } else if (name == 'ShoppeListingBanner') {
      shoppeListing.value = response.resultData.imageUrl;
    } else if (name == 'shoppeCategoriesListing') {
      shoppeCategoriesListing.value = response.resultData.imageUrl;
    } else if (name == 'carspa') {
      carspaBanners.value = response.resultData.imageUrl;
    } else if (name == 'mechanical') {
      mechanicalBanners.value = response.resultData.imageUrl;
    } else if (name == 'quickhelp') {
      quickhelpBanners.value = response.resultData.imageUrl;
    }
  }
}
