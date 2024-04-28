// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  CouponModelResultData? resultData;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        status: json["status"],
        message: json["message"],
        resultData: CouponModelResultData.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class CouponModelResultData {
  CouponModelResultData({
    this.coupon,
    this.discountAmount,
    this.discountedAmount,
    this.applicable,
  });

  Coupon? coupon;
  num? discountAmount;
  num? discountedAmount;
  bool? applicable;

  factory CouponModelResultData.fromJson(Map<String, dynamic> json) =>
      CouponModelResultData(
        coupon: Coupon.fromJson(json["coupon"]),
        discountAmount: json["discountAmount"],
        discountedAmount: json["discountedAmount"],
        applicable: json["applicable"],
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon!.toJson(),
        "discountAmount": discountAmount,
        "discountedAmount": discountedAmount,
        "applicable": applicable,
      };
}

class Coupon {
  Coupon({
    this.id,
    this.title,
    this.description,
    this.couponCode,
    this.type,
    this.franchiseId,
    this.discountAmount,
    this.discountType,
    this.maxAmount,
    this.minOrder,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? title;
  String? description;
  String? couponCode;
  String? type;
  String? franchiseId;
  num? discountAmount;
  String? discountType;
  num? maxAmount;
  num? minOrder;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        couponCode: json["couponCode"],
        type: json["type"],
        franchiseId: json["franchiseId"],
        discountAmount: json["discountAmount"],
        discountType: json["discountType"],
        maxAmount: json["maxAmount"],
        minOrder: json["minOrder"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "couponCode": couponCode,
        "type": type,
        "franchiseId": franchiseId,
        "discountAmount": discountAmount,
        "discountType": discountType,
        "maxAmount": maxAmount,
        "minOrder": minOrder,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
