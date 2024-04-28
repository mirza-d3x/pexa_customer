import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/screens/error_screen/shop_error_screen.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/order/widget/serviceOrderViewTile.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

// ignore: must_be_immutable
class CarSpaRunningOrders extends StatelessWidget {
  CarSpaRunningOrders({super.key});

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
    await Get.find<OrderController>().getOrdersList(
        page: page.toString(),
        category: MainCategory.CARSPA,
        orderPage: OrderPage.RUNNING);
    if (!Get.find<OrderController>().isRunningOrderLoader.isLoading) {
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<orderController>().getCarSpaRunningOrders('1');
    // });
    return GetBuilder<OrderController>(builder: (orderController) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: orderController.OrderListTempRunning.isEmpty
            ? orderController.isRunningOrderLoader.isLoading
                ? Center(
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: const Color(0xFF4B4B4D),
                      rightDotColor: const Color(0xFFf7d417),
                      size: 50,
                    ),
                    // child: DefaultTextStyle(
                    //   style: smallFontW600(Colors.red),
                    //   child: AnimatedTextKit(
                    //     animatedTexts: [
                    //       WavyAnimatedText('Orders Loading...!'),
                    //     ],
                    //     repeatForever: true,
                    //   ),
                    // ),
                  )
                : const ShopErrorScreen(
                    title: 'No Order found',
                    subTitle: 'Look like you haven\'t made your order yet',
                    imagePath: Images.empty_order_icon,
                    route: RouteHelper.carSpaService,
                  )
            : SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: _onRefresh,
                onLoading: (orderController.OrderListRunning.length >= 20)
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
                    itemCount: orderController.OrderListTempRunning.length,
                    itemBuilder: (context, index) {
                      return ServiceOrderViewTile(
                          mainServiceCategory: MainCategory.CARSPA,
                          orderDetails:
                              orderController.OrderListTempRunning[index]);
                    }),
              ),
      );
    });
  }
}
