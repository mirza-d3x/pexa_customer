import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/quickHelpController.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/screens/quickHelp/widget/quickHelpDetailedBottomUpView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickHelpServiceTile extends StatelessWidget {
  const QuickHelpServiceTile({super.key, this.quickHelpServiceResultData, this.index});
  final ServiceId? quickHelpServiceResultData;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickHelpController>(builder: (quickHelpController) {
      return GestureDetector(
        onTap: () {
          print('Quick help sub tile');
          quickHelpController.paymentIndex.value = 2;
          if (!Get.isBottomSheetOpen!) {
            Get.bottomSheet(
                quickHelpDetailsBottomUpView(
                    context,
                    index,
                    quickHelpController.quickHelpServiceProperty[index!],
                    quickHelpServiceResultData),
                isScrollControlled: true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Stack(children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                padding: const EdgeInsets.only(top: 2),
                // height: MediaQuery.of(context).size.height * 0.17,
                clipBehavior: Clip.antiAlias,
                child: Stack(children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Stack(children: [
                            Container(
                              // width: MediaQuery.of(context).size.width * 0.25,
                              // height: MediaQuery.of(context).size.height * 0.10,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: CustomImage(
                                image:
                                    quickHelpServiceResultData!.imageUrl!.isNotEmpty
                                        ? quickHelpServiceResultData!.imageUrl![0]
                                        : "",
                                height: 70,
                                width: 70,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(quickHelpServiceResultData!.name!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: mediumFont(Colors.black)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ListView.builder(
                                    itemCount: (quickHelpController
                                                .quickHelpServiceProperty[index!]
                                                .length >
                                            3)
                                        ? 3
                                        : quickHelpController
                                            .quickHelpServiceProperty[index!]
                                            .length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 0),
                                    itemBuilder: (context, i) {
                                      return Text(
                                          '◍ ' +
                                              quickHelpController
                                                      .quickHelpServiceProperty[
                                                  index!][i],
                                          style: smallFont(Colors.grey));
                                    })),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                '₹ ${quickHelpServiceResultData!.price}',
                                style: mediumFont(Colors.black)),
                            const SizedBox(
                              height: 2,
                            ),
                          ]),
                    ],
                  ),
                  ((quickHelpServiceResultData!.description != 'test') &&
                          (quickHelpServiceResultData!.description != null))
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.03,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.RADIUS_EXTRA_LARGE),
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 110,
                                child: Text(
                                  quickHelpServiceResultData!.description
                                      .toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: verySmallFontW600(Colors.white),
                                ),
                              ),
                            ),
                          ))
                      : const SizedBox(),
                ])),
          ]),
        ),
      );
    });
  }
}
