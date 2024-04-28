import 'package:shoppe_customer/helper/enums.dart';

class NotificationBody {
  NotificationType? notificationType;
  String? orderDocId;
  String? orderId;
  String? serviceName;
  MainCategory? serviceType;
  String? happyCode;
  String? productName;
  String? ServiceTypeString;
  String? notificationTypeString;

  NotificationBody(
      {this.notificationType,
      this.orderId,
      this.orderDocId,
      this.serviceName,
      this.serviceType,
      this.happyCode,
      this.productName});

  NotificationBody.fromJson(Map<String, dynamic> json) {
    notificationType = convertToEnum(json['eventType']);
    orderId = json['orderId'] ?? "";
    orderDocId = json['_id'] ?? "";
    serviceName = json['serviceName'] ?? "";
    serviceType = convertCategoryToEnum(json['assetType']);
    happyCode = json['happyCode'] ?? "";
    productName = json['productName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventType'] = notificationTypeString;
    data['orderId'] = orderId;
    data['_id'] = orderDocId;
    data['serviceName'] = serviceName;
    data['assetType'] = ServiceTypeString;
    data['happyCode'] = happyCode;
    data['productName'] = productName;
    return data;
  }

  NotificationType convertToEnum(String? enumString) {
    notificationTypeString = enumString;
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

  MainCategory convertCategoryToEnum(String? enumString) {
    ServiceTypeString = enumString;
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
