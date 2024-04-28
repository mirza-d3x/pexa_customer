import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/view/screens/carSpa/car_spa_offer_bottom_up.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class ApplyOfferButton extends StatelessWidget {
  const ApplyOfferButton({super.key, this.carSpaServiceResultData});
  final ServiceId? carSpaServiceResultData;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPress: () {
        if (!Get.isBottomSheetOpen!) {
          Get.bottomSheet(carSpaOfferBottomUp(context, carSpaServiceResultData),
              isScrollControlled: true);
        }
        Get.find<CarSpaController>().clearApplyOfferData();
        // Get.to(() => CarSpaOfferPage(
        //       carSpaServiceResultData: carSpaServiceResultData,
        //     ));
        Get.find<CarSpaController>().getCarSpaAvailableOffers(
            carSpaServiceResultData!.id,
            Get.find<CarSpaController>().carSpaAddOnTotal.value);
        Get.find<CouponController>().controller.value.text = '';
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
