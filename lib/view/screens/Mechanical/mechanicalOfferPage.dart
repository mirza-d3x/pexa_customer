import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/mechanicalController.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/view/screens/Mechanical/widgets/mechanicalOfferTile.dart';
import 'package:shoppe_customer/view/screens/TimeSlotSelection/widgets/applyCoupen.dart';

class MechanicalOfferPage extends StatelessWidget {
  const MechanicalOfferPage({super.key, this.mechanicalServiceResultData});
  final ServiceId? mechanicalServiceResultData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mechanical Offers", style: mediumFont(Colors.black)),
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
            const ApplyCoupenTimeSlot(
              route: 'mechanical',
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
                  child: Get.find<MechanicalController>()
                          .mechanicalOffer
                          .isNotEmpty
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: Get.find<MechanicalController>()
                                      .mechanicalOffer
                                      .length,
                                  itemBuilder: (context, index) {
                                    return MechanicalOfferTile(
                                      mechanicalServiceResultData:
                                          mechanicalServiceResultData,
                                      mechanicalOfferResultData:
                                          Get.find<MechanicalController>()
                                              .mechanicalOffer[index],
                                    );
                                  })
                            ],
                          ),
                        )
                      : Center(
                          child:
                              Get.find<MechanicalController>().offerEmpty.value
                                  ? Text(
                                      'No Offers Found..!',
                                      style: smallFontW600(Colors.grey),
                                    )
                                  : SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: Image.asset(Images.spinner,
                                          fit: BoxFit.fill)))),
            )
          ],
        ),
      ),
    );
  }
}
