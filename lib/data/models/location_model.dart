class LocationDetails {
  LocationDetails({
    this.type,
    this.coordinates,
    this.id,
  });

  String? type;
  List<double>? coordinates;
  String? id;

  factory LocationDetails.fromJson(Map<String, dynamic> json) =>
      LocationDetails(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "_id": id,
      };
}
