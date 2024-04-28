// To parse this JSON data, do
//
//     final mechanicalModel = mechanicalModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/category_model.dart';

MechanicalModel mechanicalModelFromJson(String str) =>
    MechanicalModel.fromJson(json.decode(str));

String mechanicalModelToJson(MechanicalModel data) =>
    json.encode(data.toJson());

class MechanicalModel {
  MechanicalModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<CategoryModel>? resultData;

  factory MechanicalModel.fromJson(Map<String, dynamic> json) =>
      MechanicalModel(
        status: json["status"],
        message: json["message"],
        resultData: List<CategoryModel>.from(
            json["resultData"].map((x) => CategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}
