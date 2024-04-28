// To parse this JSON data, do
//
//     final mechanicalOrderModel = mechanicalOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_order_model.dart';

MechanicalOrderModel mechanicalOrderModelFromJson(String str) =>
    MechanicalOrderModel.fromJson(json.decode(str));

String mechanicalOrderModelToJson(MechanicalOrderModel data) =>
    json.encode(data.toJson());

class MechanicalOrderModel {
  MechanicalOrderModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ServiceOrderModel>? resultData;

  factory MechanicalOrderModel.fromJson(Map<String, dynamic> json) =>
      MechanicalOrderModel(
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
