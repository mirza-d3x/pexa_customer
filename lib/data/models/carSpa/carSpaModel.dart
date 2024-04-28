// To parse this JSON data, do
//
//     final carSpaModel = carSpaModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/category_model.dart';

CarSpaModel carSpaModelFromJson(String str) =>
    CarSpaModel.fromJson(json.decode(str));

String carSpaModelToJson(CarSpaModel data) => json.encode(data.toJson());

class CarSpaModel {
  CarSpaModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<CategoryModel>? resultData;

  factory CarSpaModel.fromJson(Map<String, dynamic> json) => CarSpaModel(
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
