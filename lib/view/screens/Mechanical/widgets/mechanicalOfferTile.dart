import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/offer_model.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';

class MechanicalOfferTile extends StatelessWidget {
  const MechanicalOfferTile(
      {super.key,
      this.mechanicalOfferResultData,
      this.mechanicalServiceResultData});
  final OfferModel? mechanicalOfferResultData;
  final ServiceId? mechanicalServiceResultData;

  Future goBack(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<CouponController>().clearValue();
        Get.find<MechanicalController>().clearOffer();
        goBack(context).then((value) => Get.find<MechanicalController>()
            .applyOfferToService(
                mechanicalServiceResultData!.id,
                Get.find<MechanicalController>().mechanicalAddOnTotal.value,
                mechanicalOfferResultData!.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/carSpa/coupon1.png',
                ),
                fit: BoxFit.fill,
              )),
              child: Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Center(
                    child: Text(
                      mechanicalOfferResultData!.description!,
                      style: largeFont(Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              width: 200,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/carSpa/coupon2.png'),
                      fit: BoxFit.fill)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      child: Text(
                        mechanicalOfferResultData!.title!,
                        style: couponTitle(Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.green[900]),
                        child: Center(
                          child: Text(
                            'SAVE  ₹${mechanicalOfferResultData!.offerAmount}',
                            style: couponSave(botAppBarColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
