// To parse this JSON data, do
//
//     final initializePayment = initializePaymentFromJson(jsonString);

import 'dart:convert';

InitializePayment initializePaymentFromJson(String str) =>
    InitializePayment.fromJson(json.decode(str));

String initializePaymentToJson(InitializePayment data) =>
    json.encode(data.toJson());

class InitializePayment {
  InitializePayment({
    this.status,
    this.message,
    this.resultData,
  });

  String? status;
  String? message;
  paymentResponseModel? resultData;

  factory InitializePayment.fromJson(Map<String, dynamic> json) =>
      InitializePayment(
        status: json["status"],
        message: json["message"],
        resultData: paymentResponseModel.fromJson(json["resultData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "resultData": resultData!.toJson(),
      };
}

class paymentResponseModel {
  paymentResponseModel({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  String? id;
  String? entity;
  num? amount;
  num? amountPaid;
  num? amountDue;
  String? currency;
  String? receipt;
  dynamic offerId;
  String? status;
  num? attempts;
  List<dynamic>? notes;
  num? createdAt;

  factory paymentResponseModel.fromJson(Map<String, dynamic> json) =>
      paymentResponseModel(
        id: json["id"],
        entity: json["entity"],
        amount: json["amount"],
        amountPaid: json["amount_paid"],
        amountDue: json["amount_due"],
        currency: json["currency"],
        receipt: json["receipt"],
        offerId: json["offer_id"],
        status: json["status"],
        attempts: json["attempts"],
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt,
        "offer_id": offerId,
        "status": status,
        "attempts": attempts,
        "notes": List<dynamic>.from(notes!.map((x) => x)),
        "created_at": createdAt,
      };
}
