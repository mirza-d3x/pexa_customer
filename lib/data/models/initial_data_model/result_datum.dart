class ResultDatum {
  String? id;
  String? type;
  String? value;
  int? v;

  ResultDatum({this.id, this.type, this.value, this.v});

  factory ResultDatum.fromJson(Map<String, dynamic> json) => ResultDatum(
        id: json['_id'] as String?,
        type: json['type'] as String?,
        value: json['value'] as String?,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'type': type,
        'value': value,
        '__v': v,
      };
}
