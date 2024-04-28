import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticHelper {
  shoppeCheckoutLog(
      {double? price,
      String? productName,
      String? productId,
      int? qty,
      String? Coupon}) async {
    await FirebaseAnalytics.instance.logBeginCheckout(
        value: price,
        currency: 'INR',
        items: [
          AnalyticsEventItem(
            itemName: productName,
            itemId: productId,
            price: price,
            quantity: qty,
          ),
        ],
        coupon: '10PERCENTOFF');
  }
}
