import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:flutter/material.dart';

class ApplyCoupenTimeSlot extends StatelessWidget {
  const ApplyCoupenTimeSlot({super.key, this.route, this.carSpaServiceResultData});
  final String? route;
  final ServiceId? carSpaServiceResultData;

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: 220,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  border: Border.all(color: Colors.black)),
              child: TextField(
                textAlign: TextAlign.center,
                controller: Get.find<CouponController>().controller.value,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter the coupon',
                    hintStyle: smallFont(Colors.grey)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Bouncing(
              onPress: () {
                if (Get.find<CouponController>().controller.value.text.trim() !=
                        '') {
                  (route == 'carSpa')
                      ? goBack(context).then((value) =>
                          Get.find<CouponController>().checkCoupon(
                              Get.find<CarSpaController>()
                                  .carSpaAddOnTotal
                                  .value
                                  .toDouble()))
                      : goBack(context).then((value) =>
                          Get.find<CouponController>().checkCoupon(
                              Get.find<MechanicalController>()
                                  .mechanicalAddOnTotal
                                  .value
                                  .toDouble()));
                }
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: botAppBarColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.verified_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                    Text(
                      ' Verify',
                      style: smallFontW600(Colors.black),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
