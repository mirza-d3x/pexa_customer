import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/product_details.dart';

class ProductDetailsController extends GetxController implements GetxService {
  var outOfStock = false.obs;
  var cartList = [].obs;
  var pricePercentage = [].obs;
  var isPercentageCalculate = false.obs;
  var oneTouch = true.obs;
  var prodCount = 1.obs;
  ProductId? productDetails;

  checkStockStatus(int stock) {
    if (stock <= 0) {
      outOfStock.value = true;
      update();
    } else {
      outOfStock.value = false;
      update();
    }
  }

  setProductDetails(ProductId? productDetails) {
    this.productDetails = productDetails;
    update();
  }

  Future calculatePricePercentage(int price, int offerPrice) async {
    if (isPercentageCalculate.value) {
      pricePercentage.clear();
      update();
    }
    pricePercentage
        .add(((price - offerPrice) * 100 / price).round().toString());
    isPercentageCalculate.value = false;
    update();
  }

  deletePercentage(int index) {
    pricePercentage.removeAt(index);
    update();
  }

  addProductCount() {
    prodCount = prodCount + 1;
    update();
  }

  subtractProductCount() {
    if (prodCount > 1) {
      prodCount = prodCount - 1;
      update();
    }
  }
}
