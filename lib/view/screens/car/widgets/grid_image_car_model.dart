import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/data/models/car_model/model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';

class GridImageCarModels extends StatelessWidget {
  GridImageCarModels({super.key, this.index, this.carModelsResultData});
  final carModelController = Get.find<CarModelController>();
  final Model? carModelsResultData;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(carModelsResultData!.carType);
        print(carModelsResultData!.id);
        carModelController.carModelIdChange(
            carModelsResultData!.id, carModelsResultData!.carType!);
        carModelController.selectedModel(index!);
      },
      child: Stack(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   color: Colors.grey,
                //   width: 1,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 2, bottom: 2),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomImage(
                      image: carModelsResultData!.thumbUrl![0].toString(),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      carModelsResultData!.name.toString(),
                      style:
                          const TextStyle(fontSize: 9, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: carModelController.selectedModel.value == index,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 219, 14).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 219, 14),
                    width: 2,
                  ),
                ),
                //color: Colors.white.withAlpha(200),
                // child: Center(
                //   child: Image.asset('assets/image/select.png'),
                // ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
