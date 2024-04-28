// To parse this JSON data, do
//
//     final carSpaOrderModel = carSpaOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_order_model.dart';

CarSpaOrderModel carSpaOrderModelFromJson(String str) =>
    CarSpaOrderModel.fromJson(json.decode(str));

String carSpaOrderModelToJson(CarSpaOrderModel data) =>
    json.encode(data.toJson());

class CarSpaOrderModel {
  CarSpaOrderModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ServiceOrderModel>? resultData;

  factory CarSpaOrderModel.fromJson(Map<String, dynamic> json) =>
      CarSpaOrderModel(
        status: json["status"],
        message: json["message"],
        resultData: List<ServiceOrderModel>.from(
            json["resultData"].map((x) => ServiceOrderModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}
