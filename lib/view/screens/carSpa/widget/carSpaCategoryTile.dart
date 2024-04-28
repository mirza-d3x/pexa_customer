import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/category_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaCategoryTile extends StatelessWidget {
  CarSpaCategoryTile({super.key, this.carSpaResultData, this.index});
  final CategoryModel? carSpaResultData;
  final int? index;
  final carSpaController = Get.find<CarSpaController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print(index);
          print(carSpaResultData!.id);
          if (index != 7 && index != 8) {
            carSpaController
                .getCarSpaServiceWithCatId(carSpaResultData!.id!)
                .then((value) => Get.toNamed(
                      RouteHelper.carSpaService,
                      arguments: {'title': carSpaResultData!.name},
                    ));
          } else {
            carSpaController
                .getCarSpaServiceWithoutCatId(carSpaResultData!.id)
                .then((value) => Get.toNamed(
                      RouteHelper.carSpaService,
                      arguments: {'title': carSpaResultData!.name},
                    ));
          }
        },
        child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: Colors.black,
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
                    image: carSpaResultData!.imageUrl![0],
                    height: 50,
                  )),
                ),
                // SizedBox(height: 10),
                Flexible(
                  child: SizedBox(
                    width: 90,
                    child: Text(carSpaResultData!.name!,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: verySmallFontW600(Colors.black)),
                  ),
                ),
              ],
            )));
  }
}
