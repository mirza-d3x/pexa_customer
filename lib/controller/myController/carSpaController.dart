import 'dart:developer';

import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/data/repository/service_repo.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/data/models/category_model.dart';
import 'package:shoppe_customer/data/models/offer_model.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class CarSpaController extends GetxController implements GetxService {
  var carSpaSelectedCategory = ''.obs;
  final ServiceRepo serviceRepo;
  final OrderApi orderApi;
  var carSpaCategory = [].obs;
  var carSpaService = [].obs;
  var carSpaServiceProperty = [].obs;
  var carSpaAddOnTotal = 0.obs;
  var carSpaAddOnRadioState = [].obs;
  var carSpaTimeSlot = [].obs;
  var carSpaAddOns = [].obs;
  var isFound = true.obs;
  var carSpaOffers = [].obs;
  var carSpaOfferCheck = [].obs;
  var offerApplicable = false.obs;
  var offerCouponId = ''.obs;
  var discountedAmount = 0.0.obs;
  var discount = 0.0.obs;
  var offerEmpty = false.obs;
  var applyOfferStatus = false.obs;
  var applyOfferServiceId = ''.obs;
  var applyOfferId = ''.obs;
  LoaderHelper loaderHelper = LoaderHelper();
  LoaderHelper isCarspaservicelistLoading = LoaderHelper();

  List carSpaBannerImages = [
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fcar-washing.jpg?alt=media&token=528d3f14-91bb-4919-b88c-84fe8f380719',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fsteaming.jpg?alt=media&token=fc6dda54-c939-44c9-ae2d-285e542eb901',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fsanitization.jpg?alt=media&token=c92a1974-f13f-41d1-a362-82000dfcbeb7',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Finterior-cleaning.jpg?alt=media&token=d252d23d-b42d-4f1a-9d8d-0b289db9652d',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fscratch-removal.jpg?alt=media&token=69189643-936e-4dc7-8614-a7ccde6af4e4',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fwatermark-remo.jpg?alt=media&token=86f23205-3e90-479b-8063-23bf2bbc99a8',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fpoloshing%26-wax.jpg?alt=media&token=8e504e61-15be-45a5-b749-d89536da6003',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fbike.jpg?alt=media&token=4120b145-e27d-4044-a13d-80a77d3453e0',
    'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Fcarspacategory%2Fhouse-keeping.jpg?alt=media&token=5413429b-93fa-408c-a7a9-135df01cf638'
  ];

  CarSpaController({required this.orderApi, required this.serviceRepo});

  @override
  void onInit() {
    // getAllCarSpaCategory();
    super.onInit();
  }

  Future getAllCarSpaCategory() async {
    isCarspaservicelistLoading.startLoader();
    update();
    /*loadCategoryAssets();*/
    Response response = await serviceRepo.getAllServiceCategory(
        mainCategory: MainCategory.CARSPA);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        log("abcd : ${response.body}");
        carSpaCategory.add(CategoryModel.fromJson(element));
      });
      update();
    }
    isCarspaservicelistLoading.cancelLoader();
    update();
  }

  loadCategoryAssets() {
    carSpaCategory.add(CategoryModel(
        id: "one",
        name: "Car Washing",
        assetImage: "assets/serviceImageCircle/CarWashing.png"));
    carSpaCategory.add(CategoryModel(
        id: "two",
        name: "Bike Washing",
        assetImage: "assets/serviceImageCircle/BikeWashing.png"));
  }

  Future getCarSpaServiceWithCatId(String catId) async {
    log("WITH ID .....::::");
    isCarspaservicelistLoading.startLoader();
    update();
    if (carSpaService.isNotEmpty) {
      carSpaService.clear();
      update();
    }
    // var a = Get.find<AuthFactorsController>().userDetails;
    Response response = await serviceRepo.getServiceList(
        mainCategory: MainCategory.CARSPA,
        catId: catId,
        carType: Get.find<AuthFactorsController>().userDetails!.carType);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        carSpaService.add(ServiceId.fromJson(element));
      });
      setList();
    } else {
      if (response.body['message'] != null) {
        showCustomSnackBar(response.body['message'], isError: true);
      } else {
        showCustomSnackBar(response.statusText, isError: true);
      }
    }
    isCarspaservicelistLoading.cancelLoader();
    update();
  }

  Future getCarSpaServiceWithoutCatId(String? catId) async {
    log("WITHOUT ID ....::::");
    isCarspaservicelistLoading.startLoader();
    update();
    log(catId.toString());
    if (carSpaService.isNotEmpty) {
      carSpaService.clear();
      update();
    }
    Response response =
        await serviceRepo.getCarSpaServiceOtherThanCar(catId: catId);
    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        carSpaService.add(ServiceId.fromJson(element));
      });
      setList();
    }
    isCarspaservicelistLoading.cancelLoader();
    update();
  }

  setList() {
    if (carSpaServiceProperty.isNotEmpty) {
      carSpaServiceProperty.clear();
      update();
    }
    for (var element in carSpaService) {
      int num = ','.allMatches(element.list).length;
      List data = [];
      for (int i = 0; i <= num; i++) {
        data.add(element.list.split(',')[i]);
      }
      carSpaServiceProperty.add(data);
    }
  }

  setRadioStatusList(int length) {
    if (carSpaAddOnRadioState.isNotEmpty) {
      carSpaAddOnRadioState.clear();
      update();
    }
    for (int i = 0; i < length; i++) {
      carSpaAddOnRadioState.add(false);
    }
  }

  changeTotal(bool state, int? value) {
    if (state) {
      carSpaAddOnTotal.value = carSpaAddOnTotal.value + value!;
      update();
    } else {
      carSpaAddOnTotal.value = carSpaAddOnTotal.value - value!;
      update();
    }
  }

  Future getTimeSlot(String? serId, String date) async {
    if (carSpaTimeSlot.isNotEmpty) {
      carSpaTimeSlot.clear();
      update();
    }
    var response = await serviceRepo.getServiceTimeSlot(
        serId: serId, date: date, mainCategory: MainCategory.CARSPA);
    if (response.body != null &&
        response.isOk &&
        response.body['result'] != null) {
      response.body['result'].forEach((element) {
        carSpaTimeSlot.add(element);
      });
      update();
    }

    if (carSpaTimeSlot.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  addOnADDorRemove(bool value, Map<String, dynamic> data) {
    if (value) {
      carSpaAddOns.add(data);
      update();
    } else {
      if (carSpaAddOns.isEmpty) {
        return;
      }

      carSpaAddOns.removeWhere(
          (element) => element.toString().contains(data.toString()));
      update();
    }
  }

  Future getCarSpaAvailableOffers(String? serId, int amount) async {
    offerEmpty.value = false;
    loaderHelper.startLoader();
    update();
    if (carSpaOffers.isNotEmpty) {
      carSpaOffers.clear();
      update();
    }
    Response response = await serviceRepo.getAvailableOffers(
        serId: serId, amount: amount, mainCategory: MainCategory.CARSPA);

    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      response.body['resultData'].forEach((element) {
        carSpaOffers.add(OfferModel.fromJson(element));
      });
      loaderHelper.cancelLoader();
      update();
      setCheckBox();
    } else {
      offerEmpty.value = true;
      loaderHelper.cancelLoader();
      update();
    }
  }

  setCheckBox() {
    if (carSpaOfferCheck.isNotEmpty) {
      carSpaOfferCheck.clear();
      update();
    }
    for (var element in carSpaOffers) {
      carSpaOfferCheck.add(false);
    }
    log(carSpaOfferCheck.toString());
  }

  Future setCheckBoxValue(int ind) async {
    carSpaOfferCheck.asMap().forEach((index, value) {
      if (ind == index) {
        carSpaOfferCheck[index] = !carSpaOfferCheck[index];
      } else {
        carSpaOfferCheck[index] = false;
      }
    });
    log(carSpaOfferCheck.toString());
  }

  Future applyOfferToService(String? serId, int amount, String? offerId) async {
    log(serId.toString());
    log(amount.toString());
    log(offerId.toString());
    Response response = await serviceRepo.applyOffers(
        serId: serId,
        amount: amount,
        offerId: offerId,
        mainCategory: MainCategory.CARSPA);

    if (response.body != null &&
        response.isOk &&
        response.body['resultData'] != null) {
      if (response.body['resultData']['applicable']) {
        offerApplicable.value = true;
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

  setApplyOfferData(String offerId, String serviceId) {
    applyOfferStatus.value = true;
    applyOfferId.value = offerId;
    applyOfferServiceId.value = serviceId;
    update();
    log('${applyOfferStatus.value}\n${applyOfferId.value}\n${applyOfferServiceId.value}');
  }

  clearApplyOfferData() {
    applyOfferStatus.value = false;
    applyOfferId.value = '';
    applyOfferServiceId.value = '';
    update();
  }

  resetCarSpaAddons() {
    carSpaAddOns.clear();
    update();
  }
}
