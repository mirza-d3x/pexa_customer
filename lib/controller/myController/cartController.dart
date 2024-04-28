import 'dart:convert';
import 'dart:developer';

import 'package:shoppe_customer/data/models/carShoppe/shippingModel.dart';
import 'package:shoppe_customer/data/repository/cartApi.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/data/models/carShoppe/cartListModel.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class CartControllerFile extends GetxController implements GetxService {
  final CartApi cartApi;
  List<CartItem>? cartList;
  var cartTotalPrice = 0.0.obs;
  var cartTotalDiscount = 0.0.obs;
  var cartGrandTotal = 0.0.obs;
  var cartShipping = 0.0.obs;
  var cartMinimumOrderAmount = 0.0;
  var noItem = false.obs;
  var isInCart = false.obs;
  late CartListModel cartResult;

  CartControllerFile({required this.cartApi});

  clearCart() {
    cartList!.clear();
    cartTotalPrice.value = 0.0;
    cartTotalDiscount.value = 0.0;
    cartGrandTotal.value = 0.0;
    cartShipping.value = 0.0;
    cartMinimumOrderAmount = 0.0;
  }

  updateItemCount({String? option, int? index}) {
    if (option == "+") {
      cartList![index!].count! < cartList![index].product!.quantity!
          ? cartList![index].count! + 1
          : cartList![index].count;
      log(cartList![index].count.toString());
      update();
    } else {
      cartList![index!].count! > 1
          ? cartList![index].count! - 1
          : cartList![index].count;
      update();
    }
  }

  setBuyingStatus(bool status) {
    isBuying.value = status;
    update();
  }

  Future addOrUpdateToCart(String? prodId, int? count, String type) async {
    var response = await cartApi.addOrUpdateCart(prodId, count);
    if (response['status'] == 'OK') {
      // if (type == 'add') {
      //   Get.snackbar('Success', 'Item added to the Cart...!',
      //       snackPosition: SnackPosition.TOP,
      //       duration: Duration(milliseconds: 700),
      //       backgroundColor: Colors.yellow,
      //       colorText: Colors.black,
      //       snackStyle: SnackStyle.FLOATING);
      // } else {
      //   Get.snackbar('Success', 'Item Count updated to the Cart...!',
      //       snackPosition: SnackPosition.TOP,
      //       duration: Duration(milliseconds: 700),
      //       backgroundColor: Colors.yellow,
      //       colorText: Colors.black,
      //       snackStyle: SnackStyle.FLOATING);
      // }
    } else {
      showCustomSnackBar(response.statusText, title: "Error", isError: true);
    }
  }

  Future getCartDetails(bool refresh) async {
    Get.find<ProductDetailsController>().isPercentageCalculate.value = true;
    update();
    if (refresh) {
      if (cartList != null) {
        cartList!.clear();
        cartTotalPrice.value = 0.0;
        cartGrandTotal.value = 0.0;
        cartShipping.value = 0.0;
        cartMinimumOrderAmount = 0.0;
      }
    }
    noItem.value = false;
    update();
    var response = await cartApi.getCartDetails();
    cartResult = CartListModel.fromJson(response.body);
    cartList = cartResult.resultData!.cartItems!.toList();
    if (cartList!.isNotEmpty) {
      noItem.value = true;
      update();
      var totalPrice = 0.0;
      var totalDiscount = 0.0;
      for (var element in cartList!) {
        totalPrice = totalPrice + element.product!.price!;
        totalDiscount = totalDiscount +
            (element.product!.price! - element.product!.offerPrice!);
      }
      cartTotalDiscount.value = totalDiscount;
      cartTotalPrice.value = totalPrice;
    }
    // if (response.resultData.total != null) {
    //   cartTotalPrice.value =
    //       double.parse(response.resultData.total.toString());
    // }
    if (cartResult.resultData!.grandTotal != null) {
      cartGrandTotal.value =
          double.parse(cartResult.resultData!.grandTotal.toString());
    }
    if (cartResult.resultData!.shipping != null) {
      cartShipping.value =
          double.parse(cartResult.resultData!.shipping.toString());
    }
    // if (response.resultData.shipping != null) {
    //   cartShipping.value =
    //       double.parse(response.resultData.shipping.toString());
    // }
    getShippingDetails(total: cartResult.resultData!.total.toString());
    if (cartResult.resultData!.cartItems!.isEmpty) {
      noItem.value = true;
      update();
    } else {
      noItem.value = false;
      update();
    }
  }

  Future getShippingDetails({required String total}) async {
    Response response = await cartApi.getShippingDetails();
    if (response.status.isOk) {
      List<ShippingResultData> shippingDetailsList = [];
      response.body['resultData'].forEach((element) {
        shippingDetailsList.add(ShippingResultData.fromJson(element));
      });
      if (shippingDetailsList.isNotEmpty) {
        cartMinimumOrderAmount =
            double.parse(shippingDetailsList[0].minimum.toString());
        update();
      }
      return true;
    } else {
      return false;
    }
  }

  Future removeProdFromCart(String prodId) async {
    var res = await cartApi.removeCart(prodId);
    log(res.toString());
  }

  var isBuying = false.obs;
  Future placeOrder() async {
    isBuying.value = true;
    update();
    Response response = await (cartApi.placeOrder());
    isBuying.value = false;
    update();
    var res = jsonDecode(response.bodyString!);
    if (res != null) {
      if (res['status'] == "OK") {
        checkProductInCart(
            Get.find<ProductDetailsController>().productDetails!.id);
        update();

        // Get.snackbar('Success', '${res['message']}...!',
        //     snackPosition: SnackPosition.TOP,
        //     duration: Duration(seconds: 2),
        //     backgroundColor: Colors.yellow,
        //     colorText: Colors.black,
        //     snackStyle: SnackStyle.FLOATING);
        return true;
      } else if (res['status'] == "Failed") {
        showCustomSnackBar(res['message'], title: "Error", isError: true);
        return false;
      }
    } else {
      showCustomSnackBar(response.statusText, title: "Error", isError: true);
      return false;
    }
  }

  Future checkProductInCart(String? id) async {
    log('id is $id');
    if (cartList != null) {
      cartList!.clear();
    }
    List temp = [];
    var response = await cartApi.getCartDetails();
    CartListModel cartResult = CartListModel.fromJson(response.body);
    cartList = cartResult.resultData!.cartItems;
    if (cartList!.isNotEmpty) {
      for (var element in cartList!) {
        temp.add(element.product!.id.toString());
      }
    } else {
      isInCart.value = false;
      update();
    }
    log(temp.toString());
    if (temp.contains(id)) {
      isInCart.value = true;
      update();
    } else {
      isInCart.value = false;
      update();
    }
    log('value = $isInCart');
  }

  Future placeOrderWithCoupon(String code) async {
    var response = await cartApi.placeOrderWithCode(code);

    if (response != null) {
      if (response['status'] == "OK") {
        // Get.snackbar('Success', '${response['message']}...!',
        //     snackPosition: SnackPosition.TOP,
        //     duration: Duration(seconds: 2),
        //     backgroundColor: Colors.yellow,
        //     colorText: Colors.black,
        //     snackStyle: SnackStyle.FLOATING);
        return true;
      } else if (response['status'] == "Failed") {
        showCustomSnackBar(response['message'], title: "Error", isError: true);
        return false;
      }
    } else {
      showCustomSnackBar(response.statusText, title: "Error", isError: true);
      return false;
    }
  }

  void setQuantity({required int index, num? count}) {
    cartList!.elementAt(index).count = count;
    update();
  }
}
