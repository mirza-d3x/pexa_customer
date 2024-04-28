import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaShowDate extends StatelessWidget {
  CarSpaShowDate({super.key});
  final carSpaTimeSlotController = Get.find<CarSpaTimeSlotController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          /*boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],*/
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.calendar_month,color: Colors.black,),
            Text(
              carSpaTimeSlotController.dateShow.value,
              style: mediumFont(Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
