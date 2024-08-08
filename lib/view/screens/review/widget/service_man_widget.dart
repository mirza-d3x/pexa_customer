import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/orderController.dart';
import 'package:shoppe_customer/data/models/service_order_model.dart';
import 'package:shoppe_customer/data/models/worker_details/worker_details_model.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/util/styles.dart';

class ServiceManWidget extends StatelessWidget {
  final WorkerDetails? workerDetails;
  final bool showPhone;
  var rating;
  int? ratingUserCount;
  final ServiceOrderModel? orderDetails;
  ServiceManWidget(
      {super.key,
      required this.workerDetails,
      this.showPhone = false,
      this.rating,
      this.ratingUserCount,
      this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
        /*boxShadow: [
          BoxShadow(
            color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],*/
      ),
      child: GetBuilder<OrderController>(
        builder: (orderController) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  Text("Service Partner",
            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),*/
                Row(
                    /*  leading: ClipOval(
            child: CustomImage(
              image: workerDetails!.branchId!.images!.length > 0
                  ? workerDetails!.branchId!.images![0]
                  : "",
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),*/
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* Text(
                  '${workerDetails!.name}',
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeLarge),
                ),*/
                            Text(
                              "Pexa Partner",
                              style: smallFontNew(Colors.black),
                            ),
                            Text(
                              '${workerDetails!.name}',
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context).disabledColor,
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                          ],
                        ),
                      ),

                      /*subtitle: RatingBar(
              rating: double.parse(rating != null ? rating.toString() : "0"),
              size: 15,
              ratingCount: ratingUserCount ?? 0),*/
                      /*trailing: showPhone
              ? InkWell(
                  onTap: () => launchUrlString(
                      'tel:${workerDetails!.branchId!.phone}',
                      mode: LaunchMode.externalApplication),
                  child: Container(
                    padding:
                        EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).disabledColor.withOpacity(0.2)),
                    child: Icon(Icons.call_outlined),
                  ),
                )
              : SizedBox(),*/
                    ]),
                const SizedBox(
                  height: 10,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_pin,
                        size: 12,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderDetails!.address!.name
                                .toString()
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: smallFontNew(Colors.black),
                            maxLines: 2,
                          ),
                          Text(
                            (orderDetails!.address!.street != null
                                    ? '${orderDetails!.address!.street!}, '
                                    : '')
                                .toString()
                                .toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: smallFont(Colors.black),
                          ),
                        ],
                      ),
                    ]),
              ]);
        },
      ),
    );
  }
}
