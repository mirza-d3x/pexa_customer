// To parse this JSON data, do
//
//     final mechanicalOfferModel = mechanicalOfferModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/offer_model.dart';

MechanicalOfferModel mechanicalOfferModelFromJson(String str) =>
    MechanicalOfferModel.fromJson(json.decode(str));

String mechanicalOfferModelToJson(MechanicalOfferModel data) =>
    json.encode(data.toJson());

class MechanicalOfferModel {
  MechanicalOfferModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<OfferModel>? resultData;

  factory MechanicalOfferModel.fromJson(Map<String, dynamic> json) =>
      MechanicalOfferModel(
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
