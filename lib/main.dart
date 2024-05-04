import 'dart:async';
import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shoppe_customer/controller/myController/localization_controller.dart';
import 'package:shoppe_customer/controller/splash_controller.dart';
import 'package:shoppe_customer/data/api/firebase_api.dart';
import 'package:shoppe_customer/firebase_options.dart';
import 'package:shoppe_customer/helper/app_life_state.dart';
import 'package:shoppe_customer/helper/dynamiclink_helper.dart';
import 'package:shoppe_customer/helper/hive_helper.dart';
import 'package:shoppe_customer/helper/notification_helper.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/theme/dark_theme.dart';
import 'package:shoppe_customer/theme/light_theme.dart';
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppe_customer/util/messages.dart';
import 'package:url_strategy/url_strategy.dart';
import 'controller/theme_controller.dart';
import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper().initHive();
  Map<String, Map<String, String>> languages = await di.init();
  await GetStorage.init();
///////
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
///////
  await FireBaseApi().initNotifications();

  // Get any initial links
  String? id;

  if (GetPlatform.isMobile) {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    DynamicLinkHelper().initializeDynamicLinkHelper();
    if (initialLink != null) {
      var path = initialLink.link.path;
      if (path.contains('id=')) {
        id = path.substring(4);
      }
    }
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final RemoteMessage? remoteMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      // NotificationBody _body =
      //     NotificationHelper.convertNotification(remoteMessage.data);
    }
    await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LifeCycle(child: PexaApp(languages: languages, productId: id)),
  ));
  // });
}

class PexaApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  final String? productId;
  const PexaApp({super.key, this.languages, this.productId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: GetMaterialApp(
              navigatorObservers: [FlutterSmartDialog.observer],
              title: AppConstants.APP_NAME,
              // initialBinding: HomeBinding(),
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
              ),
              theme: themeController.darkTheme ? dark : light,
              initialRoute: RouteHelper.getSplashRoute(productId: productId),
              getPages: RouteHelper.routes,
              defaultTransition: Transition.topLevel,
              transitionDuration: const Duration(milliseconds: 500),
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                  AppConstants.languages[0].countryCode),
              localizationsDelegates: const [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],

              builder: FlutterSmartDialog.init(builder: (context, child) {
                //builder:
                FlutterSmartDialog.init();
                final mediaQueryData = MediaQuery.of(context);
                // final num scale = mediaQueryData.textScaler.clamp(0.5, 0.9);
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaler: mediaQueryData.textScaler
                          .clamp(minScaleFactor: 0.5, maxScaleFactor: 0.9)),
                  child: child!,
                );
              }),
            ),
          );
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
