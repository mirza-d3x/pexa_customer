// To parse this JSON data, do
//
//     final quickHelpCategoryModel = quickHelpCategoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/category_model.dart';

QuickHelpCategoryModel quickHelpCategoryModelFromJson(String str) =>
    QuickHelpCategoryModel.fromJson(json.decode(str));

String quickHelpCategoryModelToJson(QuickHelpCategoryModel data) =>
    json.encode(data.toJson());

class QuickHelpCategoryModel {
  QuickHelpCategoryModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<CategoryModel>? resultData;

  factory QuickHelpCategoryModel.fromJson(Map<String, dynamic> json) =>
      QuickHelpCategoryModel(
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
