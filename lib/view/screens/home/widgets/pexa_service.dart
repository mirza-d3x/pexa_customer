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
    return GetBuilder<AuthFactorsController>(builder: (authController) {
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
              return GetBuilder<CarSpaController>(builder: (carSpaController) {
                return GestureDetector(
                  onTap: () {
                    carSpaController.getCarSpaServiceWithCatId(
                        carSpaController.carSpaCategory[index].id);
                    Get.toNamed(RouteHelper.carSpaService, arguments: {
                      'title': carSpaController.carSpaCategory[index].name
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Stack(children: [
                      Container(
                        height: 130,
                        width: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    CarWashServicee[index].serviceImage))),
                        child:
                            Image.asset("assets/serviceImage/BottomiMAGE.png"),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 6,
                        child: Text(
                          CarWashServicee[index].serviceName,
                          style: veryverySmallFontW600(Colors.black),
                        ),
                      ),
                    ]),
                  ),
                );
              });
            },
          ),
        ),
      ]);
    });
  }
}
