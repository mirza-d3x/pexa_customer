// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

import 'package:shoppe_customer/data/models/product_details.dart';
import 'package:shoppe_customer/data/models/user/userDetails.dart';

CartListModel cartListModelFromJson(String str) =>
    CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
  CartListModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  CartListResultData? resultData;

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        status: json["status"],
        message: json["message"],
        resultData: CartListResultData.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class CartListResultData {
  CartListResultData({
    this.cartItems,
    this.total,
    this.user,
    this.shipping,
    this.grandTotal,
    this.availableModes,
  });

  List<CartItem>? cartItems;
  num? total;
  User? user;
  num? shipping;
  num? grandTotal;
  PaymentModesModel? availableModes;

  factory CartListResultData.fromJson(Map<String, dynamic> json) =>
      CartListResultData(
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
        total: json["total"],
        user: User.fromJson(json["user"]),
        shipping: json["shipping"],
        grandTotal: json["grandTotal"],
        availableModes: json["availableModes"] != null
            ? PaymentModesModel.fromJson(json["availableModes"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "cartItems": List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "total": total,
        "user": user!.toJson(),
        "shipping": shipping,
        "grandTotal": grandTotal,
        "availableModes": availableModes,
      };
}

class CartItem {
  CartItem({
    this.id,
    this.product,
    this.user,
    this.v,
    this.count,
    this.createdAt,
    this.updatedAt,
    this.total,
  });

  String? id;
  ProductId? product;
  String? user;
  num? v;
  num? count;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? total;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json["_id"],
        product: ProductId.fromJson(json["product"]),
        user: json["user"],
        v: json["__v"],
        count: json["count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product": product!.toJson(),
        "user": user,
        "__v": v,
        "count": count,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "total": total,
      };
}
