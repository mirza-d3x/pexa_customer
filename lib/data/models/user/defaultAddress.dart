// To parse this JSON data, do
//
//     final defaultAddressModel = defaultAddressModelFromJson(jsonString);

import 'dart:convert';

DefaultAddressModel defaultAddressModelFromJson(String str) =>
    DefaultAddressModel.fromJson(json.decode(str));

String defaultAddressModelToJson(DefaultAddressModel data) =>
    json.encode(data.toJson());

class DefaultAddressModel {
  DefaultAddressModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  DefaultAddressResultData? resultData;

  factory DefaultAddressModel.fromJson(Map<String, dynamic> json) =>
      DefaultAddressModel(
        status: json["status"],
        message: json["message"],
        resultData: DefaultAddressResultData.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class DefaultAddressResultData {
  DefaultAddressResultData({
    this.id,
    this.name,
    this.mobile,
    this.house,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.type,
    this.location,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isDefault,
  });

  String? id;
  String? name;
  String? mobile;
  String? house;
  String? street;
  String? city;
  String? state;
  String? pincode;
  String? type;
  List<double>? location;
  String? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  bool? isDefault;

  factory DefaultAddressResultData.fromJson(Map<String, dynamic> json) =>
      DefaultAddressResultData(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"].toString(),
        house: json["house"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"].toString(),
        type: json["type"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "house": house,
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "type": type,
        "location": List<dynamic>.from(location!.map((x) => x)),
        "user": user,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "isDefault": isDefault,
      };
}
