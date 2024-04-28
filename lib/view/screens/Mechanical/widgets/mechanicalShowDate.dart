import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalShowDate extends StatelessWidget {
  const MechanicalShowDate({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicalTimeSlotController>(
        builder: (mechanicalTimeSlotController) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            mechanicalTimeSlotController.dateShow.value,
            style: mediumFont(Colors.black),
          ),
        ),
      );
    });
  }
}
