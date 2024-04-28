// To parse this JSON data, do
//
//     final productListModel = productListModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/product_details.dart';

ProductListModel productListModelFromJson(String str) =>
    ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) =>
    json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    this.status,
    this.message,
    this.resultData,
    this.totalPages,
  });

  String? status;
  String? message;
  List<ProductId>? resultData;
  int? totalPages;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      ProductListModel(
        status: json["status"],
        message: json["message"],
        resultData: json["resultData"] == null
            ? []
            : List<ProductId>.from(
                json["resultData"].map((x) => ProductId.fromJson(x))),
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData == null
            ? []
            : List<dynamic>.from(resultData!.map((x) => x.toJson())),
        "totalPages": totalPages,
      };
}
