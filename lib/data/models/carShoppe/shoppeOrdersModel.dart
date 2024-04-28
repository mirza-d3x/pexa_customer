// To parse this JSON data, do
//
//     final shoppeOrderModel = shoppeOrderModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/data/models/product_details.dart';

ShoppeOrderModel shoppeOrderModelFromJson(String str) =>
    ShoppeOrderModel.fromJson(json.decode(str));

String shoppeOrderModelToJson(ShoppeOrderModel data) =>
    json.encode(data.toJson());

class ShoppeOrderModel {
  ShoppeOrderModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ShoppeOrderDetail>? resultData;

  factory ShoppeOrderModel.fromJson(Map<String, dynamic> json) =>
      ShoppeOrderModel(
        status: json["status"],
        message: json["message"],
        resultData: List<ShoppeOrderDetail>.from(
            json["resultData"].map((x) => ShoppeOrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class ShoppeOrderDetail {
  ShoppeOrderDetail({
    this.item,
    this.id,
    this.user,
    this.orderId,
    this.vendor,
    this.total,
    this.deliveryCharge,
    this.grandTotal,
    this.paymentType,
    this.status,
    this.address,
    this.location,
    this.discountAmount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Item? item;
  String? id;
  User? user;
  String? orderId;
  String? vendor;
  num? total;
  num? deliveryCharge;
  num? grandTotal;
  String? paymentType;
  String? status;
  Address? address;
  List<dynamic>? location;
  num? discountAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory ShoppeOrderDetail.fromJson(Map<String, dynamic> json) =>
      ShoppeOrderDetail(
        item: Item.fromJson(json["item"]),
        id: json["_id"],
        user: User.fromJson(json["user"]),
        orderId: json["order_id"],
        vendor: json["vendor"],
        total: json["total"],
        deliveryCharge: json["delivery_charge"],
        grandTotal: json["grandTotal"],
        paymentType: json["paymentType"],
        status: json["status"],
        address: Address.fromJson(json["address"]),
        location: List<dynamic>.from(json["location"].map((x) => x)),
        discountAmount: json["discountAmount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "item": item!.toJson(),
        "_id": id,
        "user": user!.toJson(),
        "order_id": orderId,
        "vendor": vendor,
        "total": total,
        "delivery_charge": deliveryCharge,
        "grandTotal": grandTotal,
        "paymentType": paymentType,
        "status": status,
        "address": address!.toJson(),
        "location": List<dynamic>.from(location!.map((x) => x)),
        "discountAmount": discountAmount,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Item {
  Item({
    this.type,
    this.itemId,
    this.count,
  });

  String? type;
  ProductId? itemId;
  num? count;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        type: json["type"],
        itemId: ProductId.fromJson(json["item_id"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "item_id": itemId!.toJson(),
        "count": count,
      };
}

class ItemId {
  ItemId({
    this.deliverable,
    this.offerId,
    this.id,
    this.name,
    this.userId,
    this.price,
    this.modelId,
    this.categoryId,
    this.subCategoryId,
    this.images,
    this.thumbnail,
    this.description,
    this.quantity,
    this.offerPrice,
    this.radius,
    this.isActive,
    this.sold,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  Deliverable? deliverable;
  dynamic offerId;
  String? id;
  String? name;
  String? userId;
  num? price;
  List<String>? modelId;
  String? categoryId;
  String? subCategoryId;
  List<String>? images;
  List<String>? thumbnail;
  String? description;
  num? quantity;
  num? offerPrice;
  num? radius;
  bool? isActive;
  num? sold;
  num? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory ItemId.fromJson(Map<String, dynamic> json) => ItemId(
        deliverable: Deliverable.fromJson(json["deliverable"]),
        offerId: json["offerId"],
        id: json["_id"],
        name: json["name"],
        userId: json["user_id"],
        price: json["price"],
        modelId: List<String>.from(json["model_id"].map((x) => x)),
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        description: json["description"],
        quantity: json["quantity"],
        offerPrice: json["offerPrice"],
        radius: json["radius"],
        isActive: json["isActive"],
        sold: json["sold"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "deliverable": deliverable!.toJson(),
        "offerId": offerId,
        "_id": id,
        "name": name,
        "user_id": userId,
        "price": price,
        "model_id": List<dynamic>.from(modelId!.map((x) => x)),
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "description": description,
        "quantity": quantity,
        "offerPrice": offerPrice,
        "radius": radius,
        "isActive": isActive,
        "sold": sold,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}

class Deliverable {
  Deliverable({
    this.coordinates,
  });

  List<List<List<double>>>? coordinates;

  factory Deliverable.fromJson(Map<String, dynamic> json) => Deliverable(
        coordinates: List<List<List<double>>>.from(json["coordinates"].map(
            (x) => List<List<double>>.from(
                x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) =>
            List<dynamic>.from(
                x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
      };
}

class User {
  User({
    this.id,
    this.role,
    this.name,
    this.email,
    this.phone,
  });

  String? id;
  List<Role>? role;
  String? name;
  String? email;
  String? phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": List<dynamic>.from(role!.map((x) => x.toJson())),
        "name": name,
        "email": email,
        "phone": phone,
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
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
