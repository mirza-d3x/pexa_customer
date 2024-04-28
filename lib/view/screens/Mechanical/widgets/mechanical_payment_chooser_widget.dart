import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/mechanicalTimeSLotController.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicalPaymentChooserWidget extends StatelessWidget {
  const MechanicalPaymentChooserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicalTimeSlotController>(
        builder: (mechanicalTimeSlotController) {
      return SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Payment Mode", style: mediumFont(Colors.black)),
            SizedBox(
              height: 38,
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bouncing(
                    onPress: () {
                      mechanicalTimeSlotController.updatePaymentMode(1);
                    },
                    child: Container(
                      height:
                          (mechanicalTimeSlotController.paymentIndex.value == 1)
                              ? 37
                              : 34,
                      width: 74,
                      decoration: BoxDecoration(
                          color: (mechanicalTimeSlotController
                                      .paymentIndex.value ==
                                  1)
                              ? blackPrimary
                              : Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              topLeft: Radius.circular(5))),
                      child: Center(
                        child: Text('Online',
                            style: (mechanicalTimeSlotController
                                        .paymentIndex.value ==
                                    1)
                                ? mediumFont(Colors.white)
                                : mediumFont(Colors.black)),
                      ),
                    ),
                  ),
                  Bouncing(
                    onPress: () {
                      mechanicalTimeSlotController.updatePaymentMode(2);
                    },
                    child: Container(
                      height:
                          (mechanicalTimeSlotController.paymentIndex.value == 2)
                              ? 37
                              : 34,
                      width: 74,
                      decoration: BoxDecoration(
                        color:
                            (mechanicalTimeSlotController.paymentIndex.value ==
                                    2)
                                ? Colors.black
                                : Colors.grey[300],
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                            topRight: Radius.circular(5)),
                      ),
                      child: Center(
                        child: Text('Cash',
                            style: (mechanicalTimeSlotController
                                        .paymentIndex.value ==
                                    2)
                                ? mediumFont(Colors.white)
                                : mediumFont(Colors.black)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
