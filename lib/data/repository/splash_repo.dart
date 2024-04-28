import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final SharedPreferences sharedPreferences;
  SplashRepo({
    required this.sharedPreferences,
  });

  Future<bool> initSharedData() {
    if (!sharedPreferences.containsKey(AppConstants.THEME)) {
      sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.SEARCH_HISTORY)) {
      sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
    }
    if (!sharedPreferences.containsKey(AppConstants.NOTIFICATION)) {
      sharedPreferences.setBool(AppConstants.NOTIFICATION, true);
    }
    if (!sharedPreferences.containsKey(AppConstants.INTRO)) {
      sharedPreferences.setBool(AppConstants.INTRO, true);
    }
    if (!sharedPreferences.containsKey(AppConstants.NOTIFICATION_COUNT)) {
      sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, 0);
    }
    return Future.value(true);
  }

  void disableIntro() {
    sharedPreferences.setBool(AppConstants.INTRO, false);
  }

  bool? showIntro() {
    return sharedPreferences.getBool(AppConstants.INTRO);
  }
}
