import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/car/widgets/grid_image_car_model.dart';

Widget modelVarientBottomSheet(BuildContext context) {
  // var carModelController = Get.find<CarModelController>();
  // var userModelController = Get.find<AuthFactorsController>();
  TextEditingController modelController = TextEditingController();
  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * .85,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: GetBuilder<CarModelController>(
                      builder: (carModelController) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Image.asset(
                                Images.car_ico,
                                color: Colors.black,
                                width: 25,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              carModelController.isModelSearch.value
                                  ? Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, left: 10, right: 10),
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          border: Border.all(
                                              color: botAppBarColor2),
                                        ),
                                        child: Center(
                                          child: TextField(
                                            onTap: () {
                                              carModelController
                                                  .selectedModel(1500);
                                            },
                                            onChanged: (value) {
                                              carModelController.searchModel(
                                                  value.toUpperCase(),
                                                  carModelController
                                                      .carBrandAPIId.value);
                                            },
                                            controller: modelController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ))
                                  : Text(
                                      'Select your Car Model',
                                      style: mediumFont(Colors.black),
                                    ),
                              Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          carModelController
                                              .setModelSearchClickStatus();
                                        },
                                        child: Icon(
                                          Icons.search,
                                          size: 25,
                                          color: botAppBarColor2,
                                        ),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                GetBuilder<CarModelController>(builder: (carModelController) {
                  return Expanded(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10),
                        child: carModelController.carModelVarients.isEmpty
                            ? Center(
                                child: carModelController.noModelFound.value
                                    ? Text(
                                        "No Model Found..!",
                                        style: mediumFont(Colors.black),
                                      )
                                    : SizedBox(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset(Images.spinner,
                                            fit: BoxFit.fill)),
                              )
                            : GridView.builder(
                                controller: scrollController,
                                itemCount:
                                    carModelController.carModelVarients.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 5),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1,
                                        crossAxisCount:
                                            ResponsiveHelper.isDesktop(context)
                                                ? 8
                                                : 4,
                                        // crossAxisSpacing: 4.0,
                                        crossAxisSpacing:
                                            ResponsiveHelper.isDesktop(context)
                                                ? 30
                                                : 10,
                                        // MediaQuery.of(context).size.width /
                                        //     6.316,
                                        mainAxisSpacing:
                                            ResponsiveHelper.isDesktop(context)
                                                ? 30
                                                : 10),
                                itemBuilder: (BuildContext context, int index) {
                                  return GridImageCarModels(
                                    carModelsResultData: carModelController
                                        .carModelVarients[index],
                                    index: index,
                                  );
                                })),
                  );
                }),
                GetBuilder<CarModelController>(
                  builder: (carModelController) => InkWell(
                    onTap: (carModelController.selectedModel.value != 1500)
                        ? () {
                            if (!GetPlatform.isMobile &&
                                Get.find<AuthFactorsController>()
                                        .isLoggedIn
                                        .value ==
                                    false) {
                              Get.find<AuthFactorsController>()
                                  .setMIDValue(true);
                              Get.find<AuthFactorsController>().setCarType();
                            }
                            Get.find<AuthFactorsController>()
                                .updateUserModelId(
                                    carModelController.carModelId,
                                    carModelController.carModelType.value)
                                .then((value) {
                              // categoryModelController.fetchCategoryData();
                            });
                            Get.find<CarSpaController>().getCarSpaServiceWithCatId(Get.find<CarSpaController>().carSpaSelectedCategory.value);
                            Get.back();
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      height: Get.height * 0.05,
                      width: Get.width * 0.3,
                      decoration: BoxDecoration(
                        color: (carModelController.selectedModel.value != 1500)
                            ? botAppBarColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Select',
                          style: mediumFont(Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
