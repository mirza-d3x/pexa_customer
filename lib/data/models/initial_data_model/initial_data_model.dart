// To parse this JSON data, do
//
//     final initialDataModel = initialDataModelFromJson(jsonString);

import 'dart:convert';

InitialDataModel initialDataModelFromJson(String str) =>
    InitialDataModel.fromJson(json.decode(str));

String initialDataModelToJson(InitialDataModel data) =>
    json.encode(data.toJson());

class InitialDataModel {
  InitialDataModel({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  List<ResultDatum>? resultData;

  factory InitialDataModel.fromJson(Map<String, dynamic> json) =>
      InitialDataModel(
        status: json["status"],
        message: json["message"],
        resultData: json["resultData"] == null
            ? null
            : List<ResultDatum>.from(
                json["resultData"].map((x) => ResultDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData == null
            ? null
            : List<dynamic>.from(resultData!.map((x) => x.toJson())),
      };
}

class ResultDatum {
  ResultDatum({
    this.id,
    this.type,
    this.value,
    this.v,
  });

  String? id;
  String? type;
  String? value;
  int? v;

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
        id: json["_id"],
        type: json["type"],
        value: json["value"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "value": value,
        "__v": v,
      };
}
