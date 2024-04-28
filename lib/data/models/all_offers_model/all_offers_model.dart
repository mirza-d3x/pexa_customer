import 'result_data.dart';

class AllOffersModel {
  String? status;
  String? message;
  OffersResultData? resultData;

  AllOffersModel({this.status, this.message, this.resultData});

  factory AllOffersModel.fromJson(Map<String, dynamic> json) {
    return AllOffersModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      resultData: json['resultData'] == null
          ? null
          : OffersResultData.fromJson(
              json['resultData'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'resultData': resultData?.toJson(),
      };
}
