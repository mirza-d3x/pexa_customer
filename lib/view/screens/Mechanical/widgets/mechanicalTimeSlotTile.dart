import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalTimeSlotTile extends StatelessWidget {
  MechanicalTimeSlotTile({super.key, this.index});
  final int? index;
  final mechanicalController = Get.find<MechanicalController>();
  final checkOutController = Get.find<ServiceCheckOutController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicalTimeSlotController>(
        builder: (mechanicalTimeSlotController) {
      return Bouncing(
        onPress: () {
          if (mechanicalController.mechanicalTimeSlot.contains(
                  mechanicalTimeSlotController.timeList[index!]['slot']) &&
              DateTime.now().isBefore(DateTime.parse(
                  "${mechanicalTimeSlotController.dateShow} ${mechanicalTimeSlotController.timeList[index!]['time']}.000"))) {
            mechanicalTimeSlotController.selectSlot(index!);
            checkOutController.setTimeSlot(
                mechanicalTimeSlotController.timeList[index!]['slot']!);
            print(mechanicalTimeSlotController.index.value);
            print(checkOutController.timeSlot.value);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: (mechanicalController.mechanicalTimeSlot.contains(
                        mechanicalTimeSlotController.timeList[index!]['slot']) &&
                    DateTime.now().isBefore(DateTime.parse(
                        "${mechanicalTimeSlotController.dateShow} ${mechanicalTimeSlotController.timeList[index!]['time']}.000")))
                ? (mechanicalTimeSlotController.index.value == index)
                    ? blackPrimary
                    : botAppBarColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
              child: mechanicalTimeSlotController.dateLoad.value
                  ? Text(
                      mechanicalTimeSlotController.timeList[index!]['text']!,
                      style: (mechanicalTimeSlotController.index.value == index)
                          ? smallFontW600(Colors.white)
                          : smallFont(Colors.black),
                    )
                  : SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset(Images.spinner, fit: BoxFit.fill))),
        ),
      );
    });
  }
}
