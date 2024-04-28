// To parse this JSON data, do
//
//     final carModelsModel = carModelsModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/car_model/model.dart';

CarModelsModel carModelsModelFromJson(String str) =>
    CarModelsModel.fromJson(json.decode(str));

String carModelsModelToJson(CarModelsModel data) => json.encode(data.toJson());

class CarModelsModel {
  CarModelsModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<Model>? resultData;

  factory CarModelsModel.fromJson(Map<String, dynamic> json) => CarModelsModel(
        status: json["status"],
        message: json["message"],
        resultData:
            List<Model>.from(json["resultData"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class CarModelsResultData {
  CarModelsResultData({
    this.id,
    this.name,
    this.makeId,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.carType,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  MakeId? makeId;
  List<String>? images;
  List<String>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  String? carType;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory CarModelsResultData.fromJson(Map<String, dynamic> json) =>
      CarModelsResultData(
        id: json["_id"],
        name: json["name"],
        makeId: makeIdValues.map[json["make_id"]],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        carType: json["carType"],
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "make_id": makeIdValues.reverse![makeId],
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "carType": carType,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}

enum MakeId { THE_6210_E1_D728_DF47_F09_B86_BF9_A }

final makeIdValues = EnumValues(
    {"6210e1d728df47f09b86bf9a": MakeId.THE_6210_E1_D728_DF47_F09_B86_BF9_A});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
