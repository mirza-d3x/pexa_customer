import 'package:shoppe_customer/data/models/user/userDetails.dart';

class AddressListModel {
  AddressListModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<Address>? resultData;

  factory AddressListModel.fromJson(Map<String, dynamic> json) =>
      AddressListModel(
        status: json["status"],
        message: json["message"],
        resultData: List<Address>.from(
            json["resultData"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.name,
    this.mobile,
    this.altPhone,
    this.house,
    this.street,
    this.city,
    this.state,
    this.pincode,
    this.landmark,
    this.type,
    this.location,
    this.user,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? mobile;
  String? altPhone;
  String? house;
  String? street;
  String? city;
  String? state;
  String? pincode;
  String? landmark;
  String? type;
  List<double>? location;
  User? user;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["_id"],
        name: json["name"],
        mobile: json["mobile"].toString(),
        altPhone: json["altPhone"] != null ? json["altPhone"].toString() : "",
        house: json["house"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"].toString(),
        landmark: json["landmark"],
        type: json["type"],
        location: List<double>.from(json["location"].map((x) => x.toDouble())),
        user: json["user"] != null
            ? json["user"].runtimeType == String
                ? User(id: json["user"])
                : User.fromJson(json["user"])
            : User(),
        isDefault: json["isDefault"] ?? false,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "mobile": mobile,
        "altPhone": altPhone,
        "house": house,
        "street": street,
        "city": city,
        "state": state,
        "pincode": pincode,
        "landmark": landmark,
        "type": type,
        "location": List<dynamic>.from(location!.map((x) => x)),
        "user": user,
        "isDefault": isDefault,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
