import 'package:flutter/material.dart';
import 'package:shoppe_customer/data/models/notification_model/notification_model.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';

class NotificationDialog extends StatelessWidget {
  final NotificationModel notificationModel;
  const NotificationDialog({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Theme.of(context).primaryColor.withOpacity(0.20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    image: notificationModel.imageUrl!.isNotEmpty
                        ? notificationModel.imageUrl![0]
                        : '',
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_LARGE),
                child: Text(
                  notificationModel.title!,
                  textAlign: TextAlign.center,
                  style: robotoMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Text(
                  notificationModel.description != null
                      ? notificationModel.description!
                      : '',
                  textAlign: TextAlign.center,
                  style: robotoRegular.copyWith(
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
