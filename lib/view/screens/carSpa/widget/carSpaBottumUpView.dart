import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/carSpaController.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget carSpaBottomUpView(BuildContext context, int? index, List data,
    ServiceId? carSpaServiceResultData) {
  return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: Get.height * .85,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 12,right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pexa',
                              style: verySmallFontW600(Colors.black),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .75,
                              child: Text(
                                carSpaServiceResultData!.name!,
                                style: largeFont(Colors.black),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.clear)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Pexa ${carSpaServiceResultData.name} consists of the services listed below....',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: smallFontW600(Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.builder(
                      itemCount: data.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(5)),
                                    color: botAppBarColor),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  data[index],
                                  style: smallFontW600(Colors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "total",
                            style: smallFontW600(Colors.black),
                          ),
                          Row(
                            children: [
                              Text(
                                "₹ ${carSpaServiceResultData.price.toString()}",
                                style: largeFont(Colors.black),
                              ),
                              Text(
                                " (inc. tax)",
                                style: smallFont(Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Bouncing(
                        onPress: () {
                          Navigator.pop(context);
                          Get.find<CarSpaController>().carSpaAddOns.clear();
                          Get.toNamed(RouteHelper.carSpaServiceAddon,
                              arguments: {
                                'carSpaServiceResultData':
                                carSpaServiceResultData
                              });
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                            color: botAppBarColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child:
                            Text('Confirm', style: mediumFont(Colors.black)),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                /*Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "total",
                                style: smallFontW600(Colors.black),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "₹ ${carSpaServiceResultData.price.toString()}",
                                    style: largeFont(Colors.black),
                                  ),
                                  Text(
                                    " (inc. tax)",
                                    style: smallFont(Colors.black),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Bouncing(
                            onPress: () {
                              Navigator.pop(context);
                              Get.find<CarSpaController>().carSpaAddOns.clear();
                              Get.toNamed(RouteHelper.carSpaServiceAddon,
                                  arguments: {
                                    'carSpaServiceResultData':
                                        carSpaServiceResultData
                                  });
                            },
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: botAppBarColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child:
                                    Text('Confirm', style: mediumFont(Colors.black)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )*/
              ],
            ),
          ),
        );
      });
}
