import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/data/models/car_model/make.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/car/car_model_bottomsheet.dart';

class GridImageCarBrands extends StatelessWidget {
  final Make? carBrandModel;
  final int? index;

  const GridImageCarBrands({super.key, this.index, this.carBrandModel});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarModelController>(builder: (carModelController) {
      return GestureDetector(
        onTap: () {
          carModelController.carBrandIdChange(carBrandModel!.id!);
          carModelController.selectedBrand(index!);
          carModelController.selectedModel(1500);

          if (carModelController.selectedBrand.value != 1500) {
            Navigator.pop(context);
            carModelController.isModelSearch.value = false;
            if (carModelController.brandList != null &&
                carModelController.brandList!.isNotEmpty) {
              carModelController.fetchCarModelVarients(
                  carModelController.carBrandId.toString());

              if (!Get.isBottomSheetOpen!) {
                Get.bottomSheet(
                    modelVarientBottomSheet(
                      context,
                    ),
                    isScrollControlled: true);
              }
            } else {
              carModelController.fetchData().then((value) {
                if (!Get.isBottomSheetOpen!) {
                  Get.bottomSheet(
                      modelVarientBottomSheet(
                        context,
                      ),
                      isScrollControlled: true);
                }
                carModelController.fetchCarModelVarients(
                    carModelController.carBrandId.toString());
              });
            }
          } else {
            showCustomSnackBar(
                'Your did not select your car brand please select a car brand',
                title: 'Place select car model',
                isError: true);
          }
        },
        child: Stack(
          children: [
            SizedBox(
              height: (carModelController.selectedBrand.value == index)
                  ? 100
                  : MediaQuery.of(context).size.width / 8,
              width: (carModelController.selectedBrand.value == index)
                  ? 100
                  : MediaQuery.of(context).size.width / 8,
              child: CustomImage(
                  image: carBrandModel!.thumbUrl![0].toString(),
                  fit: BoxFit.cover),
            ),
            Visibility(
              visible: carModelController.selectedBrand.value == index,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 219, 14).withOpacity(0.3),
                  // border: Border.all(
                  //   color: Color.fromARGB(255, 255, 219, 14),
                  //   width: 2,
                  // ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
