import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/tab_controller.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalCategoryTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalSectionNew extends StatelessWidget {
  const MechanicalSectionNew({super.key});

  @override
  Widget build(BuildContext context) {
    final control = Get.put(TabControllerMethod());
    final mechanicalController = Get.find<MechanicalController>();

    return Obx(
      () => SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
              image: control.tabIndex.value == 1
                  ? const DecorationImage(
                      image: AssetImage(
                        "assets/carSpa/logo2.png",
                      ),
                      fit: BoxFit.cover,
                    )
                  : null),
          child: CustomScrollView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.0),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Obx(
                        () => mechanicalController
                                    .mechanicalCategoryList.isEmpty
                            ? Container(
                                child: const Center(
                                child: Text('No Products'),
                              ))
                            : MechanicalCategoryTile(
                                index: index,
                                mechanicalResultData: mechanicalController
                                    .mechanicalCategoryList[index],
                              ),
                      );
                    },
                    childCount:
                        mechanicalController.mechanicalCategoryList.isNotEmpty
                            ? control.tabIndex.value == 6
                                ? mechanicalController
                                            .mechanicalCategoryList.length >
                                        3
                                    ? 3
                                    : mechanicalController
                                        .mechanicalCategoryList.length
                                : mechanicalController
                                    .mechanicalCategoryList.length
                            : 0,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
