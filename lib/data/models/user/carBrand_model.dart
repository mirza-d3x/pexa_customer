// To parse this JSON data, do
//
//     final carBrandModel = carBrandModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/car_model/make.dart';

CarBrandModel carBrandModelFromJson(String str) =>
    CarBrandModel.fromJson(json.decode(str));

String carBrandModelToJson(CarBrandModel data) => json.encode(data.toJson());

class CarBrandModel {
  CarBrandModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<Make>? resultData;

  factory CarBrandModel.fromJson(Map<String, dynamic> json) => CarBrandModel(
        status: json["status"],
        message: json["message"],
        resultData:
            List<Make>.from(json["resultData"].map((x) => Make.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class CarBrandResultData {
  CarBrandResultData({
    this.id,
    this.name,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  List<String>? images;
  List<dynamic>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  List<dynamic>? thumbUrl;
  List<String>? imageUrl;

  factory CarBrandResultData.fromJson(Map<String, dynamic> json) =>
      CarBrandResultData(
        id: json["_id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<dynamic>.from(json["thumbnail"].map((x) => x)),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        thumbUrl: List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
