import 'package:shoppe_customer/data/models/addon_model.dart';
import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/data/models/feedback_model.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/data/models/service_order_completed_report_model.dart';

import 'worker_details/worker_details_model.dart';

class ServiceOrderModel {
  String? id;
  String? orderId;
  String? customerId;
  String? franchiseId;
  ServiceId? serviceId;
  String? timeSlot;
  num? price;
  String? mode;
  String? status;
  Address? address;
  List<AddOn>? addOn;
  DateTime? date;
  num? discountAmount;
  num? grandTotal;
  String? workerId;
  FeedbackModel? feedBack;
  WorkerDetails? workerDetails;
  CompletedReportClass? completedReport;
  String? paymentStatus;
  dynamic happyCode;
  dynamic happyCodeCreatedDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  ServiceOrderModel({
    this.id,
    this.orderId,
    this.customerId,
    this.franchiseId,
    this.serviceId,
    this.timeSlot,
    this.price,
    this.mode,
    this.status,
    this.address,
    this.addOn,
    this.date,
    this.discountAmount,
    this.grandTotal,
    this.paymentStatus,
    this.workerId,
    this.workerDetails,
    this.happyCode,
    this.happyCodeCreatedDate,
    this.feedBack,
    this.completedReport,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ServiceOrderModel.fromJson(Map<String, dynamic> json) =>
      ServiceOrderModel(
        id: json["_id"],
        orderId: json["orderId"],
        customerId: json["customerId"],
        franchiseId: json["franchiseId"],
        serviceId: ServiceId.fromJson(json["serviceId"]),
        timeSlot: json["timeSlot"],
        price: json["price"],
        mode: json["mode"],
        status: json["status"],
        address: Address.fromJson(json["address"]),
        addOn: List<AddOn>.from(json["addOn"].map((x) => AddOn.fromJson(x))),
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
        discountAmount: json["discountAmount"],
        grandTotal: json["grandTotal"],
        paymentStatus: json["paymentStatus"],
        workerId: json["workerId"],
        workerDetails: json["workerDetails"].length > 0
            ? WorkerDetails.fromJson(json["workerDetails"])
            : WorkerDetails(),
        happyCode: json["happyCode"],
        happyCodeCreatedDate: json["happyCodeCreatedDate"],
        feedBack: json["feedbackId"] != null
            ? FeedbackModel.fromJson(json["feedbackId"])
            : null,
        completedReport: json["completedReport"] != null
            ? CompletedReportClass.fromJson(json["completedReport"])
            : null,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": orderId,
        "customerId": customerId,
        "franchiseId": franchiseId,
        "serviceId": serviceId!.toJson(),
        "timeSlot": timeSlot,
        "price": price,
        "mode": mode,
        "status": status,
        "address": address!.toJson(),
        "addOn": List<dynamic>.from(addOn!.map((x) => x.toJson())),
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "discountAmount": discountAmount,
        "grandTotal": grandTotal,
        "paymentStatus": paymentStatus,
        "workerId": workerId,
        "feedbackId": feedBack!.toJson(),
        "workerDetails": workerDetails!.toJson(),
        "happyCode": happyCode,
        "happyCodeCreatedDate": happyCodeCreatedDate,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
