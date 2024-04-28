// To parse this JSON data, do
//
//     final fetchBanner = fetchBannerFromJson(jsonString);

import 'dart:convert';

FetchBanner fetchBannerFromJson(String str) =>
    FetchBanner.fromJson(json.decode(str));

String fetchBannerToJson(FetchBanner data) => json.encode(data.toJson());

class FetchBanner {
  FetchBanner({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  BannerImage? resultData;

  factory FetchBanner.fromJson(Map<String, dynamic> json) => FetchBanner(
        status: json["status"],
        message: json["message"],
        resultData: BannerImage.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class BannerImage {
  BannerImage({
    this.id,
    this.name,
    this.images,
    this.thumbnail,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  List<String>? images;
  List<String>? thumbnail;
  num? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
        id: json["_id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        v: json["__v"],
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "__v": v,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
