// To parse this JSON data, do
//
//     final carSpaServiceModel = carSpaServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_model.dart';

CarSpaServiceModel carSpaServiceModelFromJson(String str) =>
    CarSpaServiceModel.fromJson(json.decode(str));

String carSpaServiceModelToJson(CarSpaServiceModel data) =>
    json.encode(data.toJson());

class CarSpaServiceModel {
  CarSpaServiceModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ServiceId>? resultData;

  factory CarSpaServiceModel.fromJson(Map<String, dynamic> json) =>
      CarSpaServiceModel(
        status: json["status"],
        message: json["message"],
        resultData: List<ServiceId>.from(
            json["resultData"].map((x) => ServiceId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}
