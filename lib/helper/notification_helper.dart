import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/hive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/carShoppe/shoppeOrdersModel.dart';
import 'package:shoppe_customer/data/models/notification_hive/notification_body.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';

class NotificationHelper {
  static void saveNotification(NotificationBody notification) async {
    await HiveHelper().saveData('notifications', notification);
    log("Notification Saved");
  }

  void requestIOSPermissions(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
        const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);

// when app is closed
    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      navigate(NotificationBody.fromJson(
          jsonDecode(details.notificationResponse!.payload!)));
    }

    await flutterLocalNotificationsPlugin.initialize(
      initializationsSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null &&
            notificationResponse.payload != '') {
          // navigateTo(json.decode(notificationResponse.payload));
        }
      },
    );

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'pexa_customer', // id
      'pexa_customer', // title
      description:
          'This channel is used for important notifications.', // description
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.high, enableVibration: true, playSound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    NotificationHelper().requestIOSPermissions(flutterLocalNotificationsPlugin);

    // Future<String> getDeviceToken() async =>
    //     await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.data}");
      NotificationHelper.showNotification(
          message, flutterLocalNotificationsPlugin, true);

      NotificationBody notificationBody =
          NotificationBody.fromJson(message.data);
      Get.find<NotificationController>().loadForeGroundOrderDetails(
          orderId: notificationBody.orderDocId,
          category: notificationBody.serviceType);
      saveNotification(notificationBody);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (message.data.isNotEmpty) {
          NotificationBody notificationBody0 =
              convertNotification(message.data);
          if (notificationBody0.notificationType == NotificationType.order) {
            log('order call-------------');
            navigate(notificationBody0);
          }
          saveNotification(notificationBody0);
        }
      } catch (error, stackTrace) {
        log("Error while opening Notification",
            error: error, stackTrace: stackTrace);
      }
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    if (!GetPlatform.isIOS) {
      String? title;
      String? body;
      String? orderID;
      String? image;
      NotificationBody notificationBody = convertNotification(message.data);
      if (data) {
        title = message.data['title'];
        body = message.data['description'];
        orderID = message.data['order_id'];
        image =
            (message.data['image'] != null && message.data['image'].isNotEmpty)
                ? message.data['image']
                : 'notification_icon';
      } else {
        title = message.notification!.title;
        body = message.notification!.body;
        orderID = message.notification!.titleLocKey;
        if (GetPlatform.isAndroid) {
          image = (message.notification!.android!.imageUrl != null &&
                  message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl
              : 'notification_icon';
        } else if (GetPlatform.isIOS) {
          image = (message.notification!.apple!.imageUrl != null &&
                  message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl
              : null;
        }
      }
      if (notificationBody.notificationType == NotificationType.happyCode) {
        await showBigTextNotification(
            title, body!, orderID, notificationBody, fln);
      } else {
        if (image != null && image.isNotEmpty) {
          try {
            await showBigPictureNotificationHiddenLargeIcon(
                title, body, orderID, notificationBody, image, fln);
          } catch (e) {
            await showBigTextNotification(
                title, body!, orderID, notificationBody, fln);
          }
        } else {
          await showBigTextNotification(
              title, body!, orderID, notificationBody, fln);
        }
      }
    }
  }

  static Future<void> showTextNotification(
      String title,
      String body,
      String orderID,
      NotificationBody notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexa_customer',
      'pexa_customer',
      playSound: true,
      importance: Importance.high,
      priority: Priority.high,
      color: Colors.amber,
      colorized: false,
      icon: 'notification_icon',
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const DarwinNotificationDetails appleNotificationDetails =
        DarwinNotificationDetails(
            sound: 'notification.aiff', presentAlert: true, presentSound: true);
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: appleNotificationDetails,
        macOS: appleNotificationDetails);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: jsonEncode(notificationBody.toJson()));
  }

  static Future<void> showBigTextNotification(
      String? title,
      String body,
      String? orderID,
      NotificationBody notificationBody,
      FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexa_customer',
      'pexa_customer',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
      color: Colors.amber,
      colorized: false,
      icon: 'notification_icon',
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    const DarwinNotificationDetails appleNotificationDetails =
        DarwinNotificationDetails(
            sound: 'notification.aiff', presentAlert: true, presentSound: true);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: appleNotificationDetails,
        macOS: appleNotificationDetails);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: jsonEncode(notificationBody.toJson()));
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(
    String? title,
    String? body,
    String? orderID,
    NotificationBody notificationBody,
    String image,
    FlutterLocalNotificationsPlugin fln,
  ) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
        await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'pexa_customer',
      'pexa_customer',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.high,
      playSound: true,
      color: Colors.amber,
      colorized: false,
      icon: 'notification_icon',
      styleInformation: bigPictureStyleInformation,
      importance: Importance.high,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    const DarwinNotificationDetails appleNotificationDetails =
        DarwinNotificationDetails(
            sound: 'notification.aiff', presentAlert: true, presentSound: true);
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: appleNotificationDetails,
        macOS: appleNotificationDetails);
    await fln.show(0, title, body, platformChannelSpecifics,
        payload: jsonEncode(notificationBody.toJson()));
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data) {
    return NotificationBody.fromJson(data);
  }

  static onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    NotificationBody payload0;
    if (notificationResponse.payload != null) {
      log('notification payload: $payload');
      payload0 = NotificationBody.fromJson(jsonDecode(payload!));
      // if (_payload.notificationType == NotificationType.order) {
      //       Get.toNamed(RouteHelper.orderDetailedView(
      //           int.parse(_payload.orderId.toString())));
      //     } else if (_payload.notificationType == NotificationType.general) {
      //       Get.toNamed(RouteHelper.getNotificationRoute());
      //     } else {
      //       Get.toNamed(RouteHelper.getChatRoute(
      //           notificationBody: _payload,
      //           conversationID: _payload.conversationId));
      //     }
      navigate(payload0);
    }
  }

  static navigate(NotificationBody notificationBody) {
    switch (notificationBody.serviceType) {
      case MainCategory.SHOPPE:
        Get.find<OrderController>()
            .getSingleOrderDetails(
                orderId: notificationBody.orderDocId!,
                serviceCategory: MainCategory.SHOPPE)
            .then((value) {
          if (value != null) {
            ShoppeOrderDetail shoppeOrderDetail =
                Get.find<OrderController>().shoppeOrderDetail;
            Get.toNamed(RouteHelper.productOrderDetailedView, arguments: {
              'orderId': notificationBody.orderDocId,
              'mainServiceCategory': MainCategory.SHOPPE,
              'shoppeOrderResultData': shoppeOrderDetail,
              'isRunning': shoppeOrderDetail.status == 'Processing' ||
                  shoppeOrderDetail.status == 'Confirmed' ||
                  shoppeOrderDetail.status == 'Dispatched'
            });
          }
        });
        break;
      case MainCategory.CARSPA:
        Get.find<OrderController>()
            .getSingleOrderDetails(
                orderId: notificationBody.orderDocId!,
                serviceCategory: MainCategory.CARSPA)
            .then((value) {
          if (value != null) {
            ServiceOrderModel orderDetails =
                Get.find<OrderController>().selectedOrderDetails!;
            Get.toNamed(RouteHelper.serviceOrderDetailedView, arguments: {
              'OrderId': notificationBody.orderDocId,
              'orderDetails': orderDetails,
              'mainServiceCategory': MainCategory.CARSPA,
              'isRunning': (orderDetails.status == "Active" ||
                      orderDetails.status == 'Reassigned')
                  ? true
                  : false,
            });
          }
        });
        break;
      case MainCategory.MECHANICAL:
        Get.find<OrderController>()
            .getSingleOrderDetails(
                orderId: notificationBody.orderDocId!,
                serviceCategory: MainCategory.MECHANICAL)
            .then((value) { 
          if (value != null) {
            ServiceOrderModel serviceOrderModel =
                Get.find<OrderController>().selectedOrderDetails!;
            Get.toNamed(RouteHelper.serviceOrderDetailedView, arguments: {
              'OrderId': notificationBody.orderDocId,
              'orderDetails': serviceOrderModel,
              'mainServiceCategory': MainCategory.MECHANICAL,
              'isRunning': (serviceOrderModel.status == "Active" ||
                      serviceOrderModel.status == 'Reassigned')
                  ? true
                  : false,
            });
          }
        });
        break;
      case MainCategory.QUICKHELP:
        Get.find<OrderController>()
            .getSingleOrderDetails(
                orderId: notificationBody.orderDocId!,
                serviceCategory: MainCategory.QUICKHELP)
            .then((value) {
          if (value) {
            ServiceOrderModel serviceOrderModel =
                Get.find<OrderController>().selectedOrderDetails!;
            Get.toNamed(RouteHelper.serviceOrderDetailedView, arguments: {
              'OrderId': notificationBody.orderDocId,
              'orderDetails': serviceOrderModel,
              'mainServiceCategory': MainCategory.QUICKHELP,
              'isRunning': (serviceOrderModel.status == "Active" ||
                      serviceOrderModel.status == 'Reassigned')
                  ? true
                  : false,
            });
          }
        });
        break;
      case null:
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  log("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  Get.find<NotificationController>().addBackgroundNotifications(message);
}
