import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/view/screens/TimeSlotSelection/widgets/applyCoupen.dart';

import 'widget/offerTile.dart';

class CarSpaOfferPage extends StatelessWidget {
  const CarSpaOfferPage({super.key, this.carSpaServiceResultData});
  final ServiceId? carSpaServiceResultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CarSpa Offers", style: mediumFont(Colors.black)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
          ),
          color: Theme.of(context).textTheme.bodyLarge!.color,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Coupon Code',
              style: mediumFont(Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            ApplyCoupenTimeSlot(
              route: 'carSpa',
              carSpaServiceResultData: carSpaServiceResultData,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Other Offers',
              style: mediumFont(Colors.black),
            ),
            Obx(
              () => Expanded(
                  child: Get.find<CarSpaController>().carSpaOffers.isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: Get.find<CarSpaController>()
                                      .carSpaOffers
                                      .length,
                                  itemBuilder: (context, index) {
                                    return OfferTile(
                                      carSpaOfferModelData:
                                          Get.find<CarSpaController>()
                                              .carSpaOffers[index],
                                      carSpaServiceResultData:
                                          carSpaServiceResultData,
                                    );
                                  })
                            ],
                          ),
                        )
                      : Center(
                          child: Get.find<CarSpaController>().offerEmpty.value
                              ? Text(
                                  'No Offers Found..!',
                                  style: smallFontW600(Colors.grey),
                                )
                              : LoadingAnimationWidget.twistingDots(
                                  leftDotColor: const Color(0xFF4B4B4D),
                                  rightDotColor: const Color(0xFFf7d417),
                                  size: 50,
                                ))),
            )
          ],
        ),
      ),
    );
  }
}
