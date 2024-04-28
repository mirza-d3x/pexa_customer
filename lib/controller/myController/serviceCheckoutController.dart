import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/data/repository/serviceCheckOutApi.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class ServiceCheckOutController extends GetxController implements GetxService {
  var serviceId = "".obs;
  var timeSlot = "".obs;
  var tempData = [].obs;
  final ServiceCheckOutApi serviceCheckOutApi;

  ServiceCheckOutController({required this.serviceCheckOutApi});
  LoaderHelper loaderHelper = LoaderHelper();

  setServiceId(String id) {
    serviceId.value = id;
    update();
  }

  Future placeOrder(
      Map<String, dynamic> data, MainCategory mainServiceCategory) async {
    loaderHelper.startLoader();
    update();
    var response =
        await serviceCheckOutApi.placeOrder(data, mainServiceCategory);

    if (response['status'] == 'OK') {
      loaderHelper.cancelLoader();
      update();
      showCustomSnackBar('Success ' '${response['message']}...!');
      if (mainServiceCategory == MainCategory.CARSPA) {
        Get.find<CarSpaController>().resetCarSpaAddons();
        serviceId.value = "";
        tempData.clear();
        timeSlot.value = "";
        Get.find<OrderController>().getOrdersList(
            page: "1",
            category: MainCategory.CARSPA,
            orderPage: OrderPage.RUNNING);
        update();
      }
      if (mainServiceCategory == MainCategory.MECHANICAL) {
        Get.find<MechanicalController>().resetMechanicalAddons();
        serviceId.value = "";
        tempData.clear();
        timeSlot.value = "";
        update();
      }
      return true;
    } else {
      loaderHelper.cancelLoader();
      update();
      showCustomSnackBar('Sorry, ' '${response['message']}...!',
          isError: true);
      return false;
    }
  }

  setTimeSlot(String timeSlot) {
    this.timeSlot.value = timeSlot;
    update();
  }
}
