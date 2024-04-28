import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/helper/responsive_helper.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: GetBuilder<ShoppeSearchController>(builder: (searchController) {
          return SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(Icons.close,
                                color: Theme.of(context).disabledColor),
                          ),
                        ),
                        Text('filter'.tr,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge)),
                        CustomButton(
                          onPressed: () {
                            searchController.resetFilter();
                            Navigator.of(context).pop();
                          },
                          buttonText: 'reset'.tr,
                          transparent: true,
                          width: 65,
                        ),
                      ]),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Text('sort_by'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  GridView.builder(
                    itemCount: searchController.sortList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isDesktop(context)
                          ? 4
                          : ResponsiveHelper.isTab(context)
                              ? 3
                              : 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          searchController.setSortIndex(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: searchController.sortIndex == index
                                    ? Colors.transparent
                                    : Theme.of(context).disabledColor),
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            color: searchController.sortIndex == index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.1),
                          ),
                          child: Text(
                            searchController.sortList[index],
                            textAlign: TextAlign.center,
                            style: robotoMedium.copyWith(
                              color: searchController.sortIndex == index
                                  ? Colors.white
                                  : Theme.of(context).hintColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Text('filter_by'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  // CustomCheckBox(
                  //   title: 'veg'.tr,
                  //   value: true,
                  //   onClick: () {},
                  // ),
                  // CustomCheckBox(
                  //   title: 'non_veg'.tr,
                  //   value: false,
                  //   onClick: () {},
                  // ),
                  // CustomCheckBox(
                  //   title: isRestaurant
                  //       ? 'currently_opened_restaurants'.tr
                  //       : 'currently_available_foods'.tr,
                  //   value: true,
                  //   onClick: () {},
                  // ),
                  // CustomCheckBox(
                  //   title: isRestaurant
                  //       ? 'discounted_restaurants'.tr
                  //       : 'discounted_foods'.tr,
                  //   value: false,
                  //   onClick: () {},
                  // ),
                  // SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  Column(children: [
                    Text('price'.tr,
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge)),
                    Column(
                      children: [
                        RangeSlider(
                          values: RangeValues(
                              searchController.lowerValue
                                  .roundToDouble()
                                  .ceilToDouble(),
                              searchController.upperValue
                                  .roundToDouble()
                                  .ceilToDouble()),
                          max:
                              searchController.maxPrice.toInt().roundToDouble(),
                          min: 0,
                          divisions: searchController.maxPrice.toInt(),
                          activeColor: Theme.of(context).primaryColor,
                          inactiveColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          labels: RangeLabels(
                              searchController.lowerValue
                                  .roundToDouble()
                                  .ceilToDouble()
                                  .toString(),
                              searchController.upperValue
                                  .roundToDouble()
                                  .ceilToDouble()
                                  .toString()),
                          onChanged: (RangeValues rangeValues) {
                            searchController.setLowerAndUpperValue(
                                rangeValues.start
                                    .roundToDouble()
                                    .ceilToDouble(),
                                rangeValues.end.roundToDouble().ceilToDouble());
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Start Price : '),
                                Text(
                                  searchController.lowerValue.toString(),
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('End Price : '),
                                Text(searchController.upperValue.toString()),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                  ]),
                  // Text('rating'.tr,
                  //     style: robotoMedium.copyWith(
                  //         fontSize: Dimensions.fontSizeLarge)),
                  // Container(
                  //   height: 30,
                  //   alignment: Alignment.center,
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (context, index) {
                  //       return InkWell(
                  //         onTap: () => searchController.setRating(index + 1),
                  //         child: Icon(
                  //           searchController.rating < (index + 1)
                  //               ? Icons.star_border
                  //               : Icons.star,
                  //           size: 30,
                  //           color: searchController.rating < (index + 1)
                  //               ? Theme.of(context).disabledColor
                  //               : Theme.of(context).primaryColor,
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 30),
                  CustomButton(
                    buttonText: 'apply_filters'.tr,
                    onPressed: () {
                      Navigator.of(context).pop();
                      searchController.setFilterStatus(true);
                      searchController.sortSearchList();
                    },
                  ),
                ]),
          );
        }),
      ),
    );
  }
}
