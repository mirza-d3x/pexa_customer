import 'package:shoppe_customer/data/models/addon_model.dart';

class ServiceId {
  ServiceId({
    this.id,
    this.name,
    this.categoryId,
    this.carType,
    this.images,
    this.thumbnails,
    this.isActive,
    this.price,
    this.addOns,
    this.description,
    this.list,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
    this.urlId,
  });

  String? id;
  String? name;
  String? categoryId;
  String? carType;
  List<String>? images;
  List<String>? thumbnails;
  bool? isActive;
  num? price;
  List<AddOn>? addOns;
  String? description;
  String? list;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;
  List<String>? urlId;
  factory ServiceId.fromJson(Map<String, dynamic> json) => ServiceId(
        id: json["_id"],
        name: json["name"],
        categoryId: json["categoryId"],
        carType: json["carType"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnails: List<String>.from(json["thumbnails"].map((x) => x)),
        isActive: json["isActive"],
        price: json["price"],
        addOns: List<AddOn>.from(json["addOns"].map((x) => AddOn.fromJson(x))),
        description: json["description"],
        list: json["list"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "categoryId": categoryId,
        "carType": carType,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x)),
        "isActive": isActive,
        "price": price,
        "addOns": List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "description": description,
        "list": list,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
