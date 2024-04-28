class BranchDetails {
  BranchDetails({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.images,
  });

  String? id;
  String? name;
  String? address;
  int? phone;
  List<String>? images;

  factory BranchDetails.fromJson(Map<String, dynamic> json) => BranchDetails(
        id: json["_id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        images: json["images"] != null && json["images"].length > 0
            ? List<String>.from(json["images"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "address": address,
        "phone": phone,
        "images": List<String>.from(images!.map((x) => x)),
      };
}
