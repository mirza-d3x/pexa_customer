import 'package:shoppe_customer/data/models/offer_model.dart';

class OffersResultData {
  List<OfferModel>? mechanical;
  List<OfferModel>? product;
  List<OfferModel>? quickhelp;
  List<OfferModel>? carspa;

  OffersResultData(
      {this.mechanical, this.product, this.quickhelp, this.carspa});

  factory OffersResultData.fromJson(Map<String, dynamic> json) =>
      OffersResultData(
        mechanical: (json['mechanical'] as List<dynamic>?)
            ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        product: (json['product'] as List<dynamic>?)
            ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        quickhelp: (json['quickhelp'] as List<dynamic>?)
            ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        carspa: (json['carspa'] as List<dynamic>?)
            ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'mechanical': mechanical?.map((e) => e.toJson()).toList(),
        'product': product?.map((e) => e.toJson()).toList(),
        'quickhelp': quickhelp?.map((e) => e.toJson()).toList(),
        'carspa': carspa?.map((e) => e.toJson()).toList(),
      };
}
