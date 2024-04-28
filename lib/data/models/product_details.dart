import 'package:shoppe_customer/data/models/sub_category_model.dart';

class ProductId {
  ProductId({
    //this.deliverable,
    this.id,
    this.name,
    this.userId,
    this.price,
    this.modelId,
    this.categoryId,
    this.subCategoryId,
    this.modes,
    this.vendor,
    this.images,
    this.thumbnail,
    this.description,
    this.quantity,
    this.offerPrice,
    this.radius,
    this.isActive,
    this.sold,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
    this.offerId,
    this.thumbUrl,
    this.imageUrl,
  });

  //Deliverable deliverable;
  String? id;
  String? name;
  String? userId;
  num? price;
  List<String>? modelId;
  String? categoryId;
  SubCategoryId? subCategoryId;
  List<String>? images;
  List<String>? thumbnail;
  String? description;
  String? vendor;
  PaymentModesModel? modes;
  num? quantity;
  num? offerPrice;
  num? radius;
  bool? isActive;
  num? sold;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  num? status;
  dynamic offerId;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        // deliverable: Deliverable.fromJson(json["deliverable"]),
        id: json["_id"],
        name: json["name"],
        userId: json["user_id"],
        price: json["price"],
        // modelId: List<String>.from(json["model_id"].map((x) => x)),
        vendor: json["vendor"],
        modes: json["modes"] != null
            ? PaymentModesModel.fromJson(json["modes"])
            : null,
        categoryId: json["category_id"],
        subCategoryId: json["sub_category_id"] != null
            ? json["sub_category_id"].runtimeType == String
                ? SubCategoryId(categoryId: json["sub_category_id"])
                : SubCategoryId.fromJson(json["sub_category_id"])
            : "" as SubCategoryId?,
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        description: json["description"],
        quantity: json["quantity"],
        offerPrice: json["offerPrice"] ?? 0,
        radius: json["radius"],
        isActive: json["isActive"],
        sold: json["sold"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        status: json["status"],
        offerId: json["offerId"],
        thumbUrl: json["thumbURL"] != null
            ? List<String>.from(json["thumbURL"].map((x) => x))
            : null,
        imageUrl: json["imageURL"] != null
            ? List<String>.from(json["imageURL"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        // "deliverable": deliverable.toJson(),
        "_id": id,
        "name": name,
        "user_id": userId,
        "price": price,
        "model_id": List<dynamic>.from(modelId!.map((x) => x)),
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "vendor": vendor,
        "modes": modes,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "description": description,
        "quantity": quantity,
        "offerPrice": offerPrice,
        "radius": radius,
        "isActive": isActive,
        "sold": sold,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "status": status,
        "offerId": offerId,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}

class PaymentModesModel {
  PaymentModesModel({
    this.cod,
    this.online,
  });

  bool? cod;
  bool? online;

  factory PaymentModesModel.fromJson(Map<String, dynamic> json) =>
      PaymentModesModel(
        cod: json["COD"] ?? false,
        online: json["online"] ?? json["Online"],
      );

  Map<String, dynamic> toJson() => {
        "COD": cod,
        "online": online,
      };
}
