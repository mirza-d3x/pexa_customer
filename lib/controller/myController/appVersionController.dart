import 'package:get/get.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/app_constants.dart';

class AppVersionController extends GetxController implements GetxService {
  var isOutDated = false.obs;
  bool isMinimumVersionOk = true;
  int? vStore = 0;
  int? vLocal = 0;

  Future checkVersion() async {
    if (GetPlatform.isAndroid || GetPlatform.isIOS) {
      final newVersion = NewVersionPlus(
          androidId: "com.carclenx.motor.shoping", iOSId: '1613868591');
      final status = await newVersion.getVersionStatus();
      newVersion.showAlertIfNecessary(
        context: Get.context!,
      );
      if (status != null && !status.isBlank!) {
        vStore = getExtendedVersionNumber(status.storeVersion);
        vLocal = getExtendedVersionNumber(status.localVersion);

        if (vStore! > vLocal!) {
          isOutDated.value = true;
          update();
        }
        // checkVersionBalance();
      } else {
        vLocal = getExtendedVersionNumber(AppConstants.APP_VERSION);
        vStore = getExtendedVersionNumber(AppConstants.APP_VERSION);
      }
    }
  }

  checkVersionBalance() {
    Get.find<ConnectivityController>().getInitialData().then((value) {
      if (value) {
        if (Get.find<ConnectivityController>().initialDataModel != null) {
          for (var element in Get.find<ConnectivityController>()
              .initialDataModel!
              .resultData!) {
            if (element.type == "minAppVersion") {
              if (vLocal == 0) {
                vLocal = getExtendedVersionNumber(AppConstants.APP_VERSION);
              }

              int minVer = getExtendedVersionNumber(element.value!)!;
              if (vLocal! < minVer) {
                isMinimumVersionOk = false;
                update();
              }
              if (!isMinimumVersionOk) {
                if (GetPlatform.isAndroid) {
                  Get.offNamed(RouteHelper.getUpdateRoute(true));
                }
              }
            }
          }
        }
      }
    });
  }

  int? getExtendedVersionNumber(String version) {
    List versionCells = version.split('.');
    versionCells = versionCells.map((i) => int.parse(i)).toList();
    return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
  }
}
