import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/review/widget/service_man_widget.dart';

/*class ServiceOrderViewTile extends StatelessWidget {
  ServiceOrderViewTile(
      {Key? key, this.orderDetails, required this.mainServiceCategory})
      : super(key: key);
  final ServiceOrderModel? orderDetails;
  final MainCategory mainServiceCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<OrderController>().setSelectedServiceOrder(orderDetails);
        Get.toNamed(RouteHelper.serviceOrderDetailedView, arguments: {
          'orderId': orderDetails!.id,
          'orderDetails': orderDetails,
          'mainServiceCategory': mainServiceCategory,
          'isRunning': (orderDetails!.status == "Active" ||
                  orderDetails!.status == 'Reassigned' ||
                  orderDetails!.status == 'Rejected' ||
                  orderDetails!.status == 'Accepted')
              ? true
              : false,
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: EdgeInsets.all(5),
              child: Center(
                child: CustomImage(
                  image: orderDetails!.serviceId!.imageUrl![0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
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
                        orderDetails!.serviceId!.name.toString().toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mediumFont(Colors.black),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order ID: ",
                            style: smallFont(Colors.black),
                          ),
                          Text(
                            orderDetails!.orderId!,
                            style: smallFont(Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Total ",
                            style: smallFont(Colors.black),
                          ),
                          Spacer(),
                          Text('₹ ' + orderDetails!.grandTotal.toString(),
                              style: smallFontW600(Colors.black))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Text("Time Slot", style: smallFont(Colors.black)),
                      Spacer(),
                      Text(
                        orderDetails!.timeSlot!,
                        style: smallFontW600(Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Date", style: smallFont(Colors.black)),
                      Spacer(),
                      Text(
                        orderDetails!.date.toString().substring(0, 10),
                        style: smallFontW600(Colors.black),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 25,
                    child: Row(
                      children: [
                        Text("Status", style: smallFont(Colors.black)),
                        Spacer(),
                        Container(
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: orderDetails!.status == 'Active' ||
                                    orderDetails!.status == 'Reassigned' ||
                                    orderDetails!.status == 'Rejected'
                                ? Theme.of(context).primaryColor
                                : orderDetails!.status == "In_Progress"
                                    ? Colors.lightGreen
                                    : orderDetails!.status == 'Cancelled'
                                        ? Colors.red
                                        : orderDetails!.status == 'Completed'
                                            ? Colors.green
                                            : orderDetails!.status == 'Accepted'
                                                ? Colors.yellow[900]
                                                : blackPrimary,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              orderDetails!.status == 'Reassigned' ||
                                      orderDetails!.status == 'Rejected'
                                  ? "Active"
                                  : orderDetails!.status == 'In_Progress'
                                      ? 'In Progress'
                                      : orderDetails!.status.toString(),
                              style: smallFontW600(
                                  orderDetails!.status == 'Active' ||
                                          orderDetails!.status == 'Reassigned' ||
                                          orderDetails!.status == 'Rejected'
                                      ? Colors.black
                                      : Colors.white),
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
    );
  }
}*/
class ServiceOrderViewTile extends StatelessWidget {
  const ServiceOrderViewTile(
      {super.key, this.orderDetails, required this.mainServiceCategory});
  final ServiceOrderModel? orderDetails;
  final MainCategory mainServiceCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.find<OrderController>().setSelectedServiceOrder(orderDetails);
          Get.toNamed(RouteHelper.serviceOrderDetailedView, arguments: {
            'orderId': orderDetails!.id,
            'orderDetails': orderDetails,
            'mainServiceCategory': mainServiceCategory,
            'isRunning': (orderDetails!.status == "Active" ||
                    orderDetails!.status == 'Reassigned' ||
                    orderDetails!.status == 'Rejected' ||
                    orderDetails!.status == 'Accepted')
                ? true
                : false,
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Container(
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
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: CustomImage(
                      image: orderDetails!.serviceId!.imageUrl![0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),*/
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                image: AssetImage("assets/image/logo.png"))),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        orderDetails!.date.toString().substring(0, 10),
                        style: smallFontNew(Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        orderDetails!.timeSlot!,
                        style: smallFontNew(Colors.black),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('₹ ${orderDetails!.grandTotal}',
                          style: mediumBoldFont(Colors.black))
                      /* Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      */ /*SizedBox(
                          width: 160,
                          child: Text(
                            orderDetails!.serviceId!.name.toString().toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: mediumFont(Colors.black),
                          )),*/ /*
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID: ",
                                style: smallFont(Colors.black),
                              ),
                              Text(
                                orderDetails!.orderId!,
                                style: smallFont(Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
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
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Total ",
                                style: smallFont(Colors.black),
                              ),
                              Spacer(),
                              Text('₹ ' + orderDetails!.grandTotal.toString(),
                                  style: smallFontW600(Colors.black))
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Text("Time Slot", style: smallFont(Colors.black)),
                          Spacer(),
                          Text(
                            orderDetails!.timeSlot!,
                            style: smallFontW600(Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("Date", style: smallFont(Colors.black)),
                          Spacer(),
                          Text(
                            orderDetails!.date.toString().substring(0, 10),
                            style: smallFontW600(Colors.black),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            Text("Status", style: smallFont(Colors.black)),
                            Spacer(),
                            Container(
                              height: 25,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: orderDetails!.status == 'Active' ||
                                        orderDetails!.status == 'Reassigned' ||
                                        orderDetails!.status == 'Rejected'
                                    ? Theme.of(context).primaryColor
                                    : orderDetails!.status == "In_Progress"
                                        ? Colors.lightGreen
                                        : orderDetails!.status == 'Cancelled'
                                            ? Colors.red
                                            : orderDetails!.status == 'Completed'
                                                ? Colors.green
                                                : orderDetails!.status == 'Accepted'
                                                    ? Colors.yellow[900]
                                                    : blackPrimary,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    offset:
                                        Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  orderDetails!.status == 'Reassigned' ||
                                          orderDetails!.status == 'Rejected'
                                      ? "Active"
                                      : orderDetails!.status == 'In_Progress'
                                          ? 'In Progress'
                                          : orderDetails!.status.toString(),
                                  style: smallFontW600(
                                      orderDetails!.status == 'Active' ||
                                              orderDetails!.status == 'Reassigned' ||
                                              orderDetails!.status == 'Rejected'
                                          ? Colors.black
                                          : Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),*/
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 35,
                    ),
                    child: Text(
                      orderDetails!.serviceId!.name.toString().toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: mediumFont(Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 120,
                    width: double.maxFinite,
                    child: ServiceManWidget(
                        orderDetails: orderDetails,
                        workerDetails: orderDetails!.workerDetails,
                        rating: orderDetails!.workerDetails!.ratings != null
                            ? orderDetails!.workerDetails!.ratings!.average
                            : 0,
                        ratingUserCount: orderDetails!.workerDetails!.ratings !=
                                null
                            ? (orderDetails!.workerDetails!.ratings!.oneStar != null
                                    ? orderDetails!.workerDetails!.ratings!
                                            .oneStar!.count ??
                                        0
                                    : 0) +
                                (orderDetails!.workerDetails!.ratings!.threeStar !=
                                        null
                                    ? orderDetails!.workerDetails!.ratings!.twoStar !=
                                            null
                                        ? orderDetails!.workerDetails!.ratings!
                                                .twoStar!.count ??
                                            0
                                        : 0
                                    : 0) +
                                (orderDetails!.workerDetails!.ratings!.threeStar != null
                                    ? orderDetails!.workerDetails!.ratings!
                                            .threeStar!.count ??
                                        0
                                    : 0) +
                                (orderDetails!.workerDetails!.ratings!.fourStar != null
                                    ? orderDetails!.workerDetails!.ratings!
                                            .fourStar!.count ??
                                        0
                                    : 0) +
                                (orderDetails!.workerDetails!.ratings!.fiveStar != null
                                    ? orderDetails!.workerDetails!.ratings!.fiveStar!.count ?? 0
                                    : 0)
                            : 0),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 25,
                    // width: 80,
                    // alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                      color: orderDetails!.status == 'Active' ||
                              orderDetails!.status == 'Reassigned' ||
                              orderDetails!.status == 'Rejected'
                          ? Theme.of(context).primaryColor
                          : orderDetails!.status == "In_Progress"
                              ? Colors.lightGreen
                              : orderDetails!.status == 'Cancelled'
                                  ? Colors.red
                                  : orderDetails!.status == 'Completed'
                                      ? Colors.green
                                      : orderDetails!.status == 'Accepted'
                                          ? Colors.yellow[900]
                                          : blackPrimary,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                      orderDetails!.status == 'Reassigned' ||
                              orderDetails!.status == 'Rejected'
                          ? "Active"
                          : orderDetails!.status == 'In_Progress'
                              ? 'In Progress'
                              : orderDetails!.status.toString(),
                      textAlign: TextAlign.center,
                      
                      style: smallFontW600(orderDetails!.status == 'Active' ||
                              orderDetails!.status == 'Reassigned' ||
                              orderDetails!.status == 'Rejected'
                          ? Colors.black
                          : Colors.white),
                    ),
                  )
                ]),
          ),
        ));
  }
}
