import 'package:shoppe_customer/data/models/addon_model.dart';

class CompletedReportClass {
  CompletedReportClass({
    this.serviceId,
    this.addOns,
    this.grandTotal,
  });

  String? serviceId;
  List<AddOn>? addOns;
  int? grandTotal;

  factory CompletedReportClass.fromJson(Map<String, dynamic> json) =>
      CompletedReportClass(
        serviceId: json["serviceId"],
        addOns: json["addOn"] != null
            ? List<AddOn>.from(json["addOn"].map((x) => AddOn.fromJson(x)))
            : [],
        grandTotal: json["grandTotal"],
      );

  Map<String, dynamic> toJson() => {
        "serviceId": serviceId,
        "addOns": List<dynamic>.from(addOns!.map((x) => x.toJson())),
        "grandTotal": grandTotal,
      };
}
