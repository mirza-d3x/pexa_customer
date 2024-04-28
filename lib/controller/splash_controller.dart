import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shoppe_customer/controller/myController/appVersionController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/initial_loader_controller.dart';
import 'package:shoppe_customer/data/repository/splash_repo.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});
  bool firstTimeConnectionCheck = true;
  final carSpaController = Get.find<CarSpaController>();
  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }

  void disableIntro() {
    splashRepo.disableIntro();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    firstTimeConnectionCheck = isChecked;
  }

  void route({String? productId}) async {
    if (!GetPlatform.isWeb) {
      if (Get.find<ConnectivityController>().status) {
        Get.find<AppVersionController>().checkVersion();
        /*print("vysh!!!! :${Get.find<AuthFactorsController>().isLoggedIn.value}");*/
        if (Get.find<AuthFactorsController>().isLoggedIn.value) {
          Get.find<AuthFactorsController>()
              .getUserDetails()
              .then((value) async {
            if (value != null) {
              String token = (await FirebaseMessaging.instance.getToken())!;
              print("FCM TOKEN : $token");
              redirectTo(productId: productId);
            }
          });
        } else {
          if (productId != null) {
            Future.delayed(const Duration(seconds: 2), (() {
              Get.offAllNamed(RouteHelper.getSignInRoute(
                  page: RouteHelper.splash, productId: productId));
            }));
          } else {
            Future.delayed(const Duration(seconds: 2), (() {
              Get.offAllNamed(RouteHelper.getSignInRoute(
                page: RouteHelper.splash,
              ));
            }));
          }
        }
      } else {
        showCustomSnackBar("No network... Check your network connectivity!!!",
            isError: true);
      }
    } else {
      Get.find<InitialLoaderController>().loadData();
      Future.delayed(const Duration(seconds: 1), (() {
        Get.offAllNamed(RouteHelper.initial);
        Get.find<locationPermissionController>().checkLocationStatus();
      }));
    }
  }

  redirectTo({String? productId}) {
    if ((Get.find<AuthFactorsController>().userName != "" &&
            Get.find<AuthFactorsController>().userName != null) &&
        (Get.find<AuthFactorsController>().userPhone != null &&
            Get.find<AuthFactorsController>().userPhone != "")) {
      if (productId != null) {
        // if deeplink opens
        var path = productId;
        Get.find<InitialLoaderController>().loadData();
        Future.delayed(const Duration(seconds: 2), (() {
          Get.offAllNamed(
              RouteHelper.getInitialRoute(page: 'home', productId: path));
          Get.find<locationPermissionController>()
              .checkLocationStatus()
              .then((value) {

            Get.find<locationPermissionController>()
                .getUserLocation(isForAddress: false);});
          /*Get.find<locationPermissionController>().checkLocationStatus();*/
        }));
      } else {
        if (carSpaController.carSpaCategory.isEmpty) {
          carSpaController.getAllCarSpaCategory();
        }
        Get.find<InitialLoaderController>().loadData();
        Future.delayed(const Duration(seconds: 2), (() {
          Get.offAllNamed(RouteHelper.getInitialRoute(page: 'home'));
          Get.find<locationPermissionController>()
              .checkLocationStatus()
              .then((value) {

            Get.find<locationPermissionController>()
                .getUserLocation(isForAddress: false);});
          /*Get.find<locationPermissionController>().checkLocationStatus();*/
        }));
      }
    } else {
      if (productId != null) {
        Get.find<InitialLoaderController>().loadData();
        Future.delayed(const Duration(seconds: 2), (() {
          Get.offAllNamed(RouteHelper.getEditProfile(),
              arguments: {'isEdit': false, 'productId': productId});
        }));
      } else {
        Get.find<InitialLoaderController>().loadData();
        Future.delayed(const Duration(seconds: 2), (() {
          Get.offAllNamed(RouteHelper.getEditProfile(),
              arguments: {'isEdit': false});
        }));
      }
    }
  }
}
