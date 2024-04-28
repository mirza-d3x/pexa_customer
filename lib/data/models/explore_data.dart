class ExploreData {
  ExploreData({
    this.id,
    this.name,
    this.assetType,
    this.images,
    this.thumbnail,
    this.categoryId,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  String? id;
  String? name;
  String? assetType;
  List<String>? images;
  List<String>? thumbnail;
  String? categoryId;
  int? v;
  List<String>? thumbUrl;
  List<String>? imageUrl;

  factory ExploreData.fromJson(Map<String, dynamic> json) => ExploreData(
        id: json["_id"],
        name: json["name"],
        assetType: json["assetType"],
        images: json["images"] == null
            ? null
            : List<String>.from(json["images"].map((x) => x)),
        thumbnail: json["thumbnail"] == null
            ? null
            : List<String>.from(json["thumbnail"].map((x) => x)),
        categoryId: json["categoryId"],
        v: json["__v"],
        thumbUrl: json["thumbURL"] == null
            ? null
            : List<String>.from(json["thumbURL"].map((x) => x)),
        imageUrl: json["imageURL"] == null
            ? null
            : List<String>.from(json["imageURL"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "assetType": assetType,
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "thumbnail": thumbnail == null
            ? null
            : List<dynamic>.from(thumbnail!.map((x) => x)),
        "categoryId": categoryId,
        "__v": v,
        "thumbURL": thumbUrl == null
            ? null
            : List<dynamic>.from(thumbUrl!.map((x) => x)),
        "imageURL": imageUrl == null
            ? null
            : List<dynamic>.from(imageUrl!.map((x) => x)),
      };
}
