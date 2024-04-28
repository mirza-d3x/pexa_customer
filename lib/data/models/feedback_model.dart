class FeedbackModel {
  FeedbackModel({
    this.id,
    this.orderId,
    this.v,
    this.createdAt,
    this.customerId,
    this.description,
    this.rating,
    this.updatedAt,
    this.workerId,
  });

  String? id;
  String? orderId;
  int? v;
  DateTime? createdAt;
  String? customerId;
  String? description;
  int? rating;
  DateTime? updatedAt;
  String? workerId;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        id: json["_id"],
        orderId: json["orderId"],
        v: json["__v"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        customerId: json["customerId"],
        description: json["description"],
        rating: json["rating"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        workerId: json["workerId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "__v": v,
        "createdAt": createdAt?.toIso8601String(),
        "customerId": customerId,
        "description": description,
        "rating": rating,
        "updatedAt": updatedAt?.toIso8601String(),
        "workerId": workerId,
      };
}
