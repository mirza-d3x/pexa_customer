import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/repository/homa_api.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/data/models/car_model/make.dart';
import 'package:shoppe_customer/data/models/car_model/model.dart';
import 'package:shoppe_customer/data/models/common/featured_model.dart';
import 'package:shoppe_customer/data/models/explore_data.dart';
import 'package:shoppe_customer/data/models/home_model.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class InitialLoaderController extends GetxController implements GetxService {
  InitialLoaderController({required this.homeApi});
  HomeApi homeApi;
  LoaderHelper loaderHelper = LoaderHelper();
  List<FeaturedProduct>? featuredProducts = [];
  List<FeaturedProduct>? offeredProducts = [];
  List<ExploreData> exploreDataList = [];
  List<Make> makeList = [];
  List<Model> modelList = [];

  loadData() {
    loaderHelper.startLoader();
    update();
    // Get.find<AppVersionController>().checkVersion();
    // if (!GetPlatform.isWeb) {
    Get.find<NotificationController>().initializeNotification();
    // }
    // Future.wait([
    //   // Get.find<BannerController>().bannerData("Newbanners"),
    //   // // Get.find<ProductCategoryController>().fetchCategoryData(),
    //   // Get.find<ProductCategoryController>().fetchFeaturedProducts('feature'),
    //   // Get.find<ProductCategoryController>().fetchFeaturedProducts('offered'),
    //   // Get.find<CarSpaController>().getAllCarSpaCategory().then((value) {
    //   //   Get.find<ProductCategoryController>().exploreSection();
    //   // }),
    //   getHomeData(),
    //   Get.find<ProductCategoryController>().setLocationForProductFetch(),
    // ]);
    getHomeData().then((value) {
      Get.find<ProductCategoryController>().setLocationForProductFetch();
      if (value) {
        if (Get.find<ProductCategoryController>().exploreList.isNotEmpty) {
          Get.find<ProductCategoryController>().exploreSection();
        } else {
          getExploreListData();
        }
      }
    });
    loaderHelper.cancelLoader();
    update();
  }

  Future getHomeData() async {
    Response response = await homeApi.fetchData();
    if (response.isOk && response.body['resultData'] != null) {
      HomeModel homeModel;
      homeModel = homeModelFromJson(response.bodyString!);
      bool isUserDataError = homeModel.resultData!.errors!.user != null;
      // response.body['resultData']['errors']['user'] != null;
      bool isFeatureDataError = homeModel.resultData!.errors!.feature != null;
      bool isOfferedDataError = homeModel.resultData!.errors!.offered != null;
      bool isBannerDataError =
          homeModel.resultData!.errors!.banners_and_explore != null;
      if (!isUserDataError) {
        Get.find<AuthFactorsController>()
            .setUserDetails(homeModel.resultData!.user);
      }
      if (!isFeatureDataError) {
        featuredProducts = homeModel.resultData!.feature;
        Get.find<ProductCategoryController>()
            .setFeaturedProduct(featuredProducts);
      }
      if (!isOfferedDataError) {
        offeredProducts = homeModel.resultData!.offered;
        Get.find<ProductCategoryController>()
            .setOfferedProduct(offeredProducts);
      }
      if (!isBannerDataError) {
        for (var value in homeModel.resultData!.bannersAndExplore!.banners!) {
          if (value.name == 'Newbanners') {
            Get.find<BannerController>().setHomeBanner(value.imageUrl);
          }
        }
      }
      for (var element in homeModel.resultData!.makes!) {
        if (element.name != "GENERAL") {
          makeList.add(element);
        }
      }
      Get.find<CarModelController>().setAllMakeList(makeList);
      if (modelList.isNotEmpty) {
        modelList.clear();
      } else {
        for (var element in homeModel.resultData!.models!) {
          if (element.name != "GENERAL") {
            modelList.add(element);
          }
        }
        if (Get.find<CarModelController>().modelList == null ||
            Get.find<CarModelController>().modelList!.isEmpty) {
          Get.find<CarModelController>().setAllModelList(modelList);
        }
      }

      if (homeModel.resultData!.bannersAndExplore!.explore != null &&
          homeModel.resultData!.bannersAndExplore!.explore!.isNotEmpty) {
        for (var element in homeModel.resultData!.bannersAndExplore!.explore!) {
          exploreDataList.add(element);
        }

        Get.find<ProductCategoryController>().setExploreList(exploreDataList);
      }
      return true;
    } else {
      return false;
    }
  }

  Future getExploreListData() async {
    Response response = await homeApi.getExploreDataList();
    if (response.statusCode == 200) {
      exploreDataList = [];
      response.body['resultData'].forEach((element) {
        exploreDataList.add(ExploreData.fromJson(element));
      });
      Get.find<ProductCategoryController>().setExploreList(exploreDataList);
      Get.find<ProductCategoryController>().exploreSection();
    }
  }
}
