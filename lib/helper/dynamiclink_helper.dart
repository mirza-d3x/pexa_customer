import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkHelper {
  initializeDynamicLinkHelper() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      handleDynamicLink(data);
    }
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      handleDynamicLink(dynamicLinkData);
    }).onError((error) {
      // Handle errors
      print(error);
    });
  }

  handleDynamicLink(PendingDynamicLinkData dynamicLinkData) {
    var path = dynamicLinkData.link.path;
    if (path.contains('id=')) {
      var id = path.substring(4);
      if (Get.find<AuthFactorsController>().isLoggedIn.value) {
        Get.find<CartControllerFile>().checkProductInCart(id);
        Get.find<ProductCategoryController>()
            .fetchProductDetails(id)
            .then((value) {
          Get.toNamed(RouteHelper.getProductDetailsRoute(pid: id));
        });
      } else {
        Get.offAllNamed(RouteHelper.getSplashRoute(productId: id));
      }
    }
  }

  Future createDynamicLinkProduct(
      {required String image,
      String? productId,
      String? productName,
      String? description}) async {
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.carclenx.com/id=$productId"),
      uriPrefix: "https://pexa.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.carclenx.motor.shoping",
        minimumVersion: 57,
      ),
      iosParameters: const IOSParameters(
        bundleId: "com.carclenx.motor.shoping",
        appStoreId: "1613868591",
        minimumVersion: "3.0.4",
      ),
      // googleAnalyticsParameters: const GoogleAnalyticsParameters(
      //   source: "twitter",
      //   medium: "social",
      //   campaign: "example-promo",
      // ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: productName,
          imageUrl: Uri.parse(image),
          description: description),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink;
  }

  shareContent(
      {required String image,
      String? productId,
      String? productName,
      String? description}) async {
    // _onShare method:
    final box = Get.context!.findRenderObject() as RenderBox;
    var dynamicLink = await createDynamicLinkProduct(
        productId: productId,
        image: image,
        productName: productName,
        description: description);
    await Share.share(
      dynamicLink.shortUrl.toString(),
      subject: productName,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
