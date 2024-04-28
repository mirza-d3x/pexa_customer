import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/car/widgets/grid_image_car_brand.dart';

Widget carBrandBottomSheet(
  BuildContext context,
) {
  TextEditingController brandController = TextEditingController();
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child:
                GetBuilder<CarModelController>(builder: (carModelController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
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
                              carModelController.isMakeSearch.value
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
                                                  .carBrandsSelected(1500);
                                            },
                                            onChanged: (value) {
                                              carModelController.searchBrand(
                                                  value.toUpperCase());
                                            },
                                            controller: brandController,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ))
                                  : Text(
                                      'Select your Car Brand',
                                      style: mediumFont(Colors.black),
                                    ),
                              // Expanded(
                              //     flex: 1,
                              //     child: SizedBox(
                              //       child: Align(
                              //         alignment: Alignment.centerRight,
                              //         child: GestureDetector(
                              //           onTap: () {
                              //             carModelController
                              //                 .setSearchClickStatus();
                              //           },
                              //           child: Icon(
                              //             Icons.search,
                              //             size: 25,
                              //             color: botAppBarColor2,
                              //           ),
                              //         ),
                              //       ),
                              //     ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: Colors.yellow,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding:
                          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                      child: carModelController.carModel.isEmpty
                          ? Center(
                              child: carModelController.noMakeFound.value
                                  ? Text(
                                      'No Brand Found..!',
                                      style: mediumFont(Colors.black),
                                    )
                                  : LoadingAnimationWidget.twistingDots(
                                      leftDotColor: const Color(0xFF4B4B4D),
                                      rightDotColor: const Color(0xFFf7d417),
                                      size: 50,
                                    ),
                            )
                          : GridView.builder(
                              controller: scrollController,
                              itemCount: carModelController.carModel.length - 1,
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: Get.width / 18),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount:
                                    ResponsiveHelper.isDesktop(context) ? 8 : 4,
                                // crossAxisSpacing: 57,
                                crossAxisSpacing:
                                    ResponsiveHelper.isDesktop(context)
                                        ? 30
                                        : 15,
                                mainAxisSpacing:
                                    ResponsiveHelper.isDesktop(context)
                                        ? 30
                                        : 15,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(15)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 3,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    // border: Border.all(
                                    //     color: Colors.grey.withOpacity(.5)),
                                  ),
                                  child: GridImageCarBrands(
                                    carBrandModel:
                                        carModelController.carModel[index],
                                    index: index,
                                  ),
                                );
                              }),
                    ),
                  ),
                  // Container(
                  //   height: 50,
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     color: Colors.yellow,
                  //     borderRadius: BorderRadius.all(Radius.circular(15)),
                  //   ),
                  //   child: Text('Select'),
                  // ),
                ],
              );
            }),
          ),
        );
      });
}
