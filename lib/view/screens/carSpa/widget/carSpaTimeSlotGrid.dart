import 'package:shoppe_customer/controller/myController/serviceCheckoutController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeSlotGrid extends StatefulWidget {
  const TimeSlotGrid({
    super.key,
  });

  @override
  State<TimeSlotGrid> createState() => _TimeSlotGridState();
}

class _TimeSlotGridState extends State<TimeSlotGrid> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarSpaTimeSlotController>(
        builder: (carSpaTimeController) {
      return GridView.builder(
          shrinkWrap: true,
          itemCount: carSpaTimeController.timeList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isMobile(context) ? 4 : 6,
              childAspectRatio: ResponsiveHelper.isMobile(context) ? 2 : 6),
          itemBuilder: (BuildContext context, int index) {
            return GetBuilder<CarSpaController>(builder: (carSpaController) {
              return Bouncing(
                onPress: (carSpaController.carSpaTimeSlot.contains(
                            carSpaTimeController.timeList[index]['slot']) &&
                        DateTime.now().isBefore(DateTime.parse(
                            "${carSpaTimeController.dateShow} ${carSpaTimeController.timeList[index]['time']}.000")))
                    ? () {
                        carSpaTimeController.index.value = index;
                        Get.find<ServiceCheckOutController>().setTimeSlot(
                            carSpaTimeController.timeList[index]['slot']!);
                        setState(() {});
                      }
                    : null,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: (carSpaController.carSpaTimeSlot.contains(
                                carSpaTimeController.timeList[index]['slot']) &&
                            DateTime.now().isBefore(DateTime.parse(
                                "${carSpaTimeController.dateShow} ${carSpaTimeController.timeList[index]['time']}.000")))
                        ? (carSpaTimeController.index.value == index)
                            ? blackPrimary
                            : botAppBarColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12)

                  ),
                  child: Center(
                      child: carSpaTimeController.dateLoad.value
                          ? Text(carSpaTimeController.timeList[index]['text']!,
                              style: (carSpaTimeController.index.value == index)
                                  ? smallFontW600(Colors.white)
                                  : smallFont(Colors.black))
                          : SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset(Images.spinner,
                                  fit: BoxFit.fill))),
                ),
              );
            });
          });
    });
  }
}
