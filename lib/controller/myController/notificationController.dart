import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shoppe_customer/data/repository/notification_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/helper/date_converter.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/hive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/notification_hive/notification_body.dart';
import 'package:shoppe_customer/data/models/notification_model/notification_model.dart';

class NotificationController extends GetxController implements GetxService {
  int bottomNavSelectedPage = 0;
  var token = ''.obs;
  var deviceId = ''.obs;
  var device = ''.obs;
  var deviceType = ''.obs;
  int notificationCount = 0;
  List<NotificationModel>? _notificationList;
  final bool _hasNotification = false;

  NotificationController({required this.notificationAPI}) {
    registerAdapter();
  }
  List<NotificationModel>? get notificationList => _notificationList;
  bool get hasNotification => _hasNotification;

  final NotificationAPI notificationAPI;

  setBottomNavSelectedPage(int pageNo) {
    bottomNavSelectedPage = pageNo;
    update();
  }

  void registerAdapter() {
    HiveHelper().registerAdapters(NotificationBodyAdapter());
  }

  Future initializeNotification() async {
    if (GetPlatform.isWeb) {
      token.value = (await FirebaseMessaging.instance.getToken(
          vapidKey:
              "BNh6YWRrZL3_l6I1rhzLcsu-r0zZUNPVLL0eEfYb5n-yINJeoR_d5pPj1-zdPCfpHCPAL0aPTxk7OT1VqfUSSDs"))!;
    } else {
      token.value = (await FirebaseMessaging.instance.getToken())!;
    }
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        device.value = build.model;
        deviceId.value = build.id;
        deviceType.value = 'Android';
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        device.value = data.name;
        deviceId.value = data.identifierForVendor!;
        deviceType.value = 'Ios';
      }
    } on PlatformException {
      log("Platrom exception");
    }
    update();
    Map<String, dynamic> data = {
      "token": token.value,
      "deviceId": deviceId.value,
      "device": device.value,
      "deviceType": deviceType.value,
      "userType": "customer",
    };

    var response = await notificationAPI.initializeNotification(data);
    print(response);
  }

  Future<int> getNotificationList(bool reload) async {
    if (_notificationList == null || reload) {
      Response response =
          await (notificationAPI.getNotification(readStatus: 'all'));
      if (response.statusCode == 200) {
        _notificationList = [];
        response.body['resultData'].forEach((notification) =>
            _notificationList!.add(NotificationModel.fromJson(notification)));
        notificationCount = _notificationList!
            .where((element) => element.read == false)
            .toList()
            .length;
        _notificationList!.sort((a, b) {
          return DateConverter.localDateToIsoString(a.updatedAt!)
              .compareTo(DateConverter.localDateToIsoString(b.updatedAt!));
        });
        Iterable iterable = _notificationList!.reversed;
        _notificationList = iterable.toList() as List<NotificationModel>?;
      }
      update();
    }
    return _notificationList!.length;
  }

  getNotificationFromLocal() async {
    var response = await HiveHelper().getAllData('notifications');
    log(response.toString());
  }

  Future setSeenNotification(List<String?> idList) async {
    Response response =
        await (notificationAPI.postSeenNotification(idList: idList));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (int i = 0; i < idList.length; i++) {
        for (var notification in _notificationList!) {
          if (notification.id == idList[i]) {
            notification.read = true;
            update();
          }
        }
      }
    }
  }

  void clearNotification() {
    _notificationList = null;
  }

  List<NotificationBody> backgroundMessageList = [];
  addBackgroundNotifications(RemoteMessage message) {
    NotificationBody notificationBody = NotificationBody.fromJson(message.data);
    backgroundMessageList.add(notificationBody);
    update();
  }

  clearBackgroundNotifications() {
    backgroundMessageList.clear();
    update();
  }

  manageBackgroundNotification() {
    if (backgroundMessageList.isNotEmpty) {
      loadBackgroundOrderDetails();
    }
  }

  loadBackgroundOrderDetails() {
    if (Get.currentRoute == RouteHelper.productOrderDetailedView) {
      String? orderId = Get.find<OrderController>().shoppeOrderDetail.id;
      backgroundMessageList.where((element) {
        return element.orderDocId == orderId;
      });
      Get.find<OrderController>().getSingleOrderDetails(
          orderId: orderId!, serviceCategory: MainCategory.SHOPPE);
      backgroundMessageList.clear();
    }
    if (Get.currentRoute == RouteHelper.serviceOrderDetailedView) {
      String? orderId = Get.find<OrderController>().selectedOrderDetails!.id;
      var isExistOrder = backgroundMessageList.where((element) {
        return element.orderDocId == orderId;
      });
      Get.find<OrderController>().getSingleOrderDetails(
          orderId: orderId!, serviceCategory: isExistOrder.first.serviceType);
      backgroundMessageList.clear();
    }
    if (Get.currentRoute == RouteHelper.initial && bottomNavSelectedPage == 3) {
      Get.find<MyTabController>()
          .loadData(isRunning: Get.find<MyTabController>().tabIndex == 0);
      backgroundMessageList.clear();
    }
  }

  loadForeGroundOrderDetails(
      {required String? orderId, required MainCategory? category}) {
    if (Get.currentRoute == RouteHelper.productOrderDetailedView &&
        Get.find<OrderController>().shoppeOrderDetail.id == orderId) {
      Get.find<OrderController>().getSingleOrderDetails(
          orderId: orderId!, serviceCategory: MainCategory.SHOPPE);
    }
    if (Get.currentRoute == RouteHelper.serviceOrderDetailedView &&
        Get.find<OrderController>().selectedOrderDetails!.id == orderId) {
      Get.find<OrderController>()
          .getSingleOrderDetails(orderId: orderId!, serviceCategory: category);
    }
    if (Get.currentRoute == RouteHelper.initial && bottomNavSelectedPage == 3) {
      Get.find<MyTabController>()
          .loadData(isRunning: Get.find<MyTabController>().tabIndex == 0);
    }
  }
}
