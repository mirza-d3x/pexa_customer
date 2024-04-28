import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/screens/error_screen/shop_error_screen.dart';
import 'package:shoppe_customer/view/screens/order/widget/carShoppeOrderViewTile.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// ignore: must_be_immutable
class CarShoppeRunningOrders extends StatelessWidget {
  CarShoppeRunningOrders({super.key});

  int pageNumber = 1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    pageNumber++;
    print(pageNumber);
    changePage(pageNumber);
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    changePage(1);
  }

  changePage(int page) async {
    await Get.find<ProductCategoryController>()
        .getOrderRunningDetailsShoppe(page.toString());
    if (!Get.find<ProductCategoryController>()
        .isShoppeRunningOrderLoading
        .value) {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<ProductCategoryController>().getOrderRunningDetailsShoppe('1');
    // });
    return GetBuilder<ProductCategoryController>(
        builder: (productCategoryController) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: productCategoryController.orderDetailsTemp.isEmpty
            ? productCategoryController.isShoppeRunningOrderLoading.value
                ? Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF4B4B4D),
                      rightDotColor: const Color(0xFFf7d417),
                      size: 50,
                    ),
                  )
                : const ShopErrorScreen(
                    title: 'No Order found',
                    subTitle: 'Look like you haven\'nt made your order yet',
                    imagePath: Images.empty_order_icon,
                    route: RouteHelper.shoppeListing,
                  )
            // : Center(
            //     child: Text("Not found"),
            //   )
            : SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: (Get.find<ProductCategoryController>()
                            .orderDetails
                            .length >=
                        20)
                    ? _onLoading
                    : () async {
                        await Future.delayed(const Duration(milliseconds: 500), () {
                          _refreshController.loadComplete();
                        });
                      },
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = const CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("release to load more");
                    } else {
                      body = const Text("No more Data");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        productCategoryController.orderDetailsTemp.length,
                    itemBuilder: (context, index) {
                      return ShoppeOrderViewTile(
                          shoppeOrderResultData: productCategoryController
                              .orderDetailsTemp[index]);
                    }),
              ),
      );
    });
  }
}
