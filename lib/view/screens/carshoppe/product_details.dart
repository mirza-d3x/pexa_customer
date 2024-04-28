import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/buy_now_controller.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/controller/myController/connectivityController.dart';
import 'package:shoppe_customer/controller/myController/couponController.dart';
import 'package:shoppe_customer/controller/myController/productController.dart';
import 'package:shoppe_customer/helper/dynamiclink_helper.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/view/base/custom_appbar_web.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';
import 'package:shoppe_customer/view/screens/carshoppe/widget/returnpolicy.dart';
import 'package:shoppe_customer/view/screens/carshoppe/full_image.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/view/screens/error_screen/noInternetScreen.dart';
import 'package:readmore/readmore.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, Key? keys, this.isFromLink});
  static bool check = true;
  String? isFromLink;
  var iniCount = Get.find<ProductDetailsController>().prodCount.value = 1;

  @override
  Widget build(BuildContext context) {
    return (Get.find<ConnectivityController>().status)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: (GetPlatform.isMobile
                ? const CustomAppBar(title: 'Product Details', showCart: true)
                : CustomAppBarWeb(
                    title: 'Product Details',
                    showCart: true,
                  )) as PreferredSizeWidget?,
            body: GetBuilder<ProductDetailsController>(
                builder: (productDetailController) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            mainAxisAlignment: GetPlatform.isMobile
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.start,
                            crossAxisAlignment: GetPlatform.isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              GetPlatform.isMobile ||
                                      ResponsiveHelper.isMobile(context)
                                  ? Column(
                                      children: [
                                        productImageSection(
                                            productDetailController, context),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        productDetailsSection(
                                            productDetailController, context),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        productImageSection(
                                            productDetailController, context),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        productDetailsSection(
                                            productDetailController, context),
                                      ],
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              quantityPickerSection(productDetailController),
                              const SizedBox(
                                height: 20,
                              ),
                              priceDetailSection(productDetailController),
                              SizedBox(
                                child: productDetailController
                                                .productDetails!.quantity! <
                                            10 &&
                                        productDetailController
                                                .productDetails!.quantity! >
                                            0
                                    ? SizedBox(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              GetPlatform.isMobile
                                                  ? MainAxisAlignment.center
                                                  : MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Only ${productDetailController.productDetails!.quantity} left in stock. Buy it fast !',
                                              style: defaultFont(
                                                color: Colors.orange,
                                                size: 15,
                                                weight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              GetPlatform.isMobile ||
                                      ResponsiveHelper.isMobile(context)
                                  ? Column(
                                      children: [
                                        cartButton(productDetailController),
                                        const SizedBox(height: 20),
                                        buyNowButton(
                                            productDetailController, context),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                            width: Get.width * 0.2,
                                            child: cartButton(
                                                productDetailController)),
                                        const SizedBox(
                                            width:
                                                Dimensions.PADDING_SIZE_SMALL),
                                        SizedBox(
                                          width: Get.width * 0.2,
                                          child: buyNowButton(
                                              productDetailController, context),
                                        ),
                                      ],
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(() => const ReturnPolicy());
                                      },
                                      child: Text(
                                        'Checkout our Return Policy?',
                                        style: defaultFont(
                                            color: Colors.blue[900]),
                                      ))
                                ],
                              )
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 6,
                            child: IconButton(
                                tooltip: "Share",
                                onPressed: () {
                                  DynamicLinkHelper().shareContent(
                                      image: productDetailController
                                          .productDetails!.imageUrl![0],
                                      productId: productDetailController
                                          .productDetails!.id,
                                      productName: productDetailController
                                          .productDetails!.name,
                                      description: productDetailController
                                          .productDetails!.description);
                                },
                                icon: const Icon(Icons.share)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : const Scaffold(body: NoInternetScreenView());
  }

  Container cartButton(ProductDetailsController productDetailController) {
    return Container(
      child: GetBuilder<CartControllerFile>(builder: (cartControllerFile) {
        return Row(
          children: [
            Expanded(
              // flex: 3,
              child: CustomButton(
                icon: cartControllerFile.isInCart.value
                    ? Icons.shopping_cart_checkout
                    : Icons.shopping_cart,
                buttonText: cartControllerFile.isInCart.value
                    ? 'Go to Cart'
                    : 'Add to Cart',
                bodyColor: const Color.fromRGBO(45, 45, 45, 1),
                fontSize: 20,
                fontColor: Colors.white,
                onPressed: () {
                  if (Get.find<AuthFactorsController>().isLoggedIn.value) {
                    if (cartControllerFile.isInCart.value) {
                      cartControllerFile.getCartDetails(true).then(
                          (value) => Get.toNamed(RouteHelper.cart, arguments: {
                                'fromNav': true,
                                'fromMain': false,
                                'prodId':
                                    productDetailController.productDetails!.id,
                              }));
                    } else {
                      if (productDetailController.productDetails!.quantity! >
                          0) {
                        if (productDetailController.prodCount <=
                            (productDetailController.productDetails!.quantity!)) {
                          cartControllerFile
                              .addOrUpdateToCart(
                                  productDetailController.productDetails!.id,
                                  productDetailController.prodCount.value,
                                  'add')
                              .then((value) => cartControllerFile
                                  .checkProductInCart(productDetailController
                                      .productDetails!.id));
                        } else {
                          SmartDialog.showToast(
                            'Not much stock available, please reduce the quantity',
                          );
                        }
                      } else {
                        if (check) {
                          check = false;
                          SmartDialog.showToast(
                            'Out of Stock',
                          );
                          Timer(const Duration(seconds: 2), () async {
                            check = true;
                          });
                        }
                      }
                    }
                  } else {
                    showCustomSnackBar("You have to login first.",
                        title: 'Warning', isError: true);
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  GetBuilder<BuyNowController> buyNowButton(
      ProductDetailsController productDetailController, BuildContext context) {
    return GetBuilder<BuyNowController>(builder: (buyNowController) {
      return CustomButton(
        buttonText: 'Buy Now',
        fontSize: 20,
        bodyColor: productDetailController.productDetails!.quantity! > 0
            ? Theme.of(context).primaryColor
            : const Color.fromRGBO(239, 226, 160, 1),
        fontColor: productDetailController.productDetails!.quantity! > 0
            ? Colors.black
            : Colors.black26,
        onPressed: () {
          if (Get.find<AuthFactorsController>().isLoggedIn.value) {
            if (productDetailController.productDetails!.quantity! > 0) {
              final addressController = Get.find<AddressControllerFile>();
              if (addressController.addressList == null ||
                  addressController.addressList!.isEmpty) {
                addressController.getAddress();
              }
              buyNowController
                  .setBuyNowQuantity(productDetailController.prodCount.value);
              Get.find<ProductCategoryController>()
                  .getShippingDetails(productDetailController
                      .productDetails!.offerPrice
                      .toString())
                  .then((value) {
                buyNowController.buyNowTotal(
                    price: productDetailController.productDetails!.offerPrice!,
                    deliveryCharge: Get.find<ProductCategoryController>()
                        .buyNowShipping
                        .value);
              });

              Get.find<CouponController>().clearValue();

              Get.toNamed(RouteHelper.shoppeCheckOut, arguments: {
                //'product':
                'quantity': productDetailController.prodCount
              });
            } else {
              if (check) {
                check = false;
                SmartDialog.showToast(
                  'Out of Stock',
                );
                Timer(const Duration(seconds: 2), () async {
                  check = true;
                });
              }
            }
          } else {
            showCustomSnackBar("You have to login first.",
                title: 'Warning', isError: true);
          }
        },
      );
    });
  }

  Widget priceDetailSection(ProductDetailsController productDetailController) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: GetPlatform.isMobile
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: GetPlatform.isMobile
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  productDetailController.productDetails!.offerPrice ==
                          productDetailController.productDetails!.price
                      ? Container()
                      : Text(
                          '₹ ' +
                              PriceConverter.priceToDecimal(
                                  productDetailController.productDetails!.price
                                      .toString()),
                          style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                  Text(
                    '₹ ' +
                        PriceConverter.priceToDecimal(productDetailController
                            .productDetails!.offerPrice
                            .toString()),
                    style: defaultFont(
                      color: Colors.black,
                      size: 25,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ]),
        productDetailController.productDetails!.offerPrice! >=
                productDetailController.productDetails!.price!
            ? Container()
            : Row(
                mainAxisAlignment: GetPlatform.isMobile
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Text(
                    'You will save ₹ ${PriceConverter.priceToDecimal(productDetailController.productDetails!.price! - productDetailController.productDetails!.offerPrice!)} on this purchase.',
                    style: defaultFont(
                      color: Colors.green,
                      size: 15,
                      weight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Row quantityPickerSection(ProductDetailsController productDetailController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Quantity : ',
          style: defaultFont(
            color: Colors.black,
            size: 18,
            weight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            TextButton(
                onPressed: () {
                  if (productDetailController.productDetails!.quantity! > 0) {
                    productDetailController.subtractProductCount();
                  }
                },
                child: Text(
                  '-',
                  style: defaultFont(
                    color: (productDetailController.productDetails!.quantity! > 0)
                        ? Colors.black
                        : Colors.black38,
                    size: 20,
                    weight: FontWeight.w400,
                  ),
                )),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (productDetailController.productDetails!.quantity! > 0)
                    ? Colors.white
                    : Colors.black12,
                border: Border.all(
                  color: (productDetailController.productDetails!.quantity! > 0)
                      ? Colors.black.withOpacity(0.3)
                      : Colors.white,
                  width: 1,
                ),
              ),
              child: Text(
                (productDetailController.productDetails!.quantity! > 0)
                    ? productDetailController.prodCount.toString()
                    : "0",
                style: defaultFont(
                  color: Colors.black,
                  size: 15,
                  weight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (productDetailController.productDetails!.quantity! > 0) {
                    productDetailController.addProductCount();
                  }
                },
                child: Text(
                  '+',
                  style: defaultFont(
                    color: (productDetailController.productDetails!.quantity! > 0)
                        ? Colors.black
                        : Colors.black38,
                    size: 20,
                    weight: FontWeight.w400,
                  ),
                )),
          ],
        ),
      ],
    );
  }

  Widget productImageSection(
      ProductDetailsController productDetailController, BuildContext context) {
    return Column(
      children: [
        productDetailController.productDetails!.imageUrl!.length > 1
            ? SizedBox(
                width: ResponsiveHelper.isTab(context)
                    ? Get.width * 0.3
                    : ResponsiveHelper.isMobile(context)
                        ? Get.width * 0.8
                        : Get.width * 0.2,
                height: 200,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      // height:
                      //     ResponsiveHelper.isDesktop(context) ? 400 : 200,
                      autoPlayInterval: const Duration(seconds: 6),
                      onPageChanged: (index, reason) {},
                      enableInfiniteScroll: false),
                  itemCount:
                      productDetailController.productDetails!.imageUrl!.length,
                  itemBuilder: (context, indx, _) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            if (productDetailController
                                        .productDetails!.imageUrl !=
                                    null &&
                                productDetailController
                                        .productDetails!.imageUrl!.isNotEmpty) {
                              Get.to(FullImage(
                                  path: productDetailController
                                      .productDetails!.imageUrl![indx]));
                            }
                          },
                          child: Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.grey[Get.isDarkMode ? 800 : 200]!,
                                    spreadRadius: 1,
                                    blurRadius: 5)
                              ],
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: ClipRRect(
                              child: CustomImage(
                                image: productDetailController
                                                .productDetails!.imageUrl !=
                                            null &&
                                        productDetailController.productDetails!
                                                .imageUrl!.isNotEmpty
                                    ? productDetailController
                                        .productDetails!.imageUrl![indx]
                                    : "",
                                fit: BoxFit.fill,
                              ),
                            ),
                          )),
                    );
                  },
                ),
              )
            : InkWell(
                onTap: () {
                  Get.to(() => FullImage(
                      path: productDetailController.productDetails!.imageUrl !=
                                  null &&
                              productDetailController
                                      .productDetails!.imageUrl!.isNotEmpty
                          ? productDetailController.productDetails!.imageUrl![0]
                          : ""));
                },
                child: Container(
                    height: 200,
                    width: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 210, 210, 210), width: 1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CustomImage(
                        image: productDetailController
                                        .productDetails!.imageUrl !=
                                    null &&
                                productDetailController
                                        .productDetails!.imageUrl!.isNotEmpty
                            ? productDetailController.productDetails!.imageUrl![0]
                            : "",
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
        const SizedBox(
          height: 10,
        ),
        productDetailController.productDetails!.imageUrl!.length > 1
            ? Container(
                height: 5,
                width: 5,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              )
            : Container(),
      ],
    );
  }

  Column productDetailsSection(
      ProductDetailsController productDetailController, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: ResponsiveHelper.isMobile(context)
              ? Get.width * 0.6
              : ResponsiveHelper.isDesktop(context)
                  ? Get.width * 0.4
                  : Get.width * 0.3,
          child: Text(
            productDetailController.productDetails!.name!,
            style: defaultFont(
              color: Colors.black,
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: GetPlatform.isMobile ? 0 : Dimensions.PADDING_SIZE_SMALL,
        ),
        productDetailController.productDetails!.quantity! > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Available',
                      style: defaultFont(
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 20,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Out of Stock',
                      style: defaultFont(
                        color: Colors.white,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Details : ',
              style: defaultFont(
                color: Colors.black,
                size: 18,
                weight: FontWeight.w400,
              ),
            ),
            SizedBox(
                width: ResponsiveHelper.isMobile(context)
                    ? Get.width * 0.6
                    : Get.width * 0.4,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReadMoreText(
                        productDetailController.productDetails!.description!,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        trimLines: ResponsiveHelper.isMobile(context)
                            ? 5
                            : ResponsiveHelper.isTab(context)
                                ? 5
                                : 2,
                        style: defaultFont(
                          color: Colors.black,
                          size: 18,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
