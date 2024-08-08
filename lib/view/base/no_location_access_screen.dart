import 'dart:ui';

import 'package:flutter/src/services/predictive_back_event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/controller/myController/initial_loader_controller.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:flutter/material.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NoLocationAccessScreen extends StatefulWidget {
  final String? route;
  const NoLocationAccessScreen({super.key, this.route});

  @override
  State<NoLocationAccessScreen> createState() => _NoLocationAccessScreenState();
}

class _NoLocationAccessScreenState extends State<NoLocationAccessScreen>
    implements WidgetsBindingObserver {
  final RefreshController _refreshController = RefreshController();

  final ScrollController _scrollController = ScrollController();

  Future<void> refreshData() async {
    Get.find<locationPermissionController>().determinePosition();
    if (Get.find<locationPermissionController>().locationEnabled.value) {
      if (widget.route == "/splash" ||
          widget.route == "/verification" ||
          widget.route == "/") {
        Get.find<InitialLoaderController>().loadData();
        Get.offAllNamed(RouteHelper.initial);
      } else {
        Get.back();
      }
    }
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<locationPermissionController>(
        builder: (locationEnabledController) {
      if (locationEnabledController.locationEnabled.value) {
        Future.delayed(const Duration(seconds: 3), (() {
          Get.find<InitialLoaderController>().loadData();
          Get.offAllNamed(RouteHelper.initial);
        }));
      }
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
            child: SmartRefresher(
              controller: _refreshController,
              scrollController: _scrollController,
              enablePullDown: true,
              onRefresh: refreshData,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      // Spacer(),
                      SizedBox(
                        height: Get.height * 0.2,
                      ),
                      Image.asset(
                        Images.no_location_icon,
                        width: Get.height * 0.25,
                        height: Get.height * 0.25,
                      ),
                      // Spacer(),
                      Text(
                        'Sorry',
                        style: largeFont(Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        locationEnabledController.permission ==
                                LocationPermission.deniedForever
                            ? 'You have permenantly denied the location permission, Location details are needed to check whether our products and services are available in your area.\n Please update location permission on settings.'
                            : locationEnabledController.permission ==
                                    LocationPermission.denied
                                ? 'You have denied the location permission, Location details are needed to check whether our products and services are available in your area.'
                                : 'Location permission needed.',
                        style: mediumFont(Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      // Spacer(),
                      const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                      !locationEnabledController.locationEnabled.value
                          ? GetPlatform.isAndroid || GetPlatform.isIOS
                              ? CustomButton(
                                  height: Get.height * 0.04,
                                  width: Get.width * 0.5,
                                  onPressed: () async {
                                    if (locationEnabledController.permission ==
                                        LocationPermission.deniedForever) {
                                      showPermissionDialog(
                                          context: context,
                                          openSettings: true,
                                          locationEnabledController:
                                              locationEnabledController);
                                    }
                                    if (locationEnabledController.permission ==
                                        LocationPermission.denied) {
                                      LocationPermission status =
                                          await Geolocator.requestPermission()
                                              .onError((dynamic error, stackTrace) {
                                        showPermissionDialog(
                                            context: context,
                                            openSettings: true,
                                            locationEnabledController:
                                                locationEnabledController);

                                        return Future.error(error);
                                      }).catchError((onError) {
                                        print(onError.toString());
                                      });
                                      if (status ==
                                          LocationPermission.deniedForever) {
                                        showPermissionDialog(
                                            context: context,
                                            openSettings: true,
                                            isDeniedForever: status ==
                                                LocationPermission
                                                    .deniedForever,
                                            locationEnabledController:
                                                locationEnabledController);
                                      }
                                    }
                                  },
                                  buttonText:
                                      locationEnabledController.permission ==
                                              LocationPermission.deniedForever
                                          ? 'Open Settings'
                                          : 'Open permission request',
                                )
                              : const SizedBox()
                          : const SizedBox(),
                      const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                      !locationEnabledController.loaderHelper.isLoading
                          ? CustomButton(
                              icon: Icons.refresh,
                              height: Get.height * 0.04,
                              width: Get.width * 0.5,
                              onPressed: () {
                                if (locationEnabledController.permission ==
                                        LocationPermission.denied ||
                                    locationEnabledController.permission ==
                                        LocationPermission.deniedForever) {
                                  showPermissionDialog(
                                      context: context, openSettings: false);
                                }
                              },
                              buttonText: 'Reload',
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),

                      // Spacer()
                    ]),
              ),
            ),
          ),
        ),
      );
    });
  }

  showPermissionDialog(
      {required BuildContext context,
      bool? openSettings,
      bool isDeniedForever = false,
      locationPermissionController? locationEnabledController}) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return GetBuilder<locationPermissionController>(
              builder: (locationEnabledController) {
            return AlertDialog(
              title: Text(
                'Information',
                style: largeFont(Colors.red),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      locationEnabledController.permission ==
                              LocationPermission.denied
                          ? isDeniedForever
                              ? 'You have denied location permission for PEXA.Change location settings to continue'
                              : 'You have denied location permission'
                          : locationEnabledController.permission ==
                                  LocationPermission.deniedForever
                              ? 'You have denied forever location permission for PEXA.Change location settings to continue'
                              : 'Welcome to Pexa',
                      textAlign: TextAlign.center,
                      style: mediumFont(Colors.grey),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                    if (openSettings!) {
                      openSettingsForPermission(locationEnabledController);
                      checkPermission(locationEnabledController);
                    } else {
                      checkPermission(locationEnabledController);
                    }
                  }),
                  child: Text(
                    'OK',
                    style: largeFont(Colors.black),
                  ),
                ),
              ],
            );
          });
        });
  }

  checkPermission(locationPermissionController locationEnabledController) {
    locationEnabledController.determinePosition();
    if (locationEnabledController.locationEnabled.value) {
      if (widget.route == "/splash" ||
          widget.route == "/verification" ||
          widget.route == "/") {
        Get.find<InitialLoaderController>().loadData();
        Get.offAllNamed(RouteHelper.initial);
      } else {
        Get.back();
      }
    }
  }

  openSettingsForPermission(
      locationPermissionController locationEnabledController) {
    openAppSettings().then((value) {
      if (value) {
        locationEnabledController.determinePosition();
        if (locationEnabledController.locationEnabled.value) {
          if (widget.route == "/splash" ||
              widget.route == "/verification" ||
              widget.route == "/") {
            Get.find<InitialLoaderController>().loadData();
            Get.offAllNamed(RouteHelper.initial);
          } else {
            Get.back();
          }
        }
      }
    });
  }

  @override
  void didChangeAccessibilityFeatures() {
    // TODO: implement didChangeAccessibilityFeatures
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Get.find<CurrentLocationController>().locationEnabled.listen((p0) {
        //   showCustomSnackBar(p0.toString());
        // }, onError: () {
        //   checkPermission(Get.find<CurrentLocationController>());
        // });
        checkPermission(Get.find<locationPermissionController>());

        return;
      default:
        return;
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    // TODO: implement didChangeLocales
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    // TODO: implement didPushRouteInformation
    throw UnimplementedError();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() {
    // TODO: implement didRequestAppExit
    throw UnimplementedError();
  }

  @override
  void handleCancelBackGesture() {
    // TODO: implement handleCancelBackGesture
  }

  @override
  void handleCommitBackGesture() {
    // TODO: implement handleCommitBackGesture
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    // TODO: implement handleStartBackGesture
    throw UnimplementedError();
  }

  @override
  void handleUpdateBackGestureProgress(PredictiveBackEvent backEvent) {
    // TODO: implement handleUpdateBackGestureProgress
  }
}
