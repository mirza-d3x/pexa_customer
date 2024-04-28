// To parse this JSON data, do
//
//     final quickHelpOrderModel = quickHelpOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_order_model.dart';

QuickHelpOrderModel quickHelpOrderModelFromJson(String str) =>
    QuickHelpOrderModel.fromJson(json.decode(str));

String quickHelpOrderModelToJson(QuickHelpOrderModel data) =>
    json.encode(data.toJson());

class QuickHelpOrderModel {
  QuickHelpOrderModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ServiceOrderModel>? resultData;

  factory QuickHelpOrderModel.fromJson(Map<String, dynamic> json) =>
      QuickHelpOrderModel(
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
