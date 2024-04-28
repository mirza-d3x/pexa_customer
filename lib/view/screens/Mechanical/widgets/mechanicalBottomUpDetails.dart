import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget mechanicalDetailsBottomUpView(BuildContext context, int? index, List data,
    ServiceId? mechanicalServiceResultData) {
  return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * .85,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
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
                              mechanicalServiceResultData!.name!,
                              style: largeFont(Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.clear))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: Text(
                  'Pexa ${mechanicalServiceResultData.name!.toUpperCase()} consists of the services listed below....',
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
                    controller: scrollController,
                    itemCount: data.length,
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
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  "₹ ${mechanicalServiceResultData.price.toString()}",
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
                            Get.toNamed(RouteHelper.mechanicalServiceAddon,
                                arguments: {
                                  'mechanicalServiceResultData':
                                      mechanicalServiceResultData,
                                });
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
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
                                  Text('Next', style: mediumFont(Colors.black)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        );
      });
}
