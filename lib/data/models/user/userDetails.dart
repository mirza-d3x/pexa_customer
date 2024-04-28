// To parse this JSON data, do
//
//     final userDetails = userDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/address_model.dart';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  User? resultData;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        status: json["status"],
        message: json["message"],
        resultData: User.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class User {
  User({
    this.id,
    this.phone,
    this.v,
    this.createdAt,
    this.isActive,
    this.isTfaEnabled,
    this.loginAttempt,
    this.loginDate,
    this.otpCode,
    this.otpCreatedDate,
    this.provides,
    this.role,
    this.rpToken,
    this.rpTokenCreatedDate,
    this.tfaOtpAuthUrl,
    this.tfaSecretBase32,
    this.tfaSecretHex,
    this.updatedAt,
    this.userToken,
    this.carType,
    this.modelId,
    this.email,
    this.name,
    this.addresses,
  });

  String? id;
  String? phone;
  num? v;
  DateTime? createdAt;
  bool? isActive;
  bool? isTfaEnabled;
  num? loginAttempt;
  DateTime? loginDate;
  String? otpCode;
  DateTime? otpCreatedDate;
  List<dynamic>? provides;
  dynamic role;
  dynamic rpToken;
  dynamic rpTokenCreatedDate;
  dynamic tfaOtpAuthUrl;
  dynamic tfaSecretBase32;
  dynamic tfaSecretHex;
  DateTime? updatedAt;
  String? userToken;
  String? carType;
  String? modelId;
  String? email;
  String? name;
  List<Address>? addresses;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        phone: json["phone"],
        v: json["__v"],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        isActive: json["isActive"],
        isTfaEnabled: json["isTFAEnabled"],
        loginAttempt: json["loginAttempt"],
        loginDate: json["loginDate"] != null
            ? DateTime.parse(json["loginDate"])
            : null,
        otpCode: json["otpCode"],
        otpCreatedDate: json["otpCreatedDate"] != null
            ? DateTime.parse(json["otpCreatedDate"])
            : null,
        provides: json["provides"] != null
            ? List<dynamic>.from(json["provides"].map((x) => x))
            : null,
        role: json["role"] != null
            ? List<Role>.from(json["role"].map((x) => x.runtimeType == String
                ? Role(id: json["role"][0])
                : Role.fromJson(x)))
            : [],
        rpToken: json["rpToken"],
        rpTokenCreatedDate: json["rpTokenCreatedDate"],
        tfaOtpAuthUrl: json["tfaOTPAuthUrl"],
        tfaSecretBase32: json["tfaSecretBase32"],
        tfaSecretHex: json["tfaSecretHex"],
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        userToken: json["userToken"],
        carType: json["carType"],
        modelId: json["model_id"],
        email: json["email"],
        name: json["name"],
        addresses: json["addresses"] == null
            ? null
            : List<Address>.from(
                json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "__v": v,
        "createdAt": createdAt!.toIso8601String(),
        "isActive": isActive,
        "isTFAEnabled": isTfaEnabled,
        "loginAttempt": loginAttempt,
        "loginDate": loginDate!.toIso8601String(),
        "otpCode": otpCode,
        "otpCreatedDate": otpCreatedDate!.toIso8601String(),
        "provides": List<dynamic>.from(provides!.map((x) => x)),
        "role": List<dynamic>.from(role.map((x) => x.toJson())),
        "rpToken": rpToken,
        "rpTokenCreatedDate": rpTokenCreatedDate,
        "tfaOTPAuthUrl": tfaOtpAuthUrl,
        "tfaSecretBase32": tfaSecretBase32,
        "tfaSecretHex": tfaSecretHex,
        "updatedAt": updatedAt!.toIso8601String(),
        "userToken": userToken,
        "carType": carType,
        "model_id": modelId,
        "email": email,
        "name": name,
        "addresses": addresses == null
            ? null
            : List<dynamic>.from(addresses!.map((x) => x.toJson())),
      };
}

class Role {
  Role({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"] ?? (json.runtimeType == String
                ? json as String?
                : ""),
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
