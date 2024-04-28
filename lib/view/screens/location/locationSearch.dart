import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:shoppe_customer/controller/myController/searchLocationController.dart';
import 'package:shoppe_customer/util/color.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/locationPermissionController.dart';
import 'package:shoppe_customer/view/base/custom_appbar.dart';
import 'package:shoppe_customer/view/widgets/bouncing.dart';

class LocationSearchPage extends StatelessWidget {
  LocationSearchPage({super.key, Key? keys, this.isFromHome, this.isForAddress});
  bool? isFromHome;
  bool? isForAddress;

  final SearchLocationController c = Get.put(SearchLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search Location',
        showCart: false,
        showNotification: false,
        showSearch: false,
      ),
      body: GetBuilder<SearchLocationController>(
          builder: (searchLocationController) {
        return searchLocationController.isAddressSetting
            ? SizedBox(
                height: Get.height,
                child: Center(
                  child: Image.asset(
                    'assets/carSpa/loading.gif',
                    height: 50,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color: Colors.black)),
                                  child:
                                  GooglePlacesAutoCompleteTextFormField(
                                      textEditingController:  searchLocationController
                                          .searchController,
                                      googleAPIKey: "AIzaSyCcT9L1qGXL7RE-UP7qML3_U8bLRgUahyw",
                                      // only needed if you build for the web
                                      debounceTime: 400, // defaults to 600 ms
                                    // optional, by default the list is empty (no restrictions)
                                      isLatLngRequired: true, // if you require the coordinates from the place details
                                      getPlaceDetailWithLatLng: (prediction) {
                                        // this method will return latlng with place detail
                                        print("Coordinates: (${prediction.lat},${prediction.lng})");
                                      }, // this callback is called when isLatLngRequired is true
                                      itmClick: (prediction) {
                                        searchLocationController
                                            .searchController.text = prediction.description!;
                                        searchLocationController
                                            .getCoordinatesFromAddress(
                                            value:
                                            prediction.description!,
                                            isForAddress:
                                            isForAddress!)
                                            .then((value) {
                                          if (isFromHome!) {
                                            Get.offAllNamed('/');
                                          } else {
                                            Get.back();
                                          }
                                        });
                                      }
                                  )


                                  /*TextField(
                                    controller: searchLocationController
                                        .searchController,
                                    focusNode:
                                        searchLocationController.focusNode,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          size: 20,
                                        )),
                                    onChanged: (val) {
                                      searchLocationController
                                          .autoCompleteSearch(searchKey: val);
                                      if (val.length != 0) {
                                        print(val.length);
                                        searchLocationController
                                            .updateNovalue(false);
                                      } else {
                                        print(val.length);
                                        searchLocationController
                                            .updateNovalue(true);
                                      }
                                    },
                                  ),*/
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (isFromHome!) {
                                    Get.offAllNamed('/');
                                  } else {
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  "Cancel",
                                  style: mediumFont(Colors.black),
                                ),
                              )
                            ]))),
                    const SizedBox(
                      height: 10,
                    ),
                    searchLocationController.noValue
                        ? SizedBox(
                            width: Get.width,
                            child: InkWell(
                              onTap: () {
                                Get.find<locationPermissionController>()
                                    .setUserChangedValue(false);
                                Get.find<locationPermissionController>()
                                    .determinePosition(
                                        isforAddress: isForAddress)
                                    .then((value) {
                                  if (isFromHome!) {
                                    Get.offAllNamed('/');
                                  } else {
                                    Get.back();
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_searching_sharp,
                                          size: 25,
                                          color: botAppBarColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Current Location',
                                              style: largeFont(Colors.black),
                                            ),
                                            Text(
                                              'Using GPS',
                                              style: mediumFont(Colors.grey),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    SizedBox(height: searchLocationController.noValue ? 10 : 0),
                    searchLocationController.isLoading
                        ? Center(
                            child: Image.asset(
                              'assets/carSpa/loading.gif',
                              height: 50,
                            ),
                          )
                        : SingleChildScrollView(
                            child: !searchLocationController.noValue
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(top: 0),
                                        shrinkWrap: true,
                                        itemCount: searchLocationController
                                            .predictions.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Text(
                                              searchLocationController
                                                  .predictions[index]
                                                  .description!,
                                              style: mediumFont(Colors.black),
                                            ),
                                            onTap: () {
                                              searchLocationController
                                                  .addToRecentHistory(
                                                      searchLocationController
                                                          .predictions[index]
                                                          .description);
                                              searchLocationController
                                                  .getCoordinatesFromAddress(
                                                      value:
                                                          searchLocationController
                                                              .predictions[
                                                                  index]
                                                              .description!,
                                                      isForAddress:
                                                          isForAddress!)
                                                  .then((value) {
                                                if (isFromHome!) {
                                                  Get.offAllNamed('/');
                                                } else {
                                                  Get.back();
                                                }
                                              });
                                            },
                                          );
                                        }))
                                : searchLocationController
                                        .recentSearchList.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Recent Searches',
                                                  style: largeFont(Colors.grey),
                                                ),
                                                Bouncing(
                                                  onPress: () =>
                                                      searchLocationController
                                                          .clearRecentSearch(),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.red[900],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.grey[200],
                                              thickness: 1,
                                            )
                                          ],
                                        ))
                                    : const SizedBox(),
                          ),
                    searchLocationController.noValue
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.only(top: 0),
                                      shrinkWrap: true,
                                      itemCount: searchLocationController
                                          .recentSearchList.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                            title: Text(
                                              searchLocationController
                                                  .recentSearchList[index],
                                              style: mediumFont(Colors.black),
                                            ),
                                            onTap: () {
                                              searchLocationController
                                                  .addToRecentHistory(
                                                      searchLocationController
                                                              .recentSearchList[
                                                          index]);
                                              searchLocationController
                                                  .getCoordinatesFromAddress(
                                                      value: searchLocationController
                                                              .recentSearchList[
                                                          index],
                                                      isForAddress:
                                                          isForAddress!)
                                                  .then((value) {
                                                if (isFromHome!) {
                                                  Get.offAllNamed('/');
                                                } else {
                                                  Get.back();
                                                }
                                              });
                                            });
                                      })),
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              );
      }),
    );
  }
}
