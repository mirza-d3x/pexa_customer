class Model {
  String? id;
  String? name;
  String? makeId;
  List<dynamic>? images;
  List<dynamic>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? carType;
  List<dynamic>? thumbUrl;
  List<dynamic>? imageUrl;

  Model({
    this.id,
    this.name,
    this.makeId,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.carType,
    this.thumbUrl,
    this.imageUrl,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        makeId: json['make_id'] as String?,
        images: json['images'] as List<dynamic>?,
        thumbnail: json['thumbnail'] as List<dynamic>?,
        isActive: json['isActive'] as bool?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
        carType: json['carType'] as String?,
        thumbUrl: json['thumbURL'] as List<dynamic>?,
        imageUrl: json['imageURL'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'make_id': makeId,
        'images': images,
        'thumbnail': thumbnail,
        'isActive': isActive,
        'createdAt': createdAt!.toIso8601String(),
        'updatedAt': updatedAt!.toIso8601String(),
        '__v': v,
        'carType': carType,
        'thumbURL': thumbUrl,
        'imageURL': imageUrl,
      };
}
