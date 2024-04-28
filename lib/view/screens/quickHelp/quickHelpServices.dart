import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';
import 'package:shoppe_customer/view/screens/quickHelp/widget/quickHelpServiceTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickHelpServicesPage extends StatelessWidget {
  QuickHelpServicesPage({
    super.key,
    required this.title,
  });
  final String? title;
  //final int index;
  final quickHelpController = Get.find<QuickHelpController>();

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Center(
                      child: Text(title!.toUpperCase(),
                          style: mediumFont(Colors.black))),
                ),
              ),
              centerTitle: true,
              leading: SizedBox(
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            backgroundColor: Colors.white,
            body:
                GetBuilder<QuickHelpController>(builder: (quickHelpController) {
              return quickHelpController.loaderHelper.isLoading
                  ? const LoadingScreen()
                  : quickHelpController.quickHelpServiceList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Services not listed',
                                  style: smallFont(Colors.black)),
                              Get.find<AuthFactorsController>().isLoggedIn.value
                                  ? const SizedBox()
                                  : Text(
                                      'Please select the Car Model...!',
                                      style: mediumFont(Colors.red),
                                    )
                            ],
                          ),
                        )
                      : CustomScrollView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 250,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      child: Image.asset(
                                        Images.quick_help_banner,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(List.generate(
                                  quickHelpController
                                      .quickHelpServiceList.length, (index) {
                                return QuickHelpServiceTile(
                                  index: index,
                                  quickHelpServiceResultData:
                                      quickHelpController
                                          .quickHelpServiceList[index],
                                );
                              })),
                            ),
                            const SliverToBoxAdapter(
                                child: SizedBox(
                              height: 10,
                            ))
                          ],
                        );
            }))
        : const Scaffold(
            body: NoInternetScreenView(),
          );
  }
}
