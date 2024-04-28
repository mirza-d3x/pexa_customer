// To parse this JSON data, do
//
//     final featuredProducts = featuredProductsFromJson(jsonString);

// FeaturedProducts featuredProductsFromJson(String str) =>
//     FeaturedProducts.fromJson(json.decode(str));

// String featuredProductsToJson(FeaturedProducts data) =>
//     json.encode(data.toJson());

import 'package:shoppe_customer/data/models/product_details.dart';

class FeaturedProducts {
  FeaturedProducts({
    this.status,
    this.resultData,
  });

  String? status;
  List<FeaturedProduct>? resultData;

  factory FeaturedProducts.fromJson(Map<String, dynamic> json) =>
      FeaturedProducts(
        status: json["status"],
        resultData: List<FeaturedProduct>.from(
            json["resultData"].map((x) => FeaturedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "resultData": List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class FeaturedProduct {
  FeaturedProduct({
    this.id,
    this.type,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? type;
  ProductId? productId;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) =>
      FeaturedProduct(
        id: json["_id"],
        type: json["type"],
        productId: ProductId.fromJson(json["productId"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "productId": productId!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}


// class Deliverable {
//     Deliverable({
//         this.coordinates,
//     });

//     List<List<List<double>>> coordinates;

//     factory Deliverable.fromJson(Map<String, dynamic> json) => Deliverable(
//         coordinates: List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
//     );

//     Map<String, dynamic> toJson() => {
//         "coordinates": List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
//     };
// }
