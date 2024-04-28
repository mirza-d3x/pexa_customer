import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/expandableListController.dart';
import 'package:shoppe_customer/controller/myController/rating_controller.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/view/screens/home/widgets/more_products.dart';
import 'package:shoppe_customer/view/screens/carshoppe/checkout.dart';
import 'package:shoppe_customer/view/screens/carshoppe/payment.dart';
import 'package:shoppe_customer/view/screens/carshoppe/product_details.dart';
import 'package:shoppe_customer/view/screens/carshoppe/product_listing.dart';
import 'package:shoppe_customer/view/screens/service/services_listing.dart';
import 'package:shoppe_customer/view/screens/auth/login_screen.dart';
import 'package:shoppe_customer/view/screens/auth/otp_screen.dart';
import 'package:shoppe_customer/view/screens/splash/splash_screen.dart';
import 'package:shoppe_customer/view/screens/Mechanical/mechanicalAddonView.dart';
import 'package:shoppe_customer/view/screens/Mechanical/mechanicalServicePage.dart';
import 'package:shoppe_customer/view/screens/Mechanical/mechanicalTimeSlotScreen.dart';
import 'package:shoppe_customer/view/screens/address_edit/addressDetailsPage.dart';
import 'package:shoppe_customer/view/screens/address_edit/addressEditPage.dart';
import 'package:shoppe_customer/view/screens/address_edit/addressPage.dart';
import 'package:shoppe_customer/view/screens/carSpa/carSpaAddOnView.dart';
import 'package:shoppe_customer/view/screens/carSpa/carSpaServices.dart';
import 'package:shoppe_customer/view/screens/carSpa/carSpaTimeSlotView.dart';
import 'package:shoppe_customer/view/screens/payment/service_payment_widget.dart';
import 'package:shoppe_customer/view/screens/cart/cart_checkout.dart';
import 'package:shoppe_customer/view/screens/cart/cart_payment.dart';
import 'package:shoppe_customer/view/screens/cart/cart_screen.dart';
import 'package:shoppe_customer/view/screens/category/category_screen.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/infoPage/infoPage.dart';
import 'package:shoppe_customer/view/screens/location/locationSearch.dart';
import 'package:shoppe_customer/view/screens/notification/notification_screen.dart';
import 'package:shoppe_customer/view/screens/order/productOrderDetailedView.dart';
import 'package:shoppe_customer/view/screens/order/serviceOrderDetailView.dart';
import 'package:shoppe_customer/view/screens/profile/profile_screen.dart';
import 'package:shoppe_customer/view/screens/profile/userDetailsUpdatePage.dart';
import 'package:shoppe_customer/view/screens/quickHelp/quickHelpServices.dart';
import 'package:shoppe_customer/view/screens/search/searchScreen.dart';
import 'package:shoppe_customer/view/screens/support/support_screen.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/update/update_screen.dart';

