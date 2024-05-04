import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoppe_customer/helper/enums.dart';

part 'notification_body.g.dart';

@HiveType(typeId: 1)
class NotificationBody extends HiveObject {
  @HiveField(0)
  NotificationType? notificationType;

  @HiveField(1)
  String? orderDocId;

  @HiveField(2)
  String? orderId;

  @HiveField(3)
  String? serviceName;

  @HiveField(4)
  MainCategory? serviceType;

  @HiveField(5)
  String? happyCode;

  @HiveField(6)
  String? productName;

  @HiveField(7)
  String? serviceTypeString;

  @HiveField(8)
  String? notificationTypeString;

  NotificationBody({
    required this.notificationType,
    required this.orderId,
    required this.orderDocId,
    required this.serviceName,
    required this.serviceType,
    required this.happyCode,
    required this.productName,
  }) {
    notificationTypeString = notificationType.toString();
    serviceTypeString = serviceType.toString();
  }

  factory NotificationBody.fromJson(Map<String, dynamic> json) {
    return NotificationBody(
      notificationType: convertToEnum(json['eventType']),
      orderId: json['orderId'] ?? "",
      orderDocId: json['_id'] ?? "",
      serviceName: json['serviceName'] ?? "",
      serviceType: convertCategoryToEnum(json['assetType']),
      happyCode: json['happyCode'] ?? "",
      productName: json['productName'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventType'] = notificationTypeString;
    data['orderId'] = orderId;
    data['_id'] = orderDocId;
    data['serviceName'] = serviceName;
    data['assetType'] = serviceTypeString;
    data['happyCode'] = happyCode;
    data['productName'] = productName;
    return data;
  }

  static NotificationType convertToEnum(String? enumString) {
    if (enumString == "happy-code-generated") {
      return NotificationType.happyCode;
    } else if (enumString == 'order-in-progress' ||
        enumString == 'order-placed' ||
        enumString == 'order-completed' ||
        enumString == 'order-cancelled' ||
        enumString == 'order-rejected' ||
        enumString == 'order-confirmed' ||
        enumString == 'order-dispatched') {
      return NotificationType.order;
    }
    return NotificationType.general;
  }

  static MainCategory convertCategoryToEnum(String? enumString) {
    if (enumString == 'Carspa') {
      return MainCategory.CARSPA;
    } else if (enumString == 'Mechanical') {
      return MainCategory.MECHANICAL;
    } else if (enumString == 'Quickhelp') {
      return MainCategory.QUICKHELP;
    } else {
      return MainCategory.SHOPPE;
    }
  }
}
