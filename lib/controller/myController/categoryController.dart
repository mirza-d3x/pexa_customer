import 'dart:math';

import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/data/models/carShoppe/productListModel.dart';
import 'package:shoppe_customer/data/repository/order_api.dart';
import 'package:shoppe_customer/data/repository/productApi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/data/models/carShoppe/shippingModel.dart';
import 'package:shoppe_customer/data/models/category_model.dart';
import 'package:shoppe_customer/data/models/common/featured_model.dart';
import 'package:shoppe_customer/data/models/explore_data.dart';
import 'package:shoppe_customer/data/models/product_details.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class ProductCategoryController extends GetxController implements GetxService {
  var categoryList = [].obs;
  var subCategoryList = [].obs;
  var productList = [].obs;
  var productListTemp = [].obs;
  var allProductList = [].obs;
  var allProductListTemp = [].obs;
  var allProdAvailable = false.obs;
  var product = {}.obs;
  var prodAvailable = false.obs;
  var subCatAvailable = false.obs;
  var orderDetails = [].obs;
  var orderDetailsTemp = [].obs;
  var orderHistoryDetails = [].obs;
  var orderHistoryDetailsTemp = [].obs;
  var orderId = ''.obs;
  var buyNowShipping = 0.obs;
  var productLocationList = [].obs;
  var isFound = true.obs;
  int? allPdtTotalPage = 0;
  int? categoryListPdtTotalPage = 0;

  FeaturedProducts? featured;
  FeaturedProducts? offered;
  List<ExploreData> exploreList = [];
  List<ShippingResultData> shippingDetailsList = [];

  List<ExploreData> explore = [];
  final ProductAPI productAPI;
  final OrderApi orderApi;
  LoaderHelper loaderHelper = LoaderHelper();
  ProductCategoryController(
      {required this.orderApi, required this.productAPI});

  @override
  void onInit() {
    // fetchCategoryData();
    // fetchFeaturedProducts('feature');
    // fetchFeaturedProducts('offered');
    // // exploreSection();
    // fetchAllProductListData('1');
    // setLocationForProductFetch();
    super.onInit();
  }

  setProductLocation(List<dynamic> list) {
    productLocationList = list as RxList<dynamic>;
  }

  setFeaturedProduct(List<FeaturedProduct>? featuredProducts) {
    featured = FeaturedProducts(resultData: featuredProducts);
    update();
  }

  setOfferedProduct(List<FeaturedProduct>? offeredProducts) {
    offered = FeaturedProducts(resultData: offeredProducts);
    update();
  }

  setExploreList(List<ExploreData> list) {
    exploreList = list;
    update();
  }

  Future exploreSection() async {
    if (explore.isNotEmpty) {
      explore.clear();
    }
    var randomCarspa = [];
    var randomMechanical = [];
    var randomQuickHelp = [];
    if (exploreList.where((element) => element.assetType == "Carspa").isNotEmpty) {
      for (var i = 0; i < 2; i++) {
        var a = Random().nextInt(exploreList
            .where((element) => element.assetType == "Carspa")
            .length);
        randomCarspa.add(exploreList
            .where((element) => element.assetType == "Carspa")
            .toList()[a]);
        if (i == 1) {
          if (randomCarspa[0] == randomCarspa[1]) {
            randomCarspa.removeAt(1);
            i = 0;
          }
        }
      }
      for (var element in randomCarspa) {
        explore.add(element);
      }
      update();
    }
    if (exploreList
            .where((element) => element.assetType == "Mechanical").isNotEmpty) {
      for (var i = 0; i < 2; i++) {
        randomMechanical.add(exploreList
                .where((element) => element.assetType == "Mechanical")
                .toList()[
            Random().nextInt(exploreList
                .where((element) => element.assetType == "Mechanical")
                .length)]);
        if (i == 1) {
          if (randomMechanical[0] == randomMechanical[1]) {
            randomMechanical.removeAt(1);
            i = 0;
          }
        }
      }
      for (var element in randomMechanical) {
        explore.add(element);
      }
      update();
    }
    if (exploreList
            .where((element) => element.assetType == "Quickhelp").isNotEmpty) {
      for (var i = 0; i < 2; i++) {
        randomQuickHelp.add(exploreList
                .where((element) => element.assetType == "Quickhelp")
                .toList()[
            Random().nextInt(exploreList
                .where((element) => element.assetType == "Quickhelp")
                .length)]);
        if (i == 1) {
          if (randomQuickHelp[0] == randomQuickHelp[1]) {
            randomQuickHelp.removeAt(1);
            i = 0;
          }
        }
      }
      for (var element in randomQuickHelp) {
        explore.add(element);
      }
      update();
    }
    print(explore.length);
    explore.shuffle();
    update();
    return explore;
  }

  Future setLocationForProductFetch() async {
    if (Get.find<locationPermissionController>().userChanged == false) {
      try {
        var position = await GeolocatorPlatform.instance.getCurrentPosition();
        productLocationList.value = [
          position.latitude.toDouble(),
          position.longitude.toDouble()
        ].toList();
        update();
      } catch (e) {
        print(e);
      }
    }
  }

  var isFetchCategoryLoading = false;

  Future fetchCategoryData() async {
    // if (categoryList.isNotEmpty) {
    //   categoryList.clear();
    //   update();
    // }
    isFetchCategoryLoading = true;
    update();
    Response response = await (productAPI.categoryAPI());
    if (response.body != null) {
      categoryList.clear();
      response.body['resultData'].forEach((element) {
        categoryList.add(CategoryModel.fromJson(element));
      });
    }
    isFetchCategoryLoading = false;
    // return response;
    update();
  }

  Future fetchFeaturedProducts(String type) async {
    loaderHelper.startLoader();
    update();
    var response = await productAPI.fetchFuturedProduct(type);
    if (type == 'feature') {
      featured = FeaturedProducts.fromJson(response.body);
      featured!.resultData!.shuffle();
      update();
        } else if (type == 'offered') {
      offered = FeaturedProducts.fromJson(response.body);
      offered!.resultData!.shuffle();
      update();
        }
    loaderHelper.cancelLoader();
    update();
  }

  Future fetchSubCategoryData(String catId) async {
    if (subCategoryList.isNotEmpty) {
      subCategoryList.clear();
      update();
    }
    subCatAvailable.value = false;
    update();
    var response = await productAPI.subCategoryAPI(catId);
    if (response == null) {
      subCatAvailable.value = true;
      update();
    }
    subCategoryList.value = response.resultData.toList();
    if (subCategoryList.isEmpty) {
      subCatAvailable.value = true;
      update();
    } else {
      subCatAvailable.value = false;
      update();
    }
  }

  var fetchAllProductLoading = false.obs;
  Future fetchAllProductListData(String page) async {
    if (allProductList.isNotEmpty) {
      allProductList.clear();
      update();
    }
    if (page == '1') {
      fetchAllProductLoading(true);
      if (allProductListTemp.isNotEmpty) {
        allProductListTemp.clear();
        update();
      }
    }
    allProdAvailable.value = false;

    update();
    Response response = await (productAPI.getAllProductList(page));
    ProductListModel productListResponse =
        productListModelFromJson(response.bodyString!);
    allPdtTotalPage = productListResponse.totalPages;
    allProductList.value = productListResponse.resultData!;
    update();
    for (var element in allProductList) {
      allProductListTemp.add(element);
    }
    if (page == '1') {
      allProductListTemp.shuffle();
    }
    update();
      if (allProductList.isEmpty) {
      allProdAvailable.value = true;
      update();
    } else {
      allProdAvailable.value = false;
      update();
    }
    fetchAllProductLoading(false);
    update();
    print(allProductListTemp.length);
  }

  Future fetchProductsByCategory(
      String? categoryId, List data, String page) async {
    if (productList.isNotEmpty) {
      productList.clear();
      update();
    }
    if (page == '1') {
      loaderHelper.startLoader();
      update();
      if (productListTemp.isNotEmpty) {
        productListTemp.clear();
        update();
      }
    }
    prodAvailable.value = false;
    update();
    var response =
        await productAPI.getProductByCategory(categoryId, page, data);
    if (response == null) {
      prodAvailable.value = true;
      update();
    } else {
      ProductListModel productListResponse =
          productListModelFromJson(response.bodyString);
      categoryListPdtTotalPage = productListResponse.totalPages;
      productList.value = productListResponse.resultData!;
      update();
      for (var element in productList) {
        productListTemp.add(element);
      }
      if (page == "1") {
        productListTemp.shuffle();
      }
      update();
    }
    if (productList.isEmpty) {
      loaderHelper.cancelLoader();
      update();
      prodAvailable.value = true;
      update();
    } else {
      prodAvailable.value = false;
      update();
    }
    loaderHelper.cancelLoader();
    update();
    print(productListTemp.length);
  }

  Future fetchProductListData(String? subId, List data, String page) async {
    loaderHelper.startLoader();
    if (productList.isNotEmpty) {
      productList.clear();
      update();
    }
    if (page == '1') {
      loaderHelper.startLoader();
      if (productListTemp.isNotEmpty) {
        productListTemp.clear();
        update();
      }
    }
    prodAvailable.value = false;
    update();
    var response = await productAPI.getProductList(subId, data, page);
    if (response == null) {
      prodAvailable.value = true;
      update();
    } else {
      productList.value = response.resultData.toList();
      update();
      for (var element in productList) {
        productListTemp.add(element);
      }
      update();
    }
    if (productList.isEmpty) {
      prodAvailable.value = true;
      update();
    } else {
      prodAvailable.value = false;
      update();
    }
    loaderHelper.cancelLoader();
  }

  Future fetchProductDetails(String prodId) async {
    loaderHelper.startLoader();
    update();
    if (product.isNotEmpty) {
      product.clear();
      update();
    }
    var response = await productAPI.getProductDetails(prodId);
    if (response != null) {
      product.value = response['resultData'] as Map;
      ProductId productDetails = ProductId.fromJson(response['resultData']);
      Get.find<ProductDetailsController>().setProductDetails(productDetails);

      print('Details \n ${product['quantity']} \n Details');
    }
    loaderHelper.cancelLoader();
    update();
  }

  var isShoppeRunningOrderLoading = false.obs;
  var foundShoppeRunningOrder = false.obs;

  Future getOrderRunningDetailsShoppe(String page) async {
    foundShoppeRunningOrder.value = true;
    update();
    if (page == '1') {
      isShoppeRunningOrderLoading(true);
      if (orderDetailsTemp.isNotEmpty) {
        orderDetailsTemp.clear();
        update();
      }
    }
    if (orderDetails.isNotEmpty) {
      orderDetails.clear();
      update();
    }
    var response = await productAPI.getRunningOrderStatus(page);
    if (response != null) {
      orderDetails.value = response.resultData.toList();
      update();
      if (orderDetails.isEmpty) {
        foundShoppeRunningOrder.value = false;
        isShoppeRunningOrderLoading(false);
        update();
      } else {
        for (var element in orderDetails) {
          orderDetailsTemp.add(element);
          update();
        }
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        foundShoppeRunningOrder.value = false;
        isShoppeRunningOrderLoading(false);
        update();
      });
    }
  }

  var isShoppeOrderHistoryLoading = false.obs;
  var foundShoppeOrderHistory = false.obs;
  Future getOrderHistoryDetailsShoppe(String page) async {
    if (page == '1') {
      isShoppeOrderHistoryLoading(true);
      if (orderHistoryDetailsTemp.isNotEmpty) {
        orderHistoryDetailsTemp.clear();
        update();
      }
    }
    if (orderHistoryDetails.isNotEmpty) {
      orderHistoryDetails.clear();
      update();
    }
    var response = await productAPI.getHistoryOrderStatus(page);
    if (response != null) {
      orderHistoryDetails.value = response.resultData.toList();
      update();
      if (orderHistoryDetails.isEmpty) {
        foundShoppeOrderHistory.value = false;
        isShoppeOrderHistoryLoading(false);
        update();
      } else {
        for (var element in orderHistoryDetails) {
          orderHistoryDetailsTemp.add(element);
        }
        update();
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        foundShoppeOrderHistory.value = false;
        isShoppeOrderHistoryLoading(false);
        update();
      });
    }
  }

  var isBuying = false.obs;
  Future buyNowProduct(Map<String, dynamic> body) async {
    isBuying.value = true;
    update();
    var response = await productAPI.buyNowProduct(body);
    isBuying.value = false;
    update();
    if (response != null) {
      if (response['status'] == "OK") {
        orderId.value = response['resultData']['_id'];
        update();
        showCustomSnackBar('Order placed...!', title: 'Success', isError: true);
        return true;
      } else {
        showCustomSnackBar('Order not placed. Error occured..!',
            title: 'Error', isError: true);
        return false;
      }
    }
  }

  Future getShippingDetails(String total) async {
    Response response = await productAPI.getShippingDetails();
    if (response.status.isOk) {
      shippingDetailsList = [];
      response.body['resultData'].forEach((element) {
        shippingDetailsList.add(ShippingResultData.fromJson(element));
      });
      if (shippingDetailsList.isNotEmpty) {
        Get.find<BuyNowController>().setShippingData(shippingDetailsList);
        if (int.parse(total) >= shippingDetailsList[0].minimum!) {
          buyNowShipping.value = 0;
          update();
        } else {
          buyNowShipping.value = shippingDetailsList[0].rate as int;
          update();
        }
      }
      return true;
    } else {
      return false;
    }
  }

  setShippingPrice(int price) {
    buyNowShipping.value = price;
    update();
  }
}
