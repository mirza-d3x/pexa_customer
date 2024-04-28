// To parse this JSON data, do
//
//     final shippingModel = shippingModelFromJson(jsonString);

import 'dart:convert';

ShippingModel shippingModelFromJson(String str) =>
    ShippingModel.fromJson(json.decode(str));

String shippingModelToJson(ShippingModel data) => json.encode(data.toJson());

class ShippingModel {
  ShippingModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ShippingResultData>? resultData;

  factory ShippingModel.fromJson(Map<String, dynamic> json) => ShippingModel(
        status: json["status"],
        message: json["message"],
        resultData: List<ShippingResultData>.from(
            json["resultData"].map((x) => ShippingResultData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class ShippingResultData {
  ShippingResultData({
    this.id,
    this.specification,
    this.minimum,
    this.rate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? specification;
  num? minimum;
  num? rate;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory ShippingResultData.fromJson(Map<String, dynamic> json) =>
      ShippingResultData(
        id: json["_id"],
        specification: json["specification"],
        minimum: json["minimum"],
        rate: json["rate"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "specification": specification,
        "minimum": minimum,
        "rate": rate,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
