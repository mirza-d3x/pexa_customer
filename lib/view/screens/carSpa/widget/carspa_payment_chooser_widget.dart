import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaTimeSlotController.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarSpaPaymentChooserWidget extends StatelessWidget {
  CarSpaPaymentChooserWidget({super.key});
  final carSpaTimeSlotController = Get.find<CarSpaTimeSlotController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Obx(
        () => Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Mode",
              style: mediumFont(Colors.black),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              height: 38,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bouncing(
                    onPress: () {
                      carSpaTimeSlotController.paymentIndex.value = 1;
                    },
                    child: Container(
                      height: (carSpaTimeSlotController.paymentIndex.value == 1)
                          ? 37
                          : 34,
                      width: 74,
                      decoration: BoxDecoration(
                          color:
                              (carSpaTimeSlotController.paymentIndex.value == 1)
                                  ? blackPrimary
                                  : Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5))),
                      child: Center(
                        child: Text('Online',
                            style:
                                (carSpaTimeSlotController.paymentIndex.value ==
                                        1)
                                    ? mediumFont(Colors.white)
                                    : mediumFont(Colors.black)),
                      ),
                    ),
                  ),
                  Bouncing(
                    onPress: () {
                      carSpaTimeSlotController.paymentIndex.value = 2;
                    },
                    child: Container(
                      height: (carSpaTimeSlotController.paymentIndex.value == 2)
                          ? 37
                          : 34,
                      width: 74,
                      decoration: BoxDecoration(
                        color:
                            (carSpaTimeSlotController.paymentIndex.value == 2)
                                ? Colors.black
                                : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text(
                          'Cash',
                          style: TextStyle(
                              color: (carSpaTimeSlotController
                                          .paymentIndex.value ==
                                      2)
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.5)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
