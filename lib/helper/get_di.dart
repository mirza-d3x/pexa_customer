import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shoppe_customer/controller/myController/searchLocationController.dart';
import 'package:shoppe_customer/data/repository/addressApi.dart';
import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/data/repository/authApi.dart';
import 'package:shoppe_customer/data/repository/carModelApi.dart';
import 'package:shoppe_customer/data/repository/cartApi.dart';
import 'package:shoppe_customer/data/repository/coupenCheckApi.dart';
import 'package:shoppe_customer/data/repository/homa_api.dart';
import 'package:shoppe_customer/data/repository/notification_api.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/data/repository/payment_api.dart';
import 'package:shoppe_customer/data/repository/productApi.dart';
import 'package:shoppe_customer/data/repository/qucikHelpAPi.dart';
import 'package:shoppe_customer/data/repository/search_api.dart';
import 'package:shoppe_customer/data/repository/server_api.dart';
import 'package:shoppe_customer/data/repository/serviceCheckOutApi.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/appVersionController.dart';
import 'package:shoppe_customer/controller/myController/banner_controller.dart';
import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/expandableListController.dart';
import 'package:shoppe_customer/controller/myController/imageCacheController.dart';
import 'package:shoppe_customer/controller/myController/initial_loader_controller.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/localization_controller.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/controller/myController/packageOfferController.dart';
import 'package:shoppe_customer/controller/myController/paymentController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/controller/myController/rating_controller.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/controller/splash_controller.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/controller/theme_controller.dart';
import 'package:shoppe_customer/data/repository/service_repo.dart';
import 'package:shoppe_customer/data/repository/splash_repo.dart';
import 'package:shoppe_customer/data/models/language_model.dart';
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => AppVersionController());
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  Get.lazyPut(() => MyTabController());

  // Repository
  Get.lazyPut(() => SplashRepo(
        sharedPreferences: Get.find(),
      ));
  Get.lazyPut(() => ServerApi(
        apiClient: Get.find<ApiClient>(),
      ));
  Get.lazyPut(() => AuthApi(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => NotificationAPI(apiClient: Get.find()));
  Get.lazyPut(() => CarModelApi(apiClient: Get.find()), fenix: true);
  Get.lazyPut(() => ProductAPI(apiClient: Get.find()));
  Get.lazyPut(() => OrderApi(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => ServiceRepo(apiClient: Get.find()));
  Get.lazyPut(() => HomeApi(apiClient: Get.find()));
  Get.lazyPut(() => CartApi(apiClient: Get.find()));
  Get.lazyPut(() => CouponApi(apiClient: Get.find()));
  Get.lazyPut(() => QuickHelpAPI(apiClient: Get.find()));
  Get.lazyPut(() => AddressApi(apiClient: Get.find()));
  Get.lazyPut(() => ServiceCheckOutApi(apiClient: Get.find()));
  Get.lazyPut(() => PaymentAPI(apiClient: Get.find<ApiClient>()));
  Get.lazyPut(() => NotificationAPI(apiClient: Get.find()));
  Get.lazyPut(() => SearchRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => BannerController(homeApi: Get.find()));
  Get.lazyPut(() => ConnectivityController(serverApi: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find<SplashRepo>()));
  Get.lazyPut(() => SearchLocationController());
  // Get.lazyPut(() => LocationEnabledController());
  Get.lazyPut(() => AuthFactorsController(authApi: Get.find<AuthApi>()));
  Get.lazyPut(() => CarModelController(carModelApi: Get.find()));
  Get.lazyPut(
      () => CarSpaController(serviceRepo: Get.find(), orderApi: Get.find()));
  Get.lazyPut(() => CartControllerFile(cartApi: Get.find()));
  Get.lazyPut(() => AddressControllerFile(addressApi: Get.find()));
  Get.lazyPut(() => CarSpaTimeSlotController());
  Get.lazyPut(() => ServiceCheckOutController(serviceCheckOutApi: Get.find()));
  Get.lazyPut(() => ProductDetailsController());
  Get.lazyPut(() => OrderController(orderApi: Get.find<OrderApi>()));

  Get.lazyPut(() =>
      MechanicalController(serviceRepo: Get.find(), orderApi: Get.find()));
  Get.lazyPut(() => MechanicalTimeSlotController());
  Get.lazyPut(() =>
      QuickHelpController(quickHelpAPI: Get.find(), orderApi: Get.find()));
  Get.lazyPut(() => NotificationController(notificationAPI: Get.find()));
  Get.lazyPut(() => PackageOfferController(couponApi: Get.find<CouponApi>()));
  Get.lazyPut(() => locationPermissionController());
  Get.lazyPut(() => ShoppeSearchController(searchRepo: Get.find()));
  Get.lazyPut(() => ImageCacheController());
  Get.lazyPut(() => CouponController(couponApi: Get.find()));
  Get.lazyPut(() => PaymentController(paymentAPI: Get.find<PaymentAPI>()));
  Get.lazyPut(() =>
      ProductCategoryController(productAPI: Get.find(), orderApi: Get.find()));
  Get.lazyPut(() => BuyNowController());
  Get.lazyPut(() => NavigationDrawerController());
  Get.lazyPut(() => InitialLoaderController(homeApi: Get.find()));
  Get.lazyPut(() => ExpandableListController());
  Get.lazyPut(() => RatingController(orderApi: Get.find()));
  Get.lazyPut(() => LocalizationController(apiClient: Get.find()));

  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
