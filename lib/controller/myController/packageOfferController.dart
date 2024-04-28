import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/coupenCheckApi.dart';
import 'package:shoppe_customer/data/models/all_offers_model/all_offers_model.dart';
import 'package:shoppe_customer/data/models/all_offers_model/result_data.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class PackageOfferController extends GetxController implements GetxService {
  final CouponApi? couponApi;
  PackageOfferController({this.couponApi});
  OffersResultData? allOffersModel;
  LoaderHelper loaderHelper = LoaderHelper();

  var offerList = [].obs;

  getAllOfers() async {
    loaderHelper.startLoader();
    update();
    Response response = await (couponApi!.getAllOffers());
    if (response.statusCode == 200) {
      offerList.clear();
      allOffersModel = AllOffersModel.fromJson(response.body).resultData;
      if (allOffersModel!.carspa != null) {
        for (var element in allOffersModel!.carspa!) {
          offerList.add(element.toJson());
        }
      }
      if (allOffersModel!.mechanical != null) {
        for (var element in allOffersModel!.mechanical!) {
          offerList.add(element.toJson());
        }
      }
      if (allOffersModel!.product != null) {
        for (var element in allOffersModel!.product!) {
          offerList.add(element.toJson());
        }
      }
      if (allOffersModel!.quickhelp != null) {
        for (var element in allOffersModel!.quickhelp!) {
          offerList.add(element.toJson());
        }
      }
      offerList.shuffle();
    } else {
      return null;
    }
    loaderHelper.cancelLoader();
    update();
  }
}
