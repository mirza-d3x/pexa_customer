import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/data/repository/service_repo.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/data/models/category_model.dart';
import 'package:shoppe_customer/data/models/offer_model.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class MechanicalController extends GetxController implements GetxService {
  final ServiceRepo serviceRepo;
  final OrderApi orderApi;
  var mechanicalCategoryList = [].obs;
  var mechanicalServicesList = [].obs;
  var mechanicalServiceProperty = [].obs;
  var mechanicalAddOnTotal = 0.obs;
  var mechanicalAddOnRadioState = [].obs;
  var mechanicalAddOns = [].obs;
  var mechanicalTimeSlot = [].obs;
  var isFound = true.obs;
  var offerEmpty = false.obs;
  var mechanicalOffer = [].obs;
  var offerApplicable = false.obs;
  var offerCouponId = ''.obs;
  var discountedAmount = 0.0.obs;
  var discount = 0.0.obs;
  LoaderHelper loaderHelper = LoaderHelper();

  MechanicalController({required this.serviceRepo, required this.orderApi});

  Future getMechanicalCategory() async {
    loaderHelper.startLoader();
    update();
    if (mechanicalCategoryList.isNotEmpty) {
      mechanicalCategoryList.clear();
    }
    Response response = await serviceRepo.getAllServiceCategory(
        mainCategory: MainCategory.MECHANICAL);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        mechanicalCategoryList.add(CategoryModel.fromJson(element));
      });
      update();
    }
    loaderHelper.cancelLoader();
    update();
  }

  Future getMechanicalServiceWithCatId(String catId) async {
    loaderHelper.startLoader();
    update();
    if (mechanicalServicesList.isNotEmpty) {
      mechanicalServicesList.clear();
      update();
    }
    var response = await serviceRepo.getServiceList(
        catId: catId,
        mainCategory: MainCategory.MECHANICAL,
        carType: Get.find<AuthFactorsController>().userDetails!.carType);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        mechanicalServicesList.add(ServiceId.fromJson(element));
      });
      setList();
    }
    loaderHelper.cancelLoader();
    update();
  }

  setList() {
    if (mechanicalServiceProperty.isNotEmpty) {
      mechanicalServiceProperty.clear();
      update();
    }
    for (var element in mechanicalServicesList) {
      int num = ','.allMatches(element.list).length;
      List data = [];
      for (int i = 0; i <= num; i++) {
        data.add(element.list.split(',')[i]);
      }
      mechanicalServiceProperty.add(data);
    }
  }

  setRadioStatusList(int length) {
    if (mechanicalAddOnRadioState.isNotEmpty) {
      mechanicalAddOnRadioState.clear();
      update();
    }
    for (int i = 0; i < length; i++) {
      mechanicalAddOnRadioState.add(false);
    }
  }

  addOnADDorRemove(bool value, Map<String, dynamic> data) {
    if (value) {
      mechanicalAddOns.add(data);
      update();
    } else {
      if (mechanicalAddOns.isEmpty) {
        return;
      }

      mechanicalAddOns.removeWhere(
          (element) => element.toString().contains(data.toString()));
      update();
    }
  }

  changeTotal(bool state, int? value) {
    if (state) {
      mechanicalAddOnTotal.value = mechanicalAddOnTotal.value + value!;
      update();
    } else {
      mechanicalAddOnTotal.value = mechanicalAddOnTotal.value - value!;
      update();
    }
  }

  Future getTimeSlot(String? serId, List data, String date) async {
    if (mechanicalTimeSlot.isNotEmpty) {
      mechanicalTimeSlot.clear();
      update();
    }
    Response response = await serviceRepo.getServiceTimeSlot(
        serId: serId, date: date, mainCategory: MainCategory.MECHANICAL);
    if (response.body != null &&
        response.isOk &&
        response.body['result'] != null) {
      response.body['result'].forEach((element) {
        mechanicalTimeSlot.add(element);
      });
      update();
    }

    if (mechanicalTimeSlot.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future getMechanicalAvailableOffers(String? serId, int amount) async {
    offerEmpty.value = false;
    update();
    if (mechanicalOffer.isNotEmpty) {
      mechanicalOffer.clear();
      update();
    }
    var response = await serviceRepo.getAvailableOffers(
        serId: serId, amount: amount, mainCategory: MainCategory.MECHANICAL);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        mechanicalOffer.add(OfferModel.fromJson(element));
      });
      update();
    } else {
      offerEmpty.value = true;
      update();
    }
  }

  Future applyOfferToService(String? serId, int amount, String? offerId) async {
    var response = await serviceRepo.applyOffers(
        serId: serId,
        amount: amount,
        offerId: offerId,
        mainCategory: MainCategory.MECHANICAL);

    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      offerApplicable.value = response.body['resultData']['applicable'];
      if (offerApplicable.value == true) {
        // offerApplicable.value = true;
        discount.value = double.parse(
            response.body['resultData']['discountAmount'].toString());
        discountedAmount.value =
            double.parse(response.body['resultData']['total'].toString());
        offerCouponId.value = offerId!;
        update();
        Get.find<CouponController>().clearValue();
        return response.body['resultData'];
      } else {
        clearOffer();
        return response.body['resultData'];
      }
    }
  }

  clearOffer() {
    offerApplicable.value = false;
    discountedAmount.value = 0.0;
    discount.value = 0.0;
    offerCouponId.value = '';
    update();
  }

  void resetMechanicalAddons() {
    mechanicalAddOns.clear();
    update();
  }
}
