import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/appVersionController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/drawer_controller.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/initial_loader_controller.dart';
import 'package:shoppe_customer/view/screens/home/widgets/header.dart';
import 'package:shoppe_customer/view/screens/home/widgets/product_display.dart';
import 'package:shoppe_customer/view/screens/home/widgets/slider.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/profile/userDetailsUpdatePage.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.newUser = false});
  final bool newUser;

  var userDetails = Get.find<AuthFactorsController>();

  var authController = Get.find<AuthFactorsController>();

  var locationController = Get.find<locationPermissionController>();

  ValueNotifier valueNotifier = ValueNotifier(false);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  var connectivityController = Get.find<ConnectivityController>();

  final ScrollController _scrollController = ScrollController();

  void checkData() {
    if (userDetails.mailUpdated == false) {
      Get.off(() => UserDetailsUpdate(
            isEdit: false,
          ));
    }
    print(userDetails.mailUpdated);
  }

  void _loadData() async {
    valueNotifier.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    Get.find<InitialLoaderController>().loadData();
    Get.find<AppVersionController>().checkVersionBalance();
    _refreshController.refreshCompleted();
    valueNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Get.find<locationPermissionController>().getUserLocation();
    // });
    return (Get.find<ConnectivityController>().status)
        ? GetBuilder<NavigationDrawerController>(builder: (scaff) {
            if (scaff.scaffoldKey.currentState != null &&
                scaff.scaffoldKey.currentState!.isDrawerOpen) {
              scaff.closeDrawer();
            }

            return Scaffold(
              key: scaff.scaffoldKey,
              /*drawer: HomeDrawer(controller: Get.find<AuthFactorsController>()),*/
              backgroundColor: const Color(0xFFF0F4F7),
              body:
                  /* SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                scrollController: _scrollController,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      print("IDle !! : ${mode == LoadStatus.idle}");
                      body = Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      print("LOading !! ");
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      print("FAILDDDD !! ");
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      print("CAN LOADDDDING !! ");
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                onLoading: () => _loadData(),
                onRefresh: () => _loadData(),
                controller: _refreshController,

                child:ValueListenableBuilder(
                    valueListenable: valueNotifier,
                  builder: (context, value, child){
                      if(value){
                        return Container();
                      }
                      else {
                        return */
                  Column(
                children: [
                  Header(newUser: newUser),
                  const Expanded(
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      child: Column(
                        children: [
                          ImageSlider(),
                          SizedBox(
                            height: 10,
                          ),
                          HomeProducts(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        : const Scaffold(body: NoInternetScreenView());
  }
}
