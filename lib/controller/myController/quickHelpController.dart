import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/data/repository/qucikHelpAPi.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class QuickHelpController extends GetxController implements GetxService {
  final QuickHelpAPI quickHelpAPI;
  final OrderApi orderApi;
  var quickHelpCategoryData = [].obs;
  var quickHelpServiceList = [].obs;
  var quickHelpServiceProperty = [].obs;
  var paymentIndex = 1.obs;
  var isFound = true.obs;
  LoaderHelper loaderHelper = LoaderHelper();

  QuickHelpController({required this.quickHelpAPI, required this.orderApi});

  setPaymentMode(int index) {
    paymentIndex.value = index;
    update();
  }

  Future getQuickHelpCategoryData() async {
    loaderHelper.startLoader();
    update();
    var response = await quickHelpAPI.getQucikHelpCategory();
    if (response.status == 'OK') {
      quickHelpCategoryData.value = response.resultData.toList();
      update();
    }
    loaderHelper.cancelLoader();
    update();
  }

  Future getQuickHelpServiceWithCatId(String catId) async {
    loaderHelper.startLoader();
    update();
    if (quickHelpServiceList.isNotEmpty) {
      quickHelpServiceList.clear();
      update();
    }
    var response = await quickHelpAPI.getQuickHelpService(catId);
    if (response != null && response.status == 'OK') {
      quickHelpServiceList.value = response.resultData.toList();
      setList();
    } else {
      Get.snackbar("Error", "Something went wrong");
    }
    loaderHelper.cancelLoader();
    update();
  }

  setList() {
    if (quickHelpServiceProperty.isNotEmpty) {
      quickHelpServiceProperty.clear();
      update();
    }
    for (var element in quickHelpServiceList) {
      int num = ','.allMatches(element.list).length;
      List data = [];
      for (int i = 0; i <= num; i++) {
        data.add(element.list.split(',')[i]);
      }
      quickHelpServiceProperty.add(data);
    }
  }

  Future quickHelpBuyNow(String? id, List data) async {
    loaderHelper.startLoader();
    update();
    var response = await quickHelpAPI.quickHelpBuyNow(id, data);
    if (response != null) {
      if (response['status'] == "OK") {
        loaderHelper.cancelLoader();
        update();

        return true;
      } else if (response['status'] == "Failed") {
        loaderHelper.cancelLoader();
        update();

        return false;
      }
    } else {
      loaderHelper.cancelLoader();
      update();
      return false;
    }
  }
}
