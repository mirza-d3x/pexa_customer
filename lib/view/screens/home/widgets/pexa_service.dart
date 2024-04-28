import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/data/models/carSpa/carWashModel.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';

class PexaService extends StatefulWidget {
  final type;
  final data;
  final int? index;
  const PexaService({super.key, this.type, this.index, this.data});

  @override
  State<PexaService> createState() => _PexaServiceState();
}

class _PexaServiceState extends State<PexaService> {
  final carSpaController = Get.find<CarSpaController>();
  final categoryModelController = Get.find<ProductCategoryController>();
  final mechanicalController = Get.find<MechanicalController>();
  final quickHelpController = Get.find<QuickHelpController>();

  List CarWashServicee = [
    CarWashModel(
        serviceImage: "assets/serviceImage/CarWash.png",
        serviceName: "Car Washing"),
    CarWashModel(
        serviceImage: "assets/serviceImage/CarSteaming.png",
        serviceName: "Car Steaming"),
    CarWashModel(
        serviceImage: "assets/serviceImage/RainTreatment.png",
        serviceName: "Other Services"),
    CarWashModel(
        serviceImage: "assets/serviceImage/InteriorCleaning.png",
        serviceName: "Interior Cleaning"),
    CarWashModel(
        serviceImage: "assets/serviceImage/ScratchRemoval.png",
        serviceName: "Scratch Removal"),
    CarWashModel(
        serviceImage: "assets/serviceImage/WaterMarkRemoval.png",
        serviceName: "Watermark\nRemoval"),
    CarWashModel(
        serviceImage: "assets/serviceImage/PolishWaxing.png",
        serviceName: "Polish & Waxing"),
    CarWashModel(
        serviceImage: "assets/serviceImage/BikeWash.png",
        serviceName: "Bike washing"),
    CarWashModel(
        serviceImage: "assets/serviceImage/HouseKeeping.png",
        serviceName: "House Keeping"),
    CarWashModel(
        serviceImage: "assets/serviceImage/RainTreatment.png",
        serviceName: "Rain Repellent\nTreatment"),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthFactorsController>(builder: (authController)
    {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Pexa Services",
              style: smallFontNew(Colors.black),
            ),
            GestureDetector(
                onTap: () {
                  if (carSpaController.carSpaCategory.isEmpty) {
                    carSpaController.getAllCarSpaCategory();
                  }
                  Get.toNamed(RouteHelper.serviceListing, arguments: [
                    {
                      'title': 'Mobile Car Wash',
                      'type': 'carSpa',
                      'data': carSpaController.carSpaCategory
                    }
                  ]);
                },
                child: Text(
                  "See All",
                  style: smallFontNew(Colors.blue),
                )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 140,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: CarWashServicee.length,
            physics: const ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GetBuilder<CarSpaController>(builder: (carSpaController)
              {
                return GestureDetector(
                  onTap: () {
                    /* if (!authController.isMIdAvailable) {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Information',
                              style: largeFont(Colors.red),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'You have to choose Car Model to continue',
                                    textAlign: TextAlign.center,
                                    style: mediumFont(Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  'OK',
                                  style: largeFont(Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  if (!Get.isBottomSheetOpen!) {
                                    Get.bottomSheet(
                                        carBrandBottomSheet(context),
                                        isScrollControlled: true);
                                  }
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    if (widget.type == 'mechanical') {
                      mechanicalController.getMechanicalServiceWithCatId(
                          widget.data.id);
                      Get.toNamed(RouteHelper.mechanicalService,
                          arguments: {'title': widget.data.name});
                    } else if (widget.type == 'carSpa') {
                      if (index != 7 && index != 8) {
                        carSpaController.getCarSpaServiceWithCatId(widget.data
                            .id);
                        Get.toNamed(RouteHelper.carSpaService,
                            arguments: {'title': widget.data.name});
                      } else {
                        carSpaController.getCarSpaServiceWithoutCatId(widget
                            .data.id);
                        Get.toNamed(RouteHelper.carSpaService,
                            arguments: {'title': widget.data.name});
                      }
                    } else {
                      quickHelpController.getQuickHelpServiceWithCatId(
                          widget.data.id);
                      Get.toNamed(RouteHelper.quickHelpService,
                          arguments: {'title': widget.data.name});
                    }
                  }*/

                    /*Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context) => ServiceList(
                      title: 'Mobile Car Wash',
                      data:carSpaController.carSpaCategory,
                      type:'carSpa'),
                )
                );*/

                    carSpaController.getCarSpaServiceWithCatId(carSpaController.carSpaCategory[index].id);
                    Get.toNamed(RouteHelper.carSpaService,
                        arguments: {'title': carSpaController.carSpaCategory[index].name});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Stack(children: [
                      Container(
                        height: 130,
                        width: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage(
                                    CarWashServicee[index].serviceImage))),
                        child: Image.asset(
                            "assets/serviceImage/BottomiMAGE.png"),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 6,

                        child: Text(
                          CarWashServicee[index].serviceName,
                          style: veryverySmallFontW600(Colors.white),
                        ),
                      ),
                    ]),
                  ),
                );
              });
            },
          ),
        ),
        //   SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Row(
        //       children: [
        //         GestureDetector(
        //           onTap: () {
        //
        // },
        //
        //           onTap:(){
        //             Navigator.push(
        //                 context, MaterialPageRoute(
        //               builder: (context) => ServiceList(
        //                   title: 'Mobile Car Wash',
        //                   data: carSpaController.carSpaCategory,
        //                   type: 'carSpa'),
        //             )
        //             );
        // },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/CarWash.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Car Washing",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/CarSteaming.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Car Steaming",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage(
        //                         "assets/serviceImage/InteriorCleaning.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Interior\nCleaning",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage(
        //                         "assets/serviceImage/WaterMarkRemoval.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Watermark\nRemoval",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/PolishWaxing.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Polish &\nWaxing",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image:
        //                         AssetImage("assets/serviceImage/ScratchRemoval.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Scratch\nRemoval",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BikeWash.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Bike Wash",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/HouseKeeping.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "House Keeping",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         GestureDetector(
        //           onTap: () {
        //             if (carSpaController.carSpaCategory.length == 0) {
        //               carSpaController.getAllCarSpaCategory();
        //             }
        //             Get.toNamed(RouteHelper.serviceListing, arguments: [
        //               {
        //                 'title': 'Mobile Car Wash',
        //                 'type': 'carSpa',
        //                 'data': carSpaController.carSpaCategory
        //               }
        //             ]);
        //           },
        //           child: Stack(
        //             alignment: Alignment.bottomCenter,
        //             children: [
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image:
        //                         AssetImage("assets/serviceImage/RainTreatment.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                   color: Colors.white,
        //                 ),
        //               ),
        //               Container(
        //                 height: 150,
        //                 width: 100,
        //                 margin: EdgeInsets.all(5),
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                     image: AssetImage("assets/serviceImage/BottomiMAGE.png"),
        //                     fit: BoxFit.cover,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 10,
        //                   child: Text(
        //                     "Rain Repellent\nTreatment",
        //                     style: smallFontNew(Colors.white),
        //                   )),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
      ]);
    });
  }
}
