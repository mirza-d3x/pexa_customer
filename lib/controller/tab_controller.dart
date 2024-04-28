import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';

class TabControllerMethod extends GetxController implements GetxService {
  var tabIndex = 4.obs;
  changeTab(int index) {
    tabIndex.value = index;
    update();
  }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements GetxService {
  final List<Tab> myTabs = const <Tab>[
    Tab(text: 'Current'),
    Tab(text: 'Past'),
  ];

  TabController? controller;
  int tabIndex = 0;

  initialize() {
    controller =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0);
    update();
  }

  @override
  void onInit() {
    super.onInit();
// if(Get.find<AuthFactorsController>().isLoggedIn.value){ }
    controller =
        TabController(vsync: this, length: myTabs.length, initialIndex: 0);
    loadData(isRunning: tabIndex == 0);
    controller!.addListener(() {
      if (tabIndex != controller!.index) {
        tabIndex = controller!.index;
        loadData(isRunning: tabIndex == 0);
        update();
      }
    });
  }

  // @override
  // void onReady() {
  //   controller =
  //       TabController(vsync: this, length: myTabs.length, initialIndex: 0);
  //   super.onReady();
  // }

  RxList<String> catList = ['Pexa Shoppe', 'Car Spa', /*'Mechanical', 'Quick Help'*/].obs;
  var pageIndex = 0.obs;

  void pageLeft({bool? isRunning}) {
    pageIndex.value = pageIndex.value - 1;
    loadData(isRunning: isRunning);
    update();
  }

  void pageRight({bool? isRunning}) {
    pageIndex.value = pageIndex.value + 1;
    loadData(isRunning: isRunning);
    update();
  }

  void loadData({bool? isRunning}) {
    if (pageIndex.value == 0) {
      if (isRunning!) {
        Get.find<ProductCategoryController>().getOrderRunningDetailsShoppe('1');
      } else {
        Get.find<ProductCategoryController>().getOrderHistoryDetailsShoppe('1');
      }
    }
    if (pageIndex.value == 1) {
      if (isRunning!) {
        Get.find<OrderController>().getOrdersList(
            page: '1',
            category: MainCategory.CARSPA,
            orderPage: OrderPage.RUNNING);
      } else {
        Get.find<OrderController>().getOrdersList(
            page: '1',
            category: MainCategory.CARSPA,
            orderPage: OrderPage.HISTORY);
      }
    }
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}


// class MyTabController extends GetxController
//     with GetSingleTickerProviderStateMixin
//     implements GetxService {
//   final List<Tab> myTabs = const <Tab>[
//     Tab(text: 'Current'),
//     Tab(text: 'Past'),
//   ];
//
//   TabController? controller;
//   int tabIndex = 0;
//
//   initialize() {
//     controller =
//         TabController(vsync: this, length: myTabs.length, initialIndex: 0);
//     update();
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
// // if(Get.find<AuthFactorsController>().isLoggedIn.value){ }
//     controller =
//         TabController(vsync: this, length: myTabs.length, initialIndex: 0);
//     loadData(isRunning: tabIndex == 0);
//     controller!.addListener(() {
//       if (tabIndex != controller!.index) {
//         tabIndex = controller!.index;
//         loadData(isRunning: tabIndex == 0);
//         update();
//       }
//     });
//   }
//
//   // @override
//   // void onReady() {
//   //   controller =
//   //       TabController(vsync: this, length: myTabs.length, initialIndex: 0);
//   //   super.onReady();
//   // }
//
//   RxList<String> catList = [/*'Pexa Shoppe',*/ 'Car Spa',/* 'Mechanical', 'Quick Help'*/].obs;
//   var pageIndex = 0.obs;
//
//  /* void pageLeft({bool? isRunning}) {
//     pageIndex.value = pageIndex.value - 1;
//     loadData(isRunning: isRunning);
//     update();
//   }*/
//
//   /*void pageRight({bool? isRunning}) {
//     pageIndex.value = pageIndex.value + 1;
//     loadData(isRunning: isRunning);
//     update();
//   }*/
//
//   void loadData({bool? isRunning}) {
//     if (pageIndex.value == 0) {
//       if (isRunning!) {
//         Get.find<OrderController>().getOrdersList(
//             page: '1',
//             category: MainCategory.CARSPA,
//             orderPage: OrderPage.RUNNING);
//       } else {
//         Get.find<OrderController>().getOrdersList(
//             page: '1',
//             category: MainCategory.CARSPA,
//             orderPage: OrderPage.HISTORY);
//       }
//     }
//   }
//
//   @override
//   void onClose() {
//     controller!.dispose();
//     super.onClose();
//   }
// }
