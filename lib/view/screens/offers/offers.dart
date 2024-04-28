import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/packageOfferController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/error_screen/no_offer_error_screen.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:shoppe_customer/view/screens/offers/widget/offer_container.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class OfferScreen extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  OfferScreen({super.key});
  _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Get.find<PackageOfferController>().getAllOfers();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(
                title: "Car Spa Trending Offers", isBackButtonExist: false),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: _width,
                //   height: 270,
                //   child: Stack(
                //     children: [
                //       Container(
                //         child: CustomImage(
                //           width: _width,
                //           image:
                //               'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2Foffer%20page%2Foffer-bann.jpeg?alt=media&token=9b52d1a2-742b-4f4d-baf0-e2dd9b0f4398',
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       Positioned(
                //         bottom: 0,
                //         child: Container(
                //           height: 15,
                //           width: _width,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.only(
                //                   topLeft: Radius.circular(20),
                //                   topRight: Radius.circular(20))),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                //<-----OFFER SECTION----->
                // SizedBox(
                //   height: 200,
                //   width: MediaQuery.of(context).size.width,
                //   child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       physics: AlwaysScrollableScrollPhysics(),
                //       itemCount:
                //           Get.find<PackageOfferController>().offerList.length,
                //       itemBuilder: (context, index) {
                //         return MainOfferTile(
                //           data: Get.find<PackageOfferController>().offerList,
                //           index: index,
                //         );
                //       }),
                // ),
                //<-----OFFER SECTION ENDS----->
                GetBuilder<PackageOfferController>(
                    builder: (packageOfferController) {
                  return packageOfferController.loaderHelper.isLoading
                      ? const Center(child: LoadingScreen())
                      : packageOfferController.offerList.isEmpty
                          ? const Expanded(
                              child: NoOfferErrorScreen(
                                isOffer: true,
                              ),
                            )
                          : Expanded(
                              child: SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: false,
                                onRefresh: (() => _onRefresh()),
                                controller: _refreshController,
                                child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemCount:
                                        packageOfferController.offerList.length,
                                    itemBuilder: (context, index) {
                                      return OfferTile(
                                        index: index,
                                        data: packageOfferController.offerList,
                                      );
                                    }),
                              ),
                            );
                }),
              ],
            ),
          )
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
