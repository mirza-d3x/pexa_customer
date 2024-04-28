import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalServiceTile.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/loading/loading_screen.dart';

class MechanicalServices extends StatelessWidget {
  MechanicalServices({
    super.key,
    required this.title,
  });
  final String? title;
  //final int index;
  final mechanicalController = Get.find<MechanicalController>();

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            extendBodyBehindAppBar: true,
            appBar: CustomAppBar(
              title: title,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: GetBuilder<MechanicalController>(
                builder: (mechanicalController) {
              return mechanicalController.loaderHelper.isLoading
                  ? const LoadingScreen()
                  : mechanicalController.mechanicalServicesList.isEmpty
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
                                width: Get.width,
                                height: 250,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      height: 250,
                                      child: CustomImage(
                                        image:
                                            'https://firebasestorage.googleapis.com/v0/b/carclenx.appspot.com/o/Pexa%20Shoppe%2FserviceBanner%2Fmech.jpg?alt=media&token=bb5d7afc-6abc-474b-a9cf-6ae670e2402d',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 10,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          color:
                                              Theme.of(context).colorScheme.background,
                                          borderRadius: const BorderRadius.only(
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
                                  mechanicalController
                                      .mechanicalServicesList.length, (index) {
                                return MechanicalServiceTile(
                                  index: index,
                                  mechanicalServiceResultData:
                                      mechanicalController
                                          .mechanicalServicesList[index],
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
