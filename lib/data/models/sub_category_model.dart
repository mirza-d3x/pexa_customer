class SubCategoryId {
  SubCategoryId({
    this.id,
    this.name,
    this.categoryId,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? categoryId;
  List<String>? images;
  List<String>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SubCategoryId.fromJson(Map<String, dynamic> json) => SubCategoryId(
        id: json["_id"],
        name: json["name"],
        categoryId: json["category_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category_id": categoryId,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
