import 'make.dart';
import 'model.dart';

class ResultData {
  List<Make>? makes;
  List<Model>? models;

  ResultData({this.makes, this.models});

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        makes: (json['makes'] as List<dynamic>)
            .map((e) => Make.fromJson(e as Map<String, dynamic>))
            .toList(),
        models: (json['models'] as List<dynamic>)
            .map((e) => Model.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'makes': makes!.map((e) => e.toJson()).toList(),
        'models': models!.map((e) => e.toJson()).toList(),
      };
}
