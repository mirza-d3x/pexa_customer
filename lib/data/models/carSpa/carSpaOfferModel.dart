// To parse this JSON data, do
//
//     final carSpaOfferModel = carSpaOfferModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/offer_model.dart';

CarSpaOfferModel carSpaOfferModelFromJson(String str) =>
    CarSpaOfferModel.fromJson(json.decode(str));

String carSpaOfferModelToJson(CarSpaOfferModel data) =>
    json.encode(data.toJson());

class CarSpaOfferModel {
  CarSpaOfferModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<OfferModel>? resultData;

  factory CarSpaOfferModel.fromJson(Map<String, dynamic> json) =>
      CarSpaOfferModel(
        status: json["status"],
        message: json["message"],
        resultData: List<OfferModel>.from(
            json["resultData"].map((x) => OfferModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}
