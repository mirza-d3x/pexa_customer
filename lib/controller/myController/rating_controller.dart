import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class RatingController extends GetxController implements GetxService {
  final OrderApi orderApi;
  RatingController({required this.orderApi});
  var count = 0.obs;
  final TextEditingController reviewDescriptionController =
      TextEditingController();
  LoaderHelper loaderHelper = LoaderHelper();

  updateCount(int count) {
    this.count.value = count;
    update();
  }

  resetCOntroller() {
    count.value = 0;
    reviewDescriptionController.clear();
    update();
  }

  Future updateReview({MainCategory? category, String? orderId}) async {
    loaderHelper.startLoader();
    update();
    Map<String, dynamic> body = {};
    if (reviewDescriptionController.text.isEmpty) {
      body = {'orderId': orderId, 'rating': count.value};
    } else {
      body = {
        'orderId': orderId,
        'description': reviewDescriptionController.text,
        'rating': count.value
      };
    }
    Response response =
        await (orderApi.updateRating(body: body, category: category));
    if (response.statusCode == 200 || response.statusCode == 201) {
      loaderHelper.cancelLoader();
      update();
      Get.find<OrderController>()
          .getSingleOrderDetails(orderId: orderId!, serviceCategory: category);
      return true;
    } else {
      loaderHelper.cancelLoader();
      update();
      return false;
    }
  }
}
