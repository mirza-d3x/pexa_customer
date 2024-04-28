// To parse this JSON data, do
//
//     final mechanicalServiceModel = mechanicalServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_model.dart';

MechanicalServiceModel mechanicalServiceModelFromJson(String str) =>
    MechanicalServiceModel.fromJson(json.decode(str));

String mechanicalServiceModelToJson(MechanicalServiceModel data) =>
    json.encode(data.toJson());

class MechanicalServiceModel {
  MechanicalServiceModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ServiceId>? resultData;

  factory MechanicalServiceModel.fromJson(Map<String, dynamic> json) =>
      MechanicalServiceModel(
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
