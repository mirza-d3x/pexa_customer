import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/data/models/carSpa/carWashModel.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/car/car_brand_bottomsheet.dart';

class ServiceListTile extends StatelessWidget {
  ServiceListTile({super.key, this.data, this.index, this.type});
  final data;
  final int? index;
  final type;
  final categoryModelController = Get.find<ProductCategoryController>();
  final mechanicalController = Get.find<MechanicalController>();
  final carSpaController = Get.find<CarSpaController>();
  final quickHelpController = Get.find<QuickHelpController>();
  List CarWashService = [
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/CarWashing.png",
        serviceName: "Car Wash"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/CarSteam.png",
        serviceName: "Car Steam"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/InteriorClean.png",
        serviceName: "Interior"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/BikeWashing.png",
        serviceName: "Bike wash")
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthFactorsController>(builder: (authController) {
      return InkWell(
        onTap: () {
          if (!authController.isMIdAvailable) {
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
                            Get.bottomSheet(carBrandBottomSheet(context),
                                isScrollControlled: true);
                          }
                        },
                      ),
                    ],
                  );
                });
          } else {
            if (type == 'mechanical') {
              mechanicalController.getMechanicalServiceWithCatId(data.id);
              Get.toNamed(RouteHelper.mechanicalService,
                  arguments: {'title': data.name});
            } else if (type == 'carSpa') {
              carSpaController.carSpaSelectedCategory.value=data.id;
              if (index != 7 && index != 8) {
                carSpaController.getCarSpaServiceWithCatId(data.id);
                Get.toNamed(RouteHelper.carSpaService,
                    arguments: {'title': data.name});
              } else {
                carSpaController.getCarSpaServiceWithoutCatId(data.id);
                Get.toNamed(RouteHelper.carSpaService,
                    arguments: {'title': data.name});
              }
            } else {
              quickHelpController.getQuickHelpServiceWithCatId(data.id);
              Get.toNamed(RouteHelper.quickHelpService,
                  arguments: {'title': data.name});
            }
          }
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow),
                    borderRadius: BorderRadius.circular(40)),
                child: CircleAvatar(
                  radius: 30,
                    backgroundImage: NetworkImage(data.imageUrl[0], ),
                    ),
              ),
              const SizedBox(height: 4,),
              Expanded(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Text(
                    data.name,
                    textAlign: TextAlign.center,
                    style: verySmallFontBold(
                       Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
