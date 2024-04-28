class ProductOffers {
  String? id;
  String? title;
  String? description;
  List<dynamic>? productId;
  String? offerType;
  int? offerAmount;
  String? status;
  int? v;

  ProductOffers({
    this.id,
    this.title,
    this.description,
    this.productId,
    this.offerType,
    this.offerAmount,
    this.status,
    this.v,
  });

  factory ProductOffers.fromJson(Map<String, dynamic> json) => ProductOffers(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        productId: json['productId'] as List<dynamic>?,
        offerType: json['offerType'] as String?,
        offerAmount: json['offerAmount'] as int?,
        status: json['status'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'productId': productId,
        'offerType': offerType,
        'offerAmount': offerAmount,
        'status': status,
        '__v': v,
      };
}
