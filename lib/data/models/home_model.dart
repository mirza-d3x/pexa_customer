// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/car_model/make.dart';
import 'package:shoppe_customer/data/models/car_model/model.dart';
import 'package:shoppe_customer/data/models/common/featured_model.dart';
import 'package:shoppe_customer/data/models/explore_data.dart';
import 'package:shoppe_customer/data/models/user/userDetails.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  ResultData? resultData;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        message: json["message"],
        resultData: json["resultData"] == null
            ? null
            : ResultData.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData?.toJson(),
      };
}

class ResultData {
  ResultData({
    this.errors,
    this.feature,
    this.offered,
    this.bannersAndExplore,
    this.makes,
    this.models,
    this.user,
  });

  ErrorsModel? errors;
  List<FeaturedProduct>? feature;
  List<FeaturedProduct>? offered;
  BannersAndExplore? bannersAndExplore;
  List<Make>? makes;
  List<Model>? models;
  User? user;

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        errors: json["errors"] == null
            ? null
            : ErrorsModel.fromJson(json["errors"]),
        feature: json["feature"] == null
            ? null
            : List<FeaturedProduct>.from(
                json["feature"].map((x) => FeaturedProduct.fromJson(x))),
        offered: json["offered"] == null
            ? null
            : List<FeaturedProduct>.from(
                json["offered"].map((x) => FeaturedProduct.fromJson(x))),
        bannersAndExplore: json["banners-and-explore"] == null
            ? null
            : BannersAndExplore.fromJson(json["banners-and-explore"]),
        makes: json["makes"] == null
            ? null
            : List<Make>.from(json["makes"].map((x) => Make.fromJson(x))),
        models: json["models"] == null
            ? null
            : List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors?.toJson(),
        "feature": feature == null
            ? null
            : List<dynamic>.from(feature!.map((x) => x.toJson())),
        "offered": offered == null
            ? null
            : List<dynamic>.from(offered!.map((x) => x.toJson())),
        "banners-and-explore":
            bannersAndExplore?.toJson(),
        "makes": makes == null
            ? null
            : List<dynamic>.from(makes!.map((x) => x.toJson())),
        "models": models == null
            ? null
            : List<dynamic>.from(models!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}

class BannersAndExplore {
  BannersAndExplore({
    this.banners,
    this.explore,
  });

  List<Banner>? banners;
  List<ExploreData>? explore;

  factory BannersAndExplore.fromJson(Map<String, dynamic> json) =>
      BannersAndExplore(
        banners: json["banners"] == null
            ? null
            : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        explore: json["explore"] == null
            ? null
            : List<ExploreData>.from(
                json["explore"].map((x) => ExploreData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banners": banners == null
            ? null
            : List<dynamic>.from(banners!.map((x) => x.toJson())),
        "explore": explore == null
            ? null
            : List<dynamic>.from(explore!.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    this.id,
    this.name,
    this.images,
    this.thumbnail,
    this.v,
    this.thumbUrl,
    this.imageUrl,
    this.type,
  });

  String? id;
  String? name;
  List<String>? images;
  List<String>? thumbnail;
  int? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;
  String? type;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["_id"],
        name: json["name"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"] == null
            ? null
            : List<String>.from(json["thumbnail"].map((x) => x)),
        v: json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail == null
            ? null
            : List<dynamic>.from(thumbnail!.map((x) => x)),
        "__v": v,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl!.map((x) => x)),
        "type": type,
      };
}

class ErrorsModel {
  ErrorsModel(
      {this.user,
      this.feature,
      this.offered,
      this.banners_and_explore,
      this.makes,
      this.models});

  ErrorDetailsModel? user;
  ErrorDetailsModel? feature;
  ErrorDetailsModel? offered;
  ErrorDetailsModel? banners_and_explore;
  ErrorDetailsModel? makes;
  ErrorDetailsModel? models;

  factory ErrorsModel.fromJson(Map<String, dynamic> json) => ErrorsModel(
        user: json["user"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["user"]),
        feature: json["feature"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["feature"]),
        offered: json["offered"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["offered"]),
        banners_and_explore: json["banners-and-explore"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["banners-and-explore"]),
        makes: json["makes"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["makes"]),
        models: json["models"] == null
            ? null
            : ErrorDetailsModel.fromJson(json["models"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "feature": feature?.toJson(),
        "offered": offered?.toJson(),
        "banners-and-explore":
            banners_and_explore?.toJson(),
        "makes": makes?.toJson(),
        "models": models?.toJson(),
      };
}

class ErrorDetailsModel {
  ErrorDetailsModel({
    this.status,
    this.message,
    this.statusCode,
  });

  String? status;
  String? message;
  int? statusCode;

  factory ErrorDetailsModel.fromJson(Map<String, dynamic> json) =>
      ErrorDetailsModel(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
      };
}
