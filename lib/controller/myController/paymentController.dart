import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/payment_api.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/data/models/payment_model.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class PaymentController extends GetxController implements GetxService {
  var paymentMode = 'online'.obs;
  var result = [].obs;
  var status = 'pending';
  final PaymentAPI? paymentAPI;

  PaymentController({this.paymentAPI});

  updatePaymentMode(String mode) {
    paymentMode.value = mode;
    update();
  }

  Future cartCheckout({String? coupon}) async {
    result.isNotEmpty ? result.clear() : result.value = [];
    Response response = await (paymentAPI!.cartCheckout(coupon: coupon));
    if (response.status.isOk) {
      result.add(paymentResponseModel.fromJson(response.body['resultData']));
      return true;
    } else {
      showCustomSnackBar(response.statusText, isError: true, title: "Error");
      return false;
    }
  }

  Future shoppeCheckout(String? productId, String count, String coupon) async {
    print(productId);
    result.isNotEmpty ? result.clear() : result.value = [];
    var paymentData = await paymentAPI!.shoppePayment(productId, count, coupon);
    result.add(paymentData.resultData);
  }

  Future serviceCheckout({
    String? categoryId,
    List? data,
    String? timeSlot,
    MainCategory? mainServiceCategory,
    String? couponCode,
    var addOns,
  }) async {
    result.isNotEmpty ? result.clear() : result.value = [];
    Response response = await paymentAPI!.servicePayment(
        categoryId: categoryId,
        location: data,
        timeSlot: timeSlot,
        addOns: addOns,
        mainServiceCategory: mainServiceCategory,
        coupon: couponCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      result.add(paymentResponseModel.fromJson(response.body['resultData']));
      return true;
    } else {
      showCustomSnackBar(response.body['message'],
          title: "Error", isError: true);
      return false;
    }
  }
}
