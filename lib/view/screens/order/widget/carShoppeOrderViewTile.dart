import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/data/models/carShoppe/shoppeOrdersModel.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppeOrderViewTile extends StatelessWidget {
  const ShoppeOrderViewTile({super.key, this.shoppeOrderResultData});
  final ShoppeOrderDetail? shoppeOrderResultData;

  @override
  Widget build(BuildContext context) {
    var expdate = shoppeOrderResultData!.createdAt!.add(const Duration(days: 10));
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.productOrderDetailedView, arguments: {
          'shoppeOrderResultData': shoppeOrderResultData,
          'isRunning': shoppeOrderResultData!.status == "Processing",
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: CustomImage(
                    image: shoppeOrderResultData!.item!.itemId!.imageUrl != null &&
                            shoppeOrderResultData!.item!.itemId!.imageUrl!.isNotEmpty
                        ? shoppeOrderResultData!.item!.itemId!.imageUrl![0]
                        : '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 160,
                        child: Text(
                          shoppeOrderResultData!.item!.itemId!.name!.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: mediumFont(Colors.black),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Price Details",
                          style: smallFont(Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total ",
                          style: smallFont(Colors.black),
                        ),
                        const Spacer(),
                        Text('₹ ${shoppeOrderResultData!.grandTotal}',
                            style: smallFontW600(Colors.black))
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("Date ", style: smallFont(Colors.black)),
                        const Spacer(),
                        Text(
                          '${shoppeOrderResultData!.createdAt!.day}/${shoppeOrderResultData!.createdAt!.month}/${shoppeOrderResultData!.createdAt!.year}',
                          // shoppeOrderResultData.createdAt
                          //     .toString()
                          //     .substring(0, 10),
                          style: smallFontW600(Colors.black),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    shoppeOrderResultData!.status != "Cancelled"
                        ? Row(
                            children: [
                              Text("Expected on",
                                  style: smallFont(Colors.black)),
                              const Spacer(),
                              Text(
                                '${expdate.day}/${expdate.month}/${expdate.year}',
                                //(shoppeOrderResultData.createdAt.day + 10).toString(),
                                // .substring(0, 10),
                                style: smallFontW600(Colors.black),
                              )
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 5,
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 25,
                      child: Row(
                        children: [
                          const Text('Status'),
                          const Spacer(),
                          Container(
                            height: 25,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: shoppeOrderResultData!.status == 'Confirmed'
                                  ? Colors.blue
                                  : shoppeOrderResultData!.status == 'Cancelled'
                                      ? Colors.red
                                      : shoppeOrderResultData!.status ==
                                              'Completed'
                                          ? Colors.green
                                          : shoppeOrderResultData!.status ==
                                                  'Dispatched'
                                              ? Colors.yellow[900]
                                              : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(5),
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
                              child: Text(
                                shoppeOrderResultData!.status.toString(),
                                style: shoppeOrderResultData!.status ==
                                            'Confirmed' ||
                                        shoppeOrderResultData!.status ==
                                            'Cancelled' ||
                                        shoppeOrderResultData!.status ==
                                            'Completed' ||
                                        shoppeOrderResultData!.status ==
                                            'Dispatched'
                                    ? smallFontW600(Colors.white)
                                    : smallFont(Colors.black),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
