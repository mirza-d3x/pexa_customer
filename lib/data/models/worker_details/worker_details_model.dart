import 'package:shoppe_customer/data/models/location_model.dart';
import 'package:shoppe_customer/data/models/ratings_model.dart';
import 'package:shoppe_customer/data/models/worker_details/branch_details.dart';

class WorkerDetails {
  WorkerDetails({
    this.id,
    this.name,
    this.branchId,
    this.location,
    this.ratings,
    this.createdAt,
  });

  String? id;
  String? name;
  BranchDetails? branchId;
  LocationDetails? location;
  Ratings? ratings;
  DateTime? createdAt;

  factory WorkerDetails.fromJson(Map<String, dynamic> json) => WorkerDetails(
        id: json["_id"],
        name: json["name"],
        branchId: BranchDetails.fromJson(json["branchId"]),
        location: LocationDetails.fromJson(json["location"]),
        ratings: json["ratings"] != null
            ? Ratings.fromJson(json["ratings"])
            : Ratings(),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "branchId": branchId!.toJson(),
        "location": location!.toJson(),
        "ratings": ratings!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
      };
}
