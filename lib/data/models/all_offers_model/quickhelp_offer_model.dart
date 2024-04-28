class QuickhelpOffers {
  String? id;
  String? title;
  String? description;
  List<dynamic>? serviceId;
  int? maxAmount;
  int? minAmount;
  String? offerType;
  int? offerAmount;
  String? status;
  int? v;

  QuickhelpOffers({
    this.id,
    this.title,
    this.description,
    this.serviceId,
    this.maxAmount,
    this.minAmount,
    this.offerType,
    this.offerAmount,
    this.status,
    this.v,
  });

  factory QuickhelpOffers.fromJson(Map<String, dynamic> json) =>
      QuickhelpOffers(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        serviceId: json['serviceId'] as List<dynamic>?,
        maxAmount: json['maxAmount'] as int?,
        minAmount: json['minAmount'] as int?,
        offerType: json['offerType'] as String?,
        offerAmount: json['offerAmount'] as int?,
        status: json['status'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'description': description,
        'serviceId': serviceId,
        'maxAmount': maxAmount,
        'minAmount': minAmount,
        'offerType': offerType,
        'offerAmount': offerAmount,
        'status': status,
        '__v': v,
      };
}
