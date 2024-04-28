import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/images.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/view/base/cart_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
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

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: AppBar(
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
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GetPlatform.isWeb
                  ? backgroundColor != null &&
                          backgroundColor == Colors.transparent
                      ? SizedBox(
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                    RouteHelper.getInitialRoute(page: 'home'));
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
                          child: IconButton(
                            icon: const Icon(
                              Icons.home,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Get.toNamed(
                                  RouteHelper.getInitialRoute(page: 'home'));
                            },
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
                                /*child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 25,
                                ),*/
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 25,
                          /*child: IconButton(
                            padding: EdgeInsets.zero,
                            iconSize: 25,
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                            onPressed: () {
                              Get.find<ShoppeSearchController>().clearList();
                              Get.toNamed(RouteHelper.search);
                            },
                          ),*/
                        )
                  : const SizedBox(),
              SizedBox(
                width: showCart ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              showCart || GetPlatform.isWeb
                  ? backgroundColor != null &&
                          backgroundColor == Colors.transparent
                      ? Center(
                          child: InkWell(
                            onTap: () {
                              Get.find<CartControllerFile>()
                                  .getCartDetails(true);
                              Get.toNamed(RouteHelper.cart, arguments: {
                                'fromNav': !isMain,
                                'fromMain': isMain,
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
                          child: IconButton(
                            onPressed: () {
                              Get.find<CartControllerFile>()
                                  .getCartDetails(true);
                              Get.toNamed(RouteHelper.cart, arguments: {
                                'fromNav': !isMain,
                                'fromMain': isMain,
                                'prodId': ""
                              });
                            },
                            icon: /*CartWidget(
                                color:
                                    Theme.of(context).textTheme.bodyText1!.color,
                                size: 25),*/
                            const Icon(Icons.shopping_cart_sharp,size: 25,)
                          ),
                        )
                  : const SizedBox(),
              // SizedBox(
              //   width: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              // ),
              showNotification
                  ? backgroundColor != null &&
                          backgroundColor == Colors.transparent &&
                          !isMain
                      ? SizedBox(
                          width: 30,
                          child: InkWell(
                            onTap: () => Get.toNamed(RouteHelper.notification),
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
                               /* child: NotificationIcon(
                                  backgroundColor: backgroundColor,
                                  hasNotification:
                                      notificationController.hasNotification,
                                ),*/
                              );
                            }),
                          ),
                        )
                      : SizedBox(
                          width: 30,
                          child: InkWell(
                            child: GetBuilder<NotificationController>(
                                builder: (notificationController) {
                              return Container(
                                width: 30,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                               /* child: NotificationIcon(
                                  backgroundColor: backgroundColor,
                                  hasNotification:
                                      notificationController.hasNotification,
                                  isHome: isMain,
                                ),*/
                              );
                            }),
                            onTap: () => Get.toNamed(RouteHelper.notification),
                          ),
                        )
                  : const SizedBox(),
              const SizedBox(
                width: Dimensions.PADDING_SIZE_DEFAULT,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.WEB_MAX_WIDTH, 50);
}
