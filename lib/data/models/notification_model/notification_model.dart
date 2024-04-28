// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.id,
    this.userId,
    this.read,
    this.title,
    this.description,
    this.images,
    this.assetType,
    this.orderId,
    this.orderDocId,
    this.userType,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? userId;
  bool? read;
  String? title;
  String? description;
  List<String>? images;
  String? assetType;
  String? orderId;
  String? orderDocId;
  String? userType;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<dynamic>? thumbUrl;
  List<String>? imageUrl;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["_id"],
        userId: json["userId"],
        read: json["read"],
        title: json["title"],
        description: json["description"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        assetType: json["assetType"],
        orderId: json["orderId"],
        orderDocId: json["orderDocId"],
        userType: json["userType"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<dynamic>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "read": read,
        "title": title,
        "description": description,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "assetType": assetType,
        "orderId": orderId,
        "orderDocId": orderDocId,
        "userType": userType,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