import '../view/screens/dashboard/bottomnew.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/sign-in';
  static const String verification = '/verification';
  static const String profile = '/profile';
  static const String info = '/info';
  static const String categories = '/categories';
  static const String categoryProduct = '/category-product';
  static const String support = '/help-and-support';
  static const String addAddress = '/add-address';
  static const String shoppeListing = '/shoppe-listing';
  static const String serviceListing = '/Service-listing';
  static const String productDetails = '/product-details';
  static const String cart = '/cart';
  static const String cartPayment = '/cart-payment';
  static const String locationSearch = '/location-search';
  static const String viewAllProducts = '/view-all-products';
  static const String shoppeCheckOut = '/shoppe-checkout';
  static const String cartCheckOut = '/cart-checkout';
  static const String addressDetailsPage = '/address-details-page';
  static const String shoppePayment = '/shoppe-payment';
  static const String mechanicalService = '/mechanical-services';
  static const String carSpaService = '/car-spa-services';
  static const String quickHelpService = '/quick-help-services';
  static const String addressViewPage = '/address-view-page';
  static const String addressEditPage = '/address-Edit-page';
  static const String carSpaTimeSlotPage = '/car-spa-timeslot-page';
  static const String carSpaPayment = '/car-spa-payment';
  static const String carSpaServiceAddon = '/car-spa-service-addon';
  static const String mechanicalTimeSlot = '/mechanical-timeslot';
  static const String mechanicalPayment = '/mechanical-payment';
  static const String mechanicalServiceAddon = '/mechanical-service-addon';
  static const String productOrderDetailedView = '/product-order-detailed-view';
  static const String serviceOrderDetailedView = '/service-order-detailed-view';
  static const String userDetailsUpdate = '/userdetails-update';
  static const String quickHelpPayments = '/quickhelp-payments';
  static const String search = '/search';
  static const String notification = '/notification';
  static const String update = '/update';

  static String getInitialRoute({String? page, String? productId}) {
    if (productId != null) {
      return '$initial?page=$page&productId=$productId';
    } else {
      if (page == 'home') {
        return initial;
      } else {
        return '$initial?page=$page';
      }
    }
  }

  static String getSplashRoute({String? productId}) {
    if (productId != null) {
      return "$splash?pid=$productId";
    } else {
      return splash;
    }
  }

  static String getProductDetailsRoute({required String pid}) =>
      '$productDetails?pid=$pid';

  static String getSignInRoute({required String page, String? productId}) {
    if (productId != null) {
      return '$login?pid=$productId';
    } else {
      return login;
    }
  }

  static String getEditProfile() => userDetailsUpdate;

  static String getVerificationRoute() {
    return verification;
  }

  static String getUpdateRoute(bool isUpdate) =>
      '$update?update=${isUpdate.toString()}';

  static String getInfoPage(String page) => '$info?page=$page';

  static String getCategoryRoute() => categories;

  static String getCategoryProductRoute(int? id, String name) {
    List<int> encoded = utf8.encode(name);
    String data = base64Encode(encoded);
    return '$categoryProduct?id=$id&name=$data';
  }

  static String getSupportRoute() => support;

  static String getCartRoute() => cart;

  static String getProfileRoute() => profile;

  static String getAddAddressRoute() => addAddress;

  static String getShoppeList() => shoppeListing;

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () {
          if (Get.parameters['page'] == 'home' ||
              Get.parameters['page'] == null ||
              Get.parameters['page'] == '') {}
          // return getRoute(DashBoard(
          //   pageIndex: pageIndex,
          //   pageFromLogin: Get.parameters['page'] == 'login',
          //   productId: Get.parameters['productId'],
          // )
          return getRoute(const BottomNew());
        }),
    GetPage(
        name: splash,
        page: () {
          var productId = Get.parameters['pid'];
          if (productId != null) {
            return SplashScreen(prductId: productId);
          } else {
            return SplashScreen();
          }
        }),
    GetPage(
        name: update,
        page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(
        name: login,
        page: () => NewLoginScreen(
            exitFromApp: Get.parameters['page'] == splash ||
                Get.parameters['page'] == verification,
            pid: Get.parameters['pid'])),
    GetPage(
        name: verification,
        page: () {
          return OTPScreen(
              phone: Get.arguments['phone'], pid: Get.arguments['pid']);
        }),
    GetPage(
        name: profile,
        page: () {
          return getRoute(ProfileScreen());
        }),
    GetPage(
        name: info,
        page: () => InformationPage(
              title: Get.parameters['page'],
            )),
    GetPage(name: categories, page: () => getRoute(CategoryScreen())),
    GetPage(name: support, page: () => getRoute(const SupportScreen())),
    GetPage(name: shoppeListing, page: () => getRoute(ShoppeListing())),
    GetPage(
        name: serviceListing,
        page: () {
          return getRoute(ServiceList(
            data: Get.arguments[0]['data'],
            title: Get.arguments[0]['title'],
            type: Get.arguments[0]['type'],
          ));
        }),
    GetPage(
        name: viewAllProducts,
        page: () {
          return getRoute(ViewAll(
            data: Get.arguments[0]['data'],
            title: Get.arguments[0]['title'],
            type: Get.arguments[0]['type'],
          ));
        }),
    GetPage(
        name: shoppeCheckOut,
        page: () {
          // var quantity = Get.arguments['data'];
          return getRoute(const ShoppeCheckout());
        }),
    GetPage(
        name: cartCheckOut,
        page: () {
          return getRoute(CartCheckout());
        }),
    GetPage(
        name: productDetails,
        page: () {
          return getRoute(ProductDetails(isFromLink: Get.parameters['pid']));
        }),
    GetPage(
        name: addressDetailsPage,
        page: () {
          return getRoute(
              AddressDetailsPage(backContext: Get.arguments['context']));
        }),
    GetPage(
        name: cart,
        page: () => getRoute(CartScreen(
              fromMain: Get.arguments['fromMain'],
              fromNav: Get.arguments['fromNav'],
              prodId: Get.arguments['prodId'],
            ))),
    GetPage(name: cartPayment, page: () => getRoute(const CartPayment())),
    GetPage(
        name: shoppePayment,
        page: () => getRoute(ShoppePayment(product: Get.arguments['product']))),
    GetPage(
        name: mechanicalService,
        page: () =>
            getRoute(MechanicalServices(title: Get.arguments['title']))),
    GetPage(
        name: carSpaService,
        page: () => getRoute(
            CarSpaServices(type: 'carSpa', title: Get.arguments['title']))),
    GetPage(
        name: quickHelpService,
        page: () =>
            getRoute(QuickHelpServicesPage(title: Get.arguments['title']))),
    GetPage(
        name: addressViewPage,
        page: () => getRoute(AddressEditPage(
            backContext: Get.arguments['backContext'],
            isEdit: Get.arguments['isEdit'],
            index: Get.arguments['index']))),
    GetPage(
        name: addressEditPage,
        page: () => getRoute(AddressEditView(
              backContext: Get.arguments['backContext'],
              addressListResultData: Get.arguments['addressListResultData'],
            ))),
    GetPage(
        name: carSpaTimeSlotPage,
        page: () => getRoute(CarSpaTimeSlotView(
            carSpaServiceResultData:
                Get.arguments['carSpaServiceResultData']))),
    GetPage(
        name: carSpaPayment,
        page: () => getRoute(ServicePaymentWidget(
              body: Get.arguments['body'],
              mainServiceCategory: MainCategory.CARSPA,
            ))),
    GetPage(
        name: carSpaServiceAddon,
        page: () => getRoute(CarSpaServiceAddOnView(
              carSpaServiceResultData: Get.arguments['carSpaServiceResultData'],
            ))),
    GetPage(
        name: mechanicalTimeSlot,
        page: () => getRoute(MechanicalTimeSlotScreen(
              mechanicalServiceResultData:
                  Get.arguments['mechanicalServiceResultData'],
            ))),
    GetPage(
        name: mechanicalPayment,
        page: () => getRoute(ServicePaymentWidget(
              body: Get.arguments['body'],
              mainServiceCategory: MainCategory.MECHANICAL,
            ))),
    GetPage(
        name: mechanicalServiceAddon,
        page: () => getRoute(MechanicalServiceAddOnView(
              serviceDetails: Get.arguments['mechanicalServiceResultData'],
            ))),
    GetPage(
        name: productOrderDetailedView,
        page: () => getRoute(ProductOrderDetailedView(
            orderId: Get.arguments['orderId'],
            shoppeOrderResultData: Get.arguments['shoppeOrderResultData'],
            isRunning: Get.arguments['isRunning']))),
    GetPage(
        name: serviceOrderDetailedView,
        page: () {
          Get.find<RatingController>().updateCount(0);
          Get.find<ExpandableListController>().setState(false);
          return getRoute(ServiceOrderDetailedView(
              orderId: Get.arguments['orderId'],
              serviceOrderDetail: Get.arguments['orderDetails'],
              mainServiceCategory: Get.arguments['mainServiceCategory'],
              isRunning: Get.arguments['isRunning']));
        }),
    GetPage(
        name: userDetailsUpdate,
        page: () => getRoute(UserDetailsUpdate(
            isEdit: Get.arguments['isEdit'],
            productId: Get.arguments['productId']))),
    GetPage(
        name: quickHelpPayments,
        page: () => getRoute(const ServicePaymentWidget(
              mainServiceCategory: MainCategory.QUICKHELP,
            ))),
    GetPage(
        name: locationSearch,
        page: () {
          return getRoute(LocationSearchPage(
              isFromHome: (Get.arguments['page'] != null &&
                  (Get.arguments['page'] == initial ||
                      Get.arguments['page'] == '/?page=home')),
              isForAddress: Get.arguments['isForAddress'] ?? false));
        }),
    GetPage(
        name: search,
        page: () => getRoute(const SearchScreen()),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: notification,
        page: () => getRoute(const NotificationScreen()),
        transition: Transition.rightToLeftWithFade,
        transitionDuration: const Duration(milliseconds: 500)),
  ];

  static getRoute(Widget? navigateTo) {
    Get.find<locationPermissionController>().checkLocationStatus();
    return GetBuilder<ConnectivityController>(
        builder: (connectivityController) {
      return connectivityController.status
          ? GetBuilder<locationPermissionController>(
              builder: (currentLocationController) {
              return navigateTo!;
              // return currentLocationController.locationEnabled.value ||
              //         GetPlatform.isWeb
              //     ? navigateTo
              //     : NoLocationAccessScreen(route: Get.currentRoute);
            })
          : const NoInternetScreenView();
    });
  }
}
