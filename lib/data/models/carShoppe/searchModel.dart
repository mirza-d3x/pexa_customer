// To parse this JSON data, do
//
//     final pexaSearchModel = pexaSearchModelFromJson(jsonString);

import 'dart:convert';

PexaSearchModel pexaSearchModelFromJson(String str) =>
    PexaSearchModel.fromJson(json.decode(str));

String pexaSearchModelToJson(PexaSearchModel data) =>
    json.encode(data.toJson());

class PexaSearchModel {
  PexaSearchModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<SearchResultData>? resultData;

  factory PexaSearchModel.fromJson(Map<String, dynamic> json) =>
      PexaSearchModel(
        status: json["status"],
        message: json["message"],
        resultData: List<SearchResultData>.from(
            json["resultData"].map((x) => SearchResultData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class SearchResultData {
  SearchResultData({
    this.id,
    this.name,
    this.price,
    this.offerPrice,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  num? price;
  num? offerPrice;
  List<dynamic>? thumbUrl;
  List<dynamic>? imageUrl;

  factory SearchResultData.fromJson(Map<String, dynamic> json) =>
      SearchResultData(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        offerPrice: json["offerPrice"],
        thumbUrl: List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<dynamic>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "offerPrice": offerPrice,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
