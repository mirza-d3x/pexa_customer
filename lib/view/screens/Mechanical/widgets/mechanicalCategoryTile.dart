import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/category_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalCategoryTile extends StatelessWidget {
  MechanicalCategoryTile({super.key, this.mechanicalResultData, this.index});
  final CategoryModel? mechanicalResultData;
  final int? index;
  final mechanicalController = Get.find<MechanicalController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(index);
          print(mechanicalResultData!.id);
          mechanicalController
              .getMechanicalServiceWithCatId(mechanicalResultData!.id!)
              .then((value) => Get.toNamed(RouteHelper.mechanicalService,
                  arguments: {'title': mechanicalResultData!.name}));
        },
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(
                      child: CustomImage(
                    image: mechanicalResultData!.imageUrl![0],
                    height: 50,
                  )),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: SizedBox(
                    width: 90,
                    child: Text(
                      mechanicalResultData!.name!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: verySmallFontW600(Colors.black),
                    ),
                  ),
                ),
              ],
            )));
  }
}
