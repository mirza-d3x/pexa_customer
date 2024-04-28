import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/helper/date_converter.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/not_logged_in_screen.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/screens/notification/widget/notification_dialog.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _loadData() async {
    Get.find<NotificationController>().clearNotification();
    if (Get.find<AuthFactorsController>().isLoggedIn.value) {
      Get.find<NotificationController>().getNotificationList(true);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (GetPlatform.isMobile
          ? CustomAppBar(
              title: 'notification'.tr,
              showNotification: false,
            )
          : CustomAppBarWeb(
              title: 'notification'.tr,
              showNotification: false,
            )) as PreferredSizeWidget?,
      body: Get.find<AuthFactorsController>().isLoggedIn()
          ? GetBuilder<NotificationController>(
              builder: (notificationController) {
              List<DateTime> dateTimeList = [];
              return notificationController.notificationList != null
                  ? notificationController.notificationList!.isNotEmpty
                      ? RefreshIndicator(
                          onRefresh: () async {
                            await notificationController
                                .getNotificationList(true);
                          },
                          child: Scrollbar(
                              child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                                child: SizedBox(
                                    width: Dimensions.WEB_MAX_WIDTH,
                                    child: ListView.builder(
                                      itemCount: notificationController
                                          .notificationList!.length,
                                      padding: const EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        DateTime originalDateTime =
                                            DateConverter.dateTimeStringToDate(
                                                notificationController
                                                    .notificationList![index]
                                                    .createdAt
                                                    .toString());
                                        DateTime convertedDate = DateTime(
                                            originalDateTime.year,
                                            originalDateTime.month,
                                            originalDateTime.day);
                                        bool addTitle = false;
                                        if (!dateTimeList
                                            .contains(convertedDate)) {
                                          addTitle = true;
                                          dateTimeList.add(convertedDate);
                                        }
                                        return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              addTitle
                                                  ? Padding(
                                                      padding: const EdgeInsets.only(
                                                          bottom: Dimensions
                                                              .PADDING_SIZE_EXTRA_SMALL),
                                                      child: Text(DateConverter
                                                          .dateTimeStringToDateOnly(
                                                              notificationController
                                                                  .notificationList![
                                                                      index]
                                                                  .createdAt
                                                                  .toString())),
                                                    )
                                                  : const SizedBox(),
                                              NotificationTile(
                                                  context,
                                                  notificationController,
                                                  index),
                                              // Padding(
                                              //   padding:
                                              //       EdgeInsets.only(left: 50),
                                              //   child: Divider(
                                              //       color: Theme.of(context)
                                              //           .disabledColor,
                                              //       thickness: 1),
                                              // ),
                                            ]);
                                      },
                                    ))),
                          )),
                        )
                      : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 50,
                                color: Theme.of(context).disabledColor,
                              ),
                              const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL,
                              ),
                              Text(
                                "No notification available",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                            ],
                          ),
                        )
                  : const Center(child: CircularProgressIndicator());
            })
          : const NotLoggedInScreen(),
    );
  }

  Widget NotificationTile(BuildContext context,
      NotificationController notificationController, int index) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              if (!notificationController.notificationList![index].read!) {
                notificationController.setSeenNotification(
                    [notificationController.notificationList![index].id]);
              }
              return NotificationDialog(
                  notificationModel:
                      notificationController.notificationList![index]);
            });
      },
      child: Card(
        color: notificationController.notificationList![index].read!
            ? Theme.of(context).cardColor.withOpacity(0.6)
            : Theme.of(context).cardColor,
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: Dimensions.PADDING_SIZE_SMALL,
              horizontal: Dimensions.PADDING_SIZE_SMALL),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                ClipOval(
                    child: CustomImage(
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  image: notificationController
                              .notificationList![index].imageUrl!.isNotEmpty
                      ? notificationController.notificationList![index].imageUrl![0]
                      : '',
                )),
                const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                SizedBox(
                  width: Get.width * 0.4,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationController
                                  .notificationList![index].title ??
                              '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                        Text(
                          notificationController
                                  .notificationList![index].description ??
                              '',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                      ]),
                ),
              ],
            ),
            Text(
              DateConverter.timeAgo(
                      dateTime: notificationController
                          .notificationList![index].updatedAt!,
                      numericDates: true)
                  .toString(),
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            )
          ]),
        ),
      ),
    );
  }
}
