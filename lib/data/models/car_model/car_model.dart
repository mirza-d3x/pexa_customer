import 'result_data.dart';

class CarModel {
  String? status;
  String? message;
  ResultData? resultData;

  CarModel({this.status, this.message, this.resultData});

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        status: json['status'] as String?,
        message: json['message'] as String?,
        resultData: json['resultData'] == null
            ? null
            : ResultData.fromJson(json['resultData'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'resultData': resultData?.toJson(),
      };
}
