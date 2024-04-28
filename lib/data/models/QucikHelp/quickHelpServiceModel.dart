// To parse this JSON data, do
//
//     final quickHelpServiceModel = quickHelpServiceModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/service_model.dart';

QuickHelpServiceModel quickHelpServiceModelFromJson(String str) =>
    QuickHelpServiceModel.fromJson(json.decode(str));

String quickHelpServiceModelToJson(QuickHelpServiceModel data) =>
    json.encode(data.toJson());

class QuickHelpServiceModel {
  QuickHelpServiceModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status = "";
  String? message;
  List<ServiceId>? resultData;

  factory QuickHelpServiceModel.fromJson(Map<String, dynamic> json) =>
      QuickHelpServiceModel(
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
