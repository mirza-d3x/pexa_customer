import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdateScreen extends StatelessWidget {
  final bool isUpdate;
  const UpdateScreen({super.key, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              isUpdate ? Images.update : Images.maintenance,
              width: MediaQuery.of(context).size.height * 0.4,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              isUpdate ? 'update'.tr : 'we_are_under_maintenance'.tr,
              style: robotoBold.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.023,
                  color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              isUpdate
                  ? 'your_app_is_deprecated'.tr
                  : 'we_will_be_right_back'.tr,
              style: robotoRegular.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.0175,
                  color: Theme.of(context).disabledColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                height:
                    isUpdate ? MediaQuery.of(context).size.height * 0.04 : 0),
            isUpdate
                ? CustomButton(
                    buttonText: 'update_now'.tr,
                    onPressed: () async {
                      String appUrl = 'https://google.com';
                      if (GetPlatform.isAndroid) {
                        appUrl =
                            'market://details?id=com.carclenx.motor.shoping';
                      } else if (GetPlatform.isIOS) {
                        appUrl =
                            'https://apps.apple.com/app/pexa-shoppe/id1613868591';
                      }
                      if (await canLaunchUrlString(appUrl)) {
                        launchUrlString(appUrl,
                            mode: LaunchMode.externalApplication);
                      } else {
                        showCustomSnackBar('${'can_not_launch'.tr} $appUrl');
                      }
                    })
                : const SizedBox(),
          ]),
        ),
      ),
    );
  }
}
