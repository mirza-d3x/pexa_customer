import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/imageCacheController.dart';
import 'package:shoppe_customer/controller/myController/initial_loader_controller.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/cart_widget.dart';
import 'package:shoppe_customer/view/base/notification_icon.dart';

class CustomAppBarWeb extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBarWeb(
      {super.key,
      required this.title,
      this.isBackButtonExist = true,
      this.isMain = false,
      this.onMenuClick,
      this.onBackPressed,
      this.showNotification = true,
      this.showSearch = true,
      this.backgroundColor,
      this.showCart = false});

  final String? title;
  final bool isBackButtonExist;
  final bool isMain;
  final Function? onBackPressed;
  final Function? onMenuClick;
  final bool showCart;
  final bool showNotification;
  final bool showSearch;
  final Color? backgroundColor;

  final imageCacheController = Get.put(ImageCacheController());

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: GetBuilder<AuthFactorsController>(builder: (authController) {
        return AppBar(
          title: backgroundColor != null &&
                  backgroundColor == Colors.transparent &&
                  title!.isNotEmpty
              ? IntrinsicWidth(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: Colors.white.withOpacity(0.7),
                    ),
                    child: Center(
                        child: Text(title!.toUpperCase(),
                            style: mediumFont(Colors.black))),
                  ),
                )
              : Text(title!.toUpperCase(), style: mediumFont(Colors.black)),
          centerTitle: true,
          leading: isBackButtonExist && !isMain
              ? backgroundColor != null && backgroundColor == Colors.transparent
                  ? SizedBox(
                      child: Center(
                        child: InkWell(
                          onTap: () => onBackPressed != null
                              ? onBackPressed!()
                              : Navigator.pop(context),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: Colors.white.withOpacity(0.7),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.black,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 15,
                      ),
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      onPressed: () => onBackPressed != null
                          ? onBackPressed!()
                          : Navigator.pop(context),
                    )
              : isMain
                  ? IconButton(
                      icon: Image.asset(
                        Images.menu_ico,
                        width: 25,
                      ),
                      onPressed: onMenuClick as void Function()?,
                    )
                  : const SizedBox(),
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          elevation: 0,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GetPlatform.isWeb
                    ? !GetPlatform.isWeb &&
                            backgroundColor != null &&
                            backgroundColor == Colors.transparent
                        ? SizedBox(
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getInitialRoute(
                                      page: 'home'));
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(50)),
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.home,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.find<InitialLoaderController>()
                                        .loadData();
                                    Get.offAllNamed(RouteHelper.getInitialRoute(
                                        page: 'home'));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.home,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width:
                                              ResponsiveHelper.isMobile(context)
                                                  ? 0
                                                  : Dimensions
                                                      .PADDING_SIZE_SMALL,
                                        ),
                                        ResponsiveHelper.isMobile(context)
                                            ? const SizedBox()
                                            : Text('Home',
                                                style:
                                                    mediumFont(Colors.black)),
                                        // SizedBox(
                                        //   width:
                                        //       ResponsiveHelper.isMobile(context)
                                        //           ? 0
                                        //           : Dimensions
                                        //               .PADDING_SIZE_DEFAULT,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                    : const SizedBox(),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                showSearch
                    ? backgroundColor != null &&
                            backgroundColor == Colors.transparent &&
                            !isMain
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                Get.find<ShoppeSearchController>().clearList();
                                Get.toNamed(RouteHelper.search);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            // width: 25,
                            child: InkWell(
                              child: Container(
                                // height: 40,
                                // width: 40,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    SizedBox(
                                      width: ResponsiveHelper.isMobile(context)
                                          ? 0
                                          : Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    ResponsiveHelper.isMobile(context)
                                        ? const SizedBox()
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                right: Dimensions
                                                    .PADDING_SIZE_SMALL),
                                            child: Text('Search',
                                                style:
                                                    mediumFont(Colors.black)),
                                          )
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.find<ShoppeSearchController>().clearList();
                                Get.toNamed(RouteHelper.search);
                              },
                            ),
                          )
                    : const SizedBox(),
                SizedBox(
                  width: showCart && authController.isLoggedIn.value
                      ? 0
                      : Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                showCart && authController.isLoggedIn.value
                    ? (isMain && !GetPlatform.isWeb) &&
                            backgroundColor != null &&
                            backgroundColor == Colors.transparent
                        ? Center(
                            child: InkWell(
                              onTap: () {
                                Get.find<CartControllerFile>()
                                    .getCartDetails(true);
                                Get.toNamed(RouteHelper.getCartRoute(),
                                    arguments: {
                                      'fromNav': true,
                                      'fromMain': false,
                                      'prodId': ""
                                    });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                                child: Center(
                                  child: CartWidget(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      size: 25),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            child: InkWell(
                              onTap: () {
                                Get.find<CartControllerFile>()
                                    .getCartDetails(true);
                                Get.toNamed(RouteHelper.getCartRoute(),
                                    arguments: {
                                      'fromNav': true,
                                      'fromMain': false,
                                      'prodId': ""
                                    });
                              },
                              child: Container(
                                // height: 40,
                                // width: 40,
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Row(
                                  children: [
                                    CartWidget(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        size: 25),
                                    SizedBox(
                                      width: ResponsiveHelper.isMobile(context)
                                          ? 0
                                          : Dimensions.PADDING_SIZE_SMALL,
                                    ),
                                    ResponsiveHelper.isMobile(context)
                                        ? const SizedBox()
                                        : Text('Cart',
                                            style: mediumFont(Colors.black)),
                                    const SizedBox(
                                      width: Dimensions.PADDING_SIZE_DEFAULT,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                    : const SizedBox(),
                // SizedBox(
                //   width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                // ),
                !authController.isLoggedIn.value
                    ? InkWell(
                        onTap: (() {
                          if (authController.isLoggedIn.value) {
                          } else {
                            Get.toNamed(RouteHelper.login);
                          }
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidCircleUser,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: ResponsiveHelper.isMobile(context)
                                    ? 0
                                    : Dimensions.PADDING_SIZE_SMALL,
                              ),
                              ResponsiveHelper.isMobile(context)
                                  ? const SizedBox()
                                  : Text(
                                      authController.isLoggedIn.value
                                          ? 'Profile'
                                          : 'Login',
                                      style: mediumFont(Colors.black)),
                              const SizedBox(
                                width: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                            ],
                          ),
                        ),
                      )
                    : PopupMenuButton(
                        tooltip: '',
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: 'profile',
                              child: Text('Profile'),
                            ),
                            const PopupMenuItem(
                              value: 'logout',
                              child: Text('Logout'),
                            )
                          ];
                        },
                        onSelected: (dynamic value) {
                          if (value == 'profile') {
                            if (authController.isLoggedIn.value) {
                              Get.toNamed(RouteHelper.getProfileRoute());
                            } else {
                              Get.toNamed(RouteHelper.login);
                            }
                          } else {
                            if (Get.find<AuthFactorsController>()
                                .isLoggedIn
                                .value) {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Alert..!',
                                      style: largeFont(Colors.red),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          Text(
                                            'Are you sure to logout?',
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
                                          Navigator.of(context).pop();
                                          imageCacheController.clearCache();
                                          Get.find<AuthFactorsController>()
                                              .logOut()
                                              .then((value) =>
                                                  // Get.off(LoginPage())
                                                  Get.offAndToNamed(RouteHelper
                                                      .getSignInRoute(
                                                          page: Get
                                                              .currentRoute)));
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              imageCacheController.clearCache();
                              Get.offAndToNamed(RouteHelper.login);
                            }
                          }
                        },
                        offset: const Offset(0, 50),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.solidCircleUser,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: ResponsiveHelper.isMobile(context)
                                    ? 0
                                    : Dimensions.PADDING_SIZE_SMALL,
                              ),
                              ResponsiveHelper.isMobile(context)
                                  ? const SizedBox()
                                  : Text(
                                      authController.isLoggedIn.value
                                          ? 'Profile'
                                          : 'Login',
                                      style: mediumFont(Colors.black)),
                              const SizedBox(
                                width: Dimensions.PADDING_SIZE_DEFAULT,
                              ),
                            ],
                          ),
                        ),
                      ),
                showNotification && authController.isLoggedIn.value
                    ? backgroundColor != null &&
                            backgroundColor == Colors.transparent &&
                            !isMain
                        ? SizedBox(
                            width: 30,
                            child: InkWell(
                              onTap: () =>
                                  Get.toNamed(RouteHelper.notification),
                              child: GetBuilder<NotificationController>(
                                  builder: (notificationController) {
                                return Container(
                                  height: 30,
                                  width: 30,
                                  padding: const EdgeInsets.all(3),
                                  alignment: Alignment.center,
                                  // padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  child: NotificationIcon(
                                    backgroundColor: backgroundColor,
                                    hasNotification:
                                        notificationController.hasNotification,
                                  ),
                                );
                              }),
                            ),
                          )
                        : Container(
                            // width: 30,
                            child: InkWell(
                              child: GetBuilder<NotificationController>(
                                  builder: (notificationController) {
                                return Container(
                                  padding: const EdgeInsets.all(4),
                                  // height: 40,
                                  // width: 40,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 30,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: NotificationIcon(
                                          backgroundColor: backgroundColor,
                                          hasNotification:
                                              notificationController
                                                  .hasNotification,
                                          isHome: isMain,
                                        ),
                                      ),
                                      SizedBox(
                                        width: GetPlatform.isWeb
                                            ? Dimensions.PADDING_SIZE_SMALL
                                            : 0,
                                      ),
                                      ResponsiveHelper.isMobile(context)
                                          ? const SizedBox()
                                          : Text('Notification',
                                              style: mediumFont(Colors.black)),
                                    ],
                                  ),
                                );
                              }),
                              onTap: () =>
                                  Get.toNamed(RouteHelper.notification),
                            ),
                          )
                    : const SizedBox(),
                const SizedBox(
                  width: Dimensions.PADDING_SIZE_DEFAULT,
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.WEB_MAX_WIDTH, 50);

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 100, 100),
      items: [
        const PopupMenuItem<String>(value: 'Doge', child: Text('Doge')),
        const PopupMenuItem<String>(value: 'Lion', child: Text('Lion')),
      ],
      elevation: 8.0,
    );
  }
}
