class Make {
  String? id;
  String? name;
  List<dynamic>? images;
  List<dynamic>? thumbnail;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<dynamic>? thumbUrl;
  List<dynamic>? imageUrl;

  Make({
    this.id,
    this.name,
    this.images,
    this.thumbnail,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.thumbUrl,
    this.imageUrl,
  });

  factory Make.fromJson(Map<String, dynamic> json) => Make(
        id: json['_id'] as String?,
        name: json['name'] as String?,
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
        thumbUrl: json['thumbURL'] as List<dynamic>?,
        imageUrl: json['imageURL'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'images': images,
        'thumbnail': thumbnail,
        'isActive': isActive,
        'createdAt': createdAt!.toIso8601String(),
        'updatedAt': updatedAt!.toIso8601String(),
        '__v': v,
        'thumbURL': thumbUrl,
        'imageURL': imageUrl,
      };
}
