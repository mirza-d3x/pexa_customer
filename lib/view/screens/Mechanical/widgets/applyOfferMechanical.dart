import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/view/screens/Mechanical/mechanical_offer_bottom_up.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class ApplyMechanicalOffer extends StatelessWidget {
  const ApplyMechanicalOffer({super.key, this.mechanicalServiceResultData});
  final ServiceId? mechanicalServiceResultData;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPress: () {
        Get.find<MechanicalController>().clearOffer();
        Get.find<MechanicalController>().getMechanicalAvailableOffers(
            mechanicalServiceResultData!.id,
            Get.find<MechanicalController>().mechanicalAddOnTotal.value);
        Get.find<CouponController>().clearValue();
        // Get.find<CouponController>().controller.value.text = '';
        if (!Get.isBottomSheetOpen!) {
          Get.bottomSheet(
              mechanicalOfferBottomUp(context, mechanicalServiceResultData),
              isScrollControlled: true);
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        // width: 150,
        decoration: BoxDecoration(
          color: botAppBarColor,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Apply Offer',
            style: mediumFont(Colors.black),
          ),
        ),
      ),
    );
  }
}
