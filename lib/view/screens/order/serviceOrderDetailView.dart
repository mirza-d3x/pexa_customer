import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_customer/controller/myController/expandableListController.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/helper/enums.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';
import 'package:shoppe_customer/data/models/worker_details/worker_details_model.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/review/widget/service_man_review_widget.dart';
import 'package:shoppe_customer/view/screens/review/widget/service_man_widget.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ServiceOrderDetailedView extends StatelessWidget {
  ServiceOrderDetailedView(
      {super.key,
      required this.serviceOrderDetail,
      required this.isRunning,
      required this.orderId,
      required this.mainServiceCategory});
  ServiceOrderModel? serviceOrderDetail;
  final bool? isRunning;
  final String? orderId;
  final MainCategory? mainServiceCategory;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future goBack(BuildContext alertContext, BuildContext context) async {
    Navigator.pop(alertContext);
    Navigator.pop(context);
  }

  loadData() {
    Get.find<OrderController>().getSingleOrderDetails(
        orderId: orderId!, serviceCategory: mainServiceCategory);
    serviceOrderDetail = Get.find<OrderController>().selectedOrderDetails;
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Order Details'),
      backgroundColor: Colors.white,
      body: GetBuilder<OrderController>(builder: (orderController) {
        return SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _onRefresh,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(5),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       blurRadius: 7,
                    //       offset: Offset(0, 3), // changes position of shadow
                    //     ),
                    //   ],
                    // ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Bouncing(
                              onPress: () {},
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
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
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                  child: CustomImage(
                                    image: orderController.selectedOrderDetails!
                                                .serviceId!.imageUrl!.isNotEmpty
                                        ? orderController.selectedOrderDetails!
                                            .serviceId!.imageUrl![0]
                                        : '',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            width: 160,
                                            child: Text(
                                              orderController
                                                  .selectedOrderDetails!
                                                  .serviceId!
                                                  .name
                                                  .toString()
                                                  .toUpperCase(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: defaultFont(
                                                  color: Colors.black,
                                                  weight: FontWeight.bold,
                                                  size: 18),
                                            ))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Package Price ",
                                          style: smallFont(Colors.black),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '₹ ${orderController
                                                  .selectedOrderDetails!
                                                  .serviceId!
                                                  .price}',
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Order ID : ",
                                          style: smallFont(Colors.black),
                                        ),
                                        const Spacer(),
                                        Text(
                                          orderController
                                              .selectedOrderDetails!.orderId!,
                                          style: smallFontW600(Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Date",
                                          style: smallFont(Colors.black),
                                        ),
                                        const Spacer(),
                                        Text(
                                          orderController
                                              .selectedOrderDetails!.date
                                              .toString()
                                              .substring(0, 10),
                                          style: smallFontW600(Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Time Slot",
                                          style: smallFont(Colors.black),
                                        ),
                                        const Spacer(),
                                        Text(
                                          orderController
                                              .selectedOrderDetails!.timeSlot!,
                                          style: smallFontW600(Colors.black),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Status",
                                          style: smallFont(Colors.black),
                                        ),
                                        const Spacer(),
                                        IntrinsicWidth(
                                          child: Container(
                                            height: 25,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                              color: orderController.selectedOrderDetails!
                                                              .status ==
                                                          'Active' ||
                                                      orderController
                                                              .selectedOrderDetails!
                                                              .status ==
                                                          'Reassigned' ||
                                                      orderController
                                                              .selectedOrderDetails!
                                                              .status ==
                                                          'Rejected'
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : orderController
                                                              .selectedOrderDetails!
                                                              .status ==
                                                          'Cancelled'
                                                      ? Colors.red
                                                      : orderController
                                                                  .selectedOrderDetails!
                                                                  .status ==
                                                              'In_Progress'
                                                          ? Colors.lightGreen
                                                          : orderController
                                                                      .selectedOrderDetails!
                                                                      .status ==
                                                                  'Completed'
                                                              ? Colors.green
                                                              : orderController
                                                                          .selectedOrderDetails!
                                                                          .status ==
                                                                      'Accepted'
                                                                  ? Colors
                                                                      .yellow[900]
                                                                  : blackPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              // boxShadow: [
                                              //   BoxShadow(
                                              //     color:
                                              //         Colors.grey.withOpacity(0.5),
                                              //     blurRadius: 7,
                                              //     offset: Offset(0,
                                              //         3), // changes position of shadow
                                              //   ),
                                              // ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                orderController
                                                            .selectedOrderDetails!
                                                            .status ==
                                                        'Reassigned'
                                                    ? "Active"
                                                    : orderController
                                                                .selectedOrderDetails!
                                                                .status ==
                                                            'In_Progress'
                                                        ? 'In Progress'
                                                        : orderController
                                                                    .selectedOrderDetails!
                                                                    .status ==
                                                                'Rejected'
                                                            ? 'Active'
                                                            : orderController
                                                                .selectedOrderDetails!
                                                                .status
                                                                .toString(),
                                                style: smallFontW600(orderController
                                                                .selectedOrderDetails!
                                                                .status ==
                                                            'Active' ||
                                                        orderController
                                                                .selectedOrderDetails!
                                                                .status ==
                                                            'Reassigned' ||
                                                        orderController
                                                                .selectedOrderDetails!
                                                                .status ==
                                                            'Rejected'
                                                    ? Colors.black
                                                    : Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        orderController.selectedOrderDetails!.addOn!.isNotEmpty
                            ? Column(
                                children: [
                                  // Divider(
                                  //   color: Colors.grey,
                                  //   thickness: 1,
                                  // ),
                                  const SizedBox(
                                    height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                  ),
                                  GetBuilder<ExpandableListController>(
                                    builder: (controller) {
                                      return ExpansionPanelList(
                                          elevation: 0,
                                          animationDuration:
                                              const Duration(milliseconds: 800),
                                          expansionCallback: (panelIndex,
                                                  isExpanded) =>
                                              controller.setState(!isExpanded),
                                          children: [
                                            ExpansionPanel(
                                              canTapOnHeader: true,
                                              headerBuilder:
                                                  (BuildContext context,
                                                      bool isExpanded) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Price Details',
                                                        style: mediumFont(
                                                            Colors.black),
                                                      ),
                                                      Column(children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Order Price Total",
                                                                style: smallFont(
                                                                    Colors
                                                                        .black),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                PriceConverter.convertPrice(double.tryParse(
                                                                    orderController
                                                                        .selectedOrderDetails!
                                                                        .grandTotal
                                                                        .toString())),
                                                                style: defaultFont(
                                                                    color: Colors
                                                                        .black,
                                                                    weight:
                                                                        FontWeight
                                                                            .bold,
                                                                    size: 18),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        orderController.selectedOrderDetails!
                                                                        .completedReport !=
                                                                    null &&
                                                                orderController
                                                                        .selectedOrderDetails!
                                                                        .completedReport!
                                                                        .grandTotal !=
                                                                    null
                                                            ? SizedBox(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      "Completed Service Total",
                                                                      style: smallFont(
                                                                          Colors
                                                                              .black),
                                                                    ),
                                                                    const Spacer(),
                                                                    Text(
                                                                      PriceConverter.convertPrice(double.tryParse(orderController.selectedOrderDetails!.completedReport !=
                                                                              null
                                                                          ? orderController
                                                                              .selectedOrderDetails!
                                                                              .completedReport!
                                                                              .grandTotal
                                                                              .toString()
                                                                          : "0")),
                                                                      style: defaultFont(
                                                                          color: Colors
                                                                              .black,
                                                                          weight: FontWeight
                                                                              .bold,
                                                                          size:
                                                                              18),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ]),
                                                    ],
                                                  ),
                                                );
                                              },
                                              body: ListView.builder(
                                                  shrinkWrap: true,
                                                  padding: const EdgeInsets.all(8),
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: orderController
                                                      .selectedOrderDetails!
                                                      .addOn!
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    bool iscompleted = true;
                                                    if ((orderController
                                                                    .selectedOrderDetails!
                                                                    .status ==
                                                                "In_Progress" ||
                                                            orderController
                                                                    .selectedOrderDetails!
                                                                    .status ==
                                                                "Completed") &&
                                                        orderController
                                                                .selectedOrderDetails!
                                                                .completedReport !=
                                                            null) {
                                                      iscompleted = orderController
                                                              .selectedOrderDetails!
                                                              .completedReport!
                                                              .addOns!
                                                              .where(
                                                                (element) {
                                                                  return element
                                                                          .name ==
                                                                      orderController
                                                                          .selectedOrderDetails!
                                                                          .addOn![
                                                                              index]
                                                                          .name;
                                                                },
                                                              )
                                                              .toList().isNotEmpty;
                                                    }
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Padding(
                                                        padding: const EdgeInsets
                                                            .symmetric(
                                                                vertical: 2.5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                orderController.selectedOrderDetails!.status ==
                                                                            "In_Progress" ||
                                                                        orderController.selectedOrderDetails!.status ==
                                                                            "Completed"
                                                                    ? iscompleted
                                                                        ? const Icon(
                                                                            Icons.check_circle_rounded,
                                                                            color:
                                                                                Colors.green,
                                                                            size:
                                                                                16,
                                                                          )
                                                                        : const SizedBox(
                                                                            width:
                                                                                16,
                                                                          )
                                                                    : const SizedBox(),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                    orderController
                                                                        .selectedOrderDetails!
                                                                        .addOn![
                                                                            index]
                                                                        .name!,
                                                                    style: smallFont(
                                                                        Colors
                                                                            .black)),
                                                              ],
                                                            ),
                                                            Text(
                                                                '₹ ${orderController
                                                                        .selectedOrderDetails!
                                                                        .addOn![
                                                                            index]
                                                                        .price}',
                                                                style: GoogleFonts.nunito(
                                                                    color: iscompleted
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .red,
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    decoration: iscompleted
                                                                        ? null
                                                                        : TextDecoration
                                                                            .lineThrough))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                              isExpanded:
                                                  controller.isOpen.value,
                                            )
                                          ]);
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        (orderController.selectedOrderDetails!.discountAmount !=
                                0)
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: smallFont(Colors.black),
                                    ),
                                    Text(
                                      '₹ ${orderController.selectedOrderDetails!
                                              .discountAmount}',
                                      style: smallFontW600(Colors.black),
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: (orderController
                                      .selectedOrderDetails!.discountAmount !=
                                  0)
                              ? 5
                              : 0,
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  const Divider(
                    // thickness: 1,
                    color: Colors.black,
                  ),
                  Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.white,
                    //   borderRadius: BorderRadius.circular(5),
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Colors.grey.withOpacity(0.5),
                    //       blurRadius: 7,
                    //       offset: Offset(0, 3), // changes position of shadow
                    //     ),
                    //   ],
                    // ),
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Address Details",
                          style: defaultFont(
                            color: Colors.black,
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            orderController.selectedOrderDetails!.address!.name
                                .toString()
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: mediumFont(Colors.black),
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: Get.width,
                          child: Text(
                            ((orderController.selectedOrderDetails!.address!
                                                .house !=
                                            null
                                        ? '${orderController.selectedOrderDetails!
                                                .address!.house!}, '
                                        : '') +
                                    (orderController.selectedOrderDetails!
                                                .address!.street !=
                                            null
                                        ? '${orderController.selectedOrderDetails!
                                                .address!.street!}, '
                                        : '') +
                                    (orderController.selectedOrderDetails!
                                                .address!.pincode !=
                                            null
                                        ? orderController.selectedOrderDetails!
                                            .address!.pincode!
                                        : ''))
                                .toString()
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: smallFont(Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  orderController.selectedOrderDetails!.workerDetails != null
                      ? ServiceManWidget(
                    orderDetails: orderController.selectedOrderDetails,
                          workerDetails: orderController
                              .selectedOrderDetails!.workerDetails,
                          rating:
                              orderController.selectedOrderDetails!.workerDetails!.ratings != null
                                  ? orderController.selectedOrderDetails!
                                      .workerDetails!.ratings!.average
                                  : 0,
                          ratingUserCount: orderController.selectedOrderDetails!.workerDetails!.ratings !=
                                  null
                              ? (orderController.selectedOrderDetails!.workerDetails!.ratings!.oneStar != null
                                      ? orderController
                                              .selectedOrderDetails!
                                              .workerDetails!
                                              .ratings!
                                              .oneStar!
                                              .count ??
                                          0
                                      : 0) +
                                  (orderController
                                              .selectedOrderDetails!
                                              .workerDetails!
                                              .ratings!
                                              .threeStar !=
                                          null
                                      ? orderController.selectedOrderDetails!.workerDetails!.ratings!.twoStar !=
                                              null
                                          ? orderController
                                                  .selectedOrderDetails!
                                                  .workerDetails!
                                                  .ratings!
                                                  .twoStar!
                                                  .count ??
                                              0
                                          : 0
                                      : 0) +
                                  (orderController.selectedOrderDetails!.workerDetails!.ratings!.threeStar != null
                                      ? orderController.selectedOrderDetails!.workerDetails!.ratings!.threeStar!.count ?? 0
                                      : 0) +
                                  (orderController.selectedOrderDetails!.workerDetails!.ratings!.fourStar != null ? orderController.selectedOrderDetails!.workerDetails!.ratings!.fourStar!.count ?? 0 : 0) +
                                  (orderController.selectedOrderDetails!.workerDetails!.ratings!.fiveStar != null ? orderController.selectedOrderDetails!.workerDetails!.ratings!.fiveStar!.count ?? 0 : 0)
                              : 0)
                      : const SizedBox(),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  (orderController.selectedOrderDetails!.status ==
                                  "In_Progress" &&
                              orderController.selectedOrderDetails!.happyCode !=
                                  null) ||
                          orderController.selectedOrderDetails!.status ==
                              "Completed"
                      ? ServiceManReviewWidget(
                          orderDetails: orderController.selectedOrderDetails,
                          deliveryMan: orderController
                                  .selectedOrderDetails!.workerDetails ?? WorkerDetails(),
                          category: mainServiceCategory,
                          isCompleted:
                              orderController.selectedOrderDetails!.status ==
                                      "In_Progress" ||
                                  orderController.selectedOrderDetails!.status ==
                                      "Completed")
                      : const SizedBox(),

                  SizedBox(
                    height: isRunning! ? 15 : 0,
                  ),
                  isRunning!
                      ? Bouncing(
                          onPress: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext alertContext) {
                                return AlertDialog(
                                  title: Text(
                                    'Alert..!',
                                    style: largeFont(Colors.red),
                                  ),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                          'are you sure to cancel this order..?',
                                          style: mediumFont(Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Yes',
                                        style: largeFont(Colors.black),
                                      ),
                                      onPressed: () {
                                        print(serviceOrderDetail!.id);
                                        Get.find<OrderController>()
                                            .cancelOrder(
                                                serviceCategory:
                                                    mainServiceCategory,
                                                ordID: orderController
                                                    .selectedOrderDetails!.id,
                                                shortOrderID: orderController
                                                    .selectedOrderDetails!
                                                    .orderId)
                                            .then((value) {
                                          goBack(alertContext, context)
                                              .then((value) {
                                            Get.find<OrderController>()
                                                .getOrdersList(
                                                    page: '1',
                                                    category:
                                                        mainServiceCategory,
                                                    orderPage:
                                                        OrderPage.RUNNING);
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: IntrinsicWidth(
                                child: Container(
                                  height: 50,
                                  width: Get.width * 0.9,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
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
                                      "Cancel the Order",
                                      style: mediumFont(Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
