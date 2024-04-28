import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/data/models/carSpa/carWashModel.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/screens/service/widget/service_list_tile.dart';

class PexaServiceRound extends StatefulWidget {
  final String? type;
  const PexaServiceRound({super.key,this.type});

  @override
  State<PexaServiceRound> createState() => _PexaServiceRoundState();
}

class _PexaServiceRoundState extends State<PexaServiceRound> {
  List CarWashService = [
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/CarWashing.png",
        serviceName: "Car Washing"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/CarSteam.png",
        serviceName: "Car Steaming"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/InteriorClean.png",
        serviceName: "Interior Cleaning"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/WaterMarkRemovaling.png",
        serviceName: "Watermark\nRemoval"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/PolishAndWax.png",
        serviceName: "Polish & Waxing"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/ScratchRemove.png",
        serviceName: "Scratch Removal"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/BikeWashing.png",
        serviceName: "Bike washing"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/HouseKeep.png",
        serviceName: "House Keeping"),
    CarWashModel(
        serviceImage: "assets/serviceImageCircle/RainTreatMenting.png",
        serviceName: "Rain Repellent\nTreatment"),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: GetBuilder<AuthFactorsController>(
                builder: (authController) {
                  return Text(
                      (authController.userName != '' &&
                          authController.userName != null)
                          ? 'Hello ${authController.userName.toUpperCase()},'
                          : 'Hello User',
                      style:
                      defaultFont(size: 12, weight: FontWeight.w400));
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text("Services may you need",style: smallFontNew(Colors.black),),
          ),
          const SizedBox(height: 10,),
          /*GridView.builder(
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            shrinkWrap: true,
            itemCount: CarWashService.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                      backgroundColor: Colors.white,
                      child: Image.asset(CarWashService[index].serviceImage,)),
                  SizedBox(height: 7,),
                  Expanded(
                      child: Text(CarWashService[index].serviceName,style: smallFontNew(Colors.black),)),
                ],
              );
            },
          ),*/
          dataGrid(context: context),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }

  dataGrid(
      {required BuildContext context}) {
    return GetBuilder<CarSpaController>(builder: (carSpaController) {
      return GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9
      ),
          itemCount: carSpaController.carSpaCategory.length,
          shrinkWrap: true,
        physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return ServiceListTile(
              data: carSpaController.carSpaCategory[index],
              index: index,
              type: widget.type,
            );
          },
      );
    });
  }
}
