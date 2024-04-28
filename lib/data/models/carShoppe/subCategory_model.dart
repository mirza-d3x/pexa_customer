// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) =>
    SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) =>
    json.encode(data.toJson());

class SubCategoryModel {
  SubCategoryModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<SubCategoryResultData>? resultData;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        status: json["status"],
        message: json["message"],
        resultData: List<SubCategoryResultData>.from(
            json["resultData"].map((x) => SubCategoryResultData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class SubCategoryResultData {
  SubCategoryResultData({
    this.id,
    this.name,
    this.categoryId,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  String? categoryId;
  List<String>? images;
  List<String>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory SubCategoryResultData.fromJson(Map<String, dynamic> json) =>
      SubCategoryResultData(
        id: json["_id"],
        name: json["name"],
        categoryId: json["category_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_id": categoryId,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
