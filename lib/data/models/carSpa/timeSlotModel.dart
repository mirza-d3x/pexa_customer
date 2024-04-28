// To parse this JSON data, do
//
//     final timeSlotModel = timeSlotModelFromJson(jsonString);

import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    this.status,
    this.message,
    this.result,
  });

  String? status;
  String? message;
  List<String>? result;

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) => TimeSlotModel(
        status: json["status"],
        message: json["message"],
        result: List<String>.from(json["result"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result!.map((x) => x)),
      };
}
