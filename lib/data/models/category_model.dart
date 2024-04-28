class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
    this.images,
    this.thumbnails,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
    this.assetImage
  });

  String? id;
  String? name;
  List<String>? images;
  List<String>? thumbnails;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;
  String? assetImage;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnails: json["thumbnails"] != null
            ? List<String>.from(json["thumbnails"].map((x) => x))
            : json["thumbnail"] != null
                ? List<String>.from(json["thumbnail"].map((x) => x))
                : [],
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        thumbUrl: List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnails": List<dynamic>.from(thumbnails!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "thumbURL": List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
