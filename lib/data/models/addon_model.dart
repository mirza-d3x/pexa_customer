class AddOn {
  AddOn({
    this.name,
    this.price,
    this.id,
  });

  String? name;
  num? price;
  String? id;

  factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        name: json["name"],
        price: json["price"],
        id: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "_id": id,
      };
}
