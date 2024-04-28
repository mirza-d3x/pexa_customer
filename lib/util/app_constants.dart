import 'package:shoppe_customer/data/models/language_model.dart';
import 'package:shoppe_customer/util/images.dart';

class AppConstants {
  static const String APP_NAME = 'Pexa';
  static const String APP_VERSION = '3.1.7';

  static const String BASE_URL = 'https://shoppe.carclenx.com/v1.0';
  // static const String BASE_URL = 'https://stagingshoppe.carclenx.com/v1.0';
  // static const String BASE_URL = 'http://192.168.1.58:4000/v1.0';

  // Shared Key
  static const String THEME = 'theme';
  static const String TIME_FORMAT = '24';
  static const String TOKEN = 'multivendor_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';

  //api urls
  static const String FETCH_APP_CONSTANTS = "/app-constant/all";
  static const String FEATURED_PRODUCT = "/feature/type/";
  static const String FETCH_HOME_BANNER = "/banner/name/";
  static const String FETCH_ALL_BANNER = "/banner";
  static const String FETCH_PRODUCT_CATEGORIES = "/product-category/";
  static const String FETCH_ALL_PRODUCT = "/product/all/";
  static const String FETCH_PRODUCT_BY_CATEGORY = "/product/getByCategory/";
  static const String FETCH_PRODUCT_LIST = "/product/getBySubCategory/";
  static const String GET_PRODUCT_DETAIL = "/product/id/";
  static const String GET_RUNNING_ORDER_STATUS =
      "/order/customer?status=Running&page=";
  static const String PRODUCT_SUB_CATEGORY = "/product-sub-category/category/";
  static const String GET_ORDER_STATUS_HISTORY =
      "/order/customer?status=History&page=";
  static const String CANCEL_ORDER = "/order/id/";
  static const String ORDER_NOW = "/order/buyNow/";
  static const String GET_SHIPPING_DETAILS = "/shipping";
  static const String SEARCH_PRODUCT = "/product/search?page=";
  static const String GET_USER_DETAILS = "/user/id/";
  static const String PUT_USER_LOCATION = "/user/";
  static const String HOME_DATA = "/consolidated/homepage";
  static const String ALL_COUPON = "/coupon/all";
  static const String ALL_OFFER = "/mechanical-offer/all";
  static const String NOTIFICATION_INITIALIZE = '/notification';
  static const String ALL_CAR_MAKE_MODEL = '/consolidated/makes-models';
  static const String CAR_MAKE_LIST = '/make/';
  static const String CAR_MODEL_LIST = '/model/make/';
  static const String CARSPA_CATEGORY_LIST = '/category';
  static const String CARSPA_SERVICES_FOR_CARS = '/service/categoryId/';
  static const String CARSPA_SERVICES_EXCEPT_CARS = '/service/getservices';
  static const String CARSPA_TIMESLOTS = '/service/buy';
  static const String CARSPA_AVAILABLE_OFFERS = '/carspa-offer/availableOffers';
  static const String CARSPA_APPLY_OFFERS = '/carspa-offer/apply';
  static const String MECHANICAL_CATEGORY_LIST = '/mechanical-category';
  static const String MECHANICAL_SERVICES = '/mechanical-service/categoryId/';
  static const String MECHANICAL_TIMESLOTS = '/mechanical-service/buy';
  static const String MECHANICAL_AVAILABLE_OFFERS =
      '/mechanical-offer/availableOffers';
  static const String MECHANICAL_APPLY_OFFERS = '/mechanical-offer/apply';

  static const String ALL_NOTIFICATION_URI =
      '/notification/user/all?type=customer';
  static const String UNREAD_NOTIFICATION_URI =
      '/notification/user/unread?type=customer';
  static const String LOCALIZATION_KEY = 'X-localization';

  static  List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
