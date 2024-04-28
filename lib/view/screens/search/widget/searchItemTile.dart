import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/controller/myController/cartController.dart';
import 'package:shoppe_customer/helper/fonts.dart';
import 'package:shoppe_customer/helper/price_converter.dart';
import 'package:shoppe_customer/helper/route_helper.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:shoppe_customer/data/models/carShoppe/searchModel.dart';
import 'package:shoppe_customer/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItemTile extends StatelessWidget {
  const SearchItemTile({super.key, this.searchResultData, this.index});
  final SearchResultData? searchResultData;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print(searchResultData!.id);
        if (Get.find<AuthFactorsController>().isLoggedIn.value) {
          Get.find<CartControllerFile>()
              .checkProductInCart(searchResultData!.id);
        }

        Get.find<ProductCategoryController>()
            .fetchProductDetails(searchResultData!.id!)
            .then((value) {
          Get.toNamed(RouteHelper.productDetails);
        });
      },
      child: Card(
          elevation: 2,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            // height: height * 0.1,
            // width: 117.81,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    // padding: EdgeInsets.all(5),
                    child: CustomImage(
                      image: searchResultData!.imageUrl![0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xFFececec),
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          searchResultData!.name!,
                          style: smallFontW600(Colors.black),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                        searchResultData!.offerPrice == searchResultData!.price
                            ? const SizedBox()
                            : Row(
                                children: [
                                  const Spacer(),
                                  Text(
                                      '\u{20B9} ' +
                                          PriceConverter.priceToDecimal(
                                              searchResultData!.price),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough))
                                ],
                              ),
                        Row(
                          children: [
                            const Spacer(),
                            Text(
                              '\u{20B9} ' +
                                  PriceConverter.priceToDecimal(
                                      searchResultData!.offerPrice.toString()),
                              style: defaultFont(
                                color: Colors.black,
                                size: 18,
                                weight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
