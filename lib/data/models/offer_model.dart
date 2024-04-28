class OfferModel {
  OfferModel({
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

  String? id;
  String? title;
  String? description;
  List<String>? serviceId;
  num? maxAmount;
  num? minAmount;
  String? offerType;
  num? offerAmount;
  String? status;
  num? v;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        serviceId: List<String>.from(json["serviceId"].map((x) => x)),
        maxAmount: json["maxAmount"],
        minAmount: json["minAmount"],
        offerType: json["offerType"],
        offerAmount: json["offerAmount"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "serviceId": List<dynamic>.from(serviceId!.map((x) => x)),
        "maxAmount": maxAmount,
        "minAmount": minAmount,
        "offerType": offerType,
        "offerAmount": offerAmount,
        "status": status,
        "__v": v,
      };
}
