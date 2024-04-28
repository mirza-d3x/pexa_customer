import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/data/models/carShoppe/shoppeOrdersModel.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class OrderController extends GetxController implements GetxService {
  final OrderApi orderApi;

  OrderController({required this.orderApi});

  ServiceOrderModel? selectedOrderDetails;
  late ShoppeOrderDetail shoppeOrderDetail;
  List<ServiceOrderModel> OrderListTempRunning = [];
  List<ServiceOrderModel> OrderListRunning = [];
  List<ServiceOrderModel> OrderListHistory = [];
  List<ServiceOrderModel> OrderListTempHistory = [];
  LoaderHelper isRunningOrderLoader = LoaderHelper();
  LoaderHelper isOrderHistoryLoader = LoaderHelper();
  var foundRunningOrder = false.obs;
  var foundOrderHistory = false.obs;

  setSelectedServiceOrder(ServiceOrderModel? order) {
    selectedOrderDetails = order;
    update();
  }

  setSelectedShoppeOrdere(ShoppeOrderDetail order) {
    shoppeOrderDetail = order;
    update();
  }

  Future getSingleOrderDetails(
      {required String orderId, MainCategory? serviceCategory}) async {
    selectedOrderDetails = ServiceOrderModel();
    shoppeOrderDetail = ShoppeOrderDetail();
    Response response = await (orderApi.getOrderDetails(
        category: serviceCategory, orderId: orderId));
    if (response.statusCode == 200 ||
        response.statusCode == 201 &&
            response.body['resultData'] != null &&
            response.body['resultData'] != []) {
      if (serviceCategory == MainCategory.SHOPPE) {
        shoppeOrderDetail =
            ShoppeOrderDetail.fromJson(response.body['resultData']);
      } else {
        selectedOrderDetails =
            ServiceOrderModel.fromJson(response.body['resultData'][0]);
      }
      update();
      return true;
    } else {
      return false;
    }
  }

  Future getOrdersList(
      {required String page,
      required MainCategory? category,
      required OrderPage orderPage}) async {
    print("GET ORDER LIST CALLED ======#######################");
    if (orderPage == OrderPage.RUNNING) {
      foundRunningOrder.value = true;
      update();
      if (page == '1') {
        isRunningOrderLoader.startLoader();
        if (OrderListTempRunning.isNotEmpty) {
          OrderListTempRunning = [];
          update();
        } else {
          OrderListTempRunning = [];
        }
      }
      OrderListRunning = [];
      update();
        } else {
      foundOrderHistory.value = true;
      update();
      if (page == '1') {
        isOrderHistoryLoader.startLoader();
        OrderListTempHistory = [];
        update();
            }
      OrderListHistory = [];
      update();
        }

    var response = await orderApi.getOrderStatus(
        page: page, category: category, status: orderPage);
    if ((response.statusCode == 200 || response.statusCode == 201) &&
        response.body['resultData'] != null) {
      if (orderPage == OrderPage.RUNNING) {
        OrderListRunning = [];
        response.body['resultData'].forEach((element) {
          if (element['status'] == 'Active' ||
              element['status'] == 'Accepted' ||
              element['status'] == 'In_Progress' ||
              element['status'] == "Reassigned") {
            OrderListRunning.add(ServiceOrderModel.fromJson(element));
          }
        });
        update();
        if (OrderListRunning.isEmpty) {
          isRunningOrderLoader.cancelLoader();
          foundRunningOrder.value = false;
          update();
        } else {
          for (var element in OrderListRunning) {
            OrderListTempRunning.add(element);
          }
          update();
        }
        isRunningOrderLoader.cancelLoader();
        update();
      } else {
        OrderListHistory = [];
        response.body['resultData'].forEach((element) {
          if ((element['status'] == 'Completed') ||
              (element['status'] == 'Cancelled') ||
              (element['status'] == 'Rejected')) {
            OrderListHistory.add(ServiceOrderModel.fromJson(element));
          }
        });

        update();
        if (OrderListHistory.isEmpty) {
          foundOrderHistory.value = false;
          isOrderHistoryLoader.cancelLoader();
          update();
        } else {
          for (var element in OrderListHistory) {
            OrderListTempHistory.add(element);
            update();
          }
        }
      }
    } else {
      if (orderPage == OrderPage.RUNNING) {
        Future.delayed(const Duration(seconds: 2), () {
          foundRunningOrder.value = false;
          isRunningOrderLoader.cancelLoader();
          update();
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          isOrderHistoryLoader.cancelLoader();
          foundOrderHistory.value = false;
          update();
        });
      }
    }
  }

  removeCancelledOrder(String? id) {
    if (OrderListTempRunning.isNotEmpty) {
      OrderListTempRunning.removeWhere((element) => element.id == id);
      update();
    }
  }

  Future cancelOrder(
      {String? ordID, String? shortOrderID, MainCategory? serviceCategory}) async {
    Response response =
        await (orderApi.cancelOrder(orderId: ordID, category: serviceCategory));
    if (response.body != null) {
      if (response.body['status'] == "OK") {
        if (serviceCategory != MainCategory.SHOPPE) {
          selectedOrderDetails!.status = "Cancelled";
          removeCancelledOrder(ordID);
          update();
        }
        showCustomSnackBar("Order $shortOrderID is cancelled...!",
            title: "Success", isError: false);
      }
    }
  }
}
