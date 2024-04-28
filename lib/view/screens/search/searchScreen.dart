import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shoppe_customer/util/dimensions.dart';
import 'package:shoppe_customer/util/new_fonts.dart';
import 'package:shoppe_customer/controller/myController/shoppeSearchController.dart';
import 'package:shoppe_customer/util/styles.dart';
import 'package:shoppe_customer/view/base/custom_button.dart';
import 'package:shoppe_customer/view/screens/search/widget/filter_widget.dart';
import 'package:shoppe_customer/view/screens/search/widget/searchItemTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/view/screens/search/widget/search_field.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    Get.find<ShoppeSearchController>().getHistoryList();
  }

  void _loadData(bool loadMore) async {
    int pageNo = Get.find<ShoppeSearchController>().currentPage;
    if (loadMore && Get.find<ShoppeSearchController>().totalPages! >= pageNo) {
      pageNo++;
      Get.find<ShoppeSearchController>()
          .searchProducts(pageNo: pageNo)
          .then((value) => _refreshController.loadComplete());
    }
    if (Get.find<ShoppeSearchController>().totalPages == pageNo) {
      _refreshController.loadNoData();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<ShoppeSearchController>().isSearchMode) {
          Get.find<ShoppeSearchController>().setSearchMode(true);
          return true;
        } else {
          searchTextEditingController.text = "";
          Get.find<ShoppeSearchController>().setSearchMode(true);
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
              child: GetBuilder<ShoppeSearchController>(
                  builder: (searchController) {
                return Column(
                  children: [
                    Center(
                        child: SizedBox(
                            width: Dimensions.WEB_MAX_WIDTH,
                            child: Row(children: [
                              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                              Expanded(
                                  child: SearchField(
                                controller: searchTextEditingController,
                                hint: 'Search Products',
                                suffixIcon: !searchController.isSearchMode
                                    ? Icons.filter_list
                                    : Icons.search,
                                iconPressed: () =>
                                    _actionSearch(searchController, false),
                                onSubmit: (text) {
                                  _actionSearch(searchController, true);
                                  searchController.saveSearchHistory(text);
                                },
                                onChanged: (value) {
                                  if (searchController.searchText != value) {
                                    _actionSearch(searchController, true);
                                  }
                                  if (value == "") {
                                    searchController.clearList();
                                    searchController.setSearchMode(true);
                                  }
                                },
                              )),
                              CustomButton(
                                onPressed: () {
                                  if (searchController.isSearchMode) {
                                    Get.back();
                                    searchTextEditingController.text = "";
                                    searchController.setSearchText("");
                                  } else {
                                    searchTextEditingController.text = "";
                                    searchController.setSearchMode(true);
                                  }
                                },
                                buttonText: 'cancel'.tr,
                                transparent: true,
                                width: 80,
                              ),
                            ]))),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: searchController.isSearchMode
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.PADDING_SIZE_SMALL),
                                child: Center(
                                    child: SizedBox(
                                        width: Dimensions.WEB_MAX_WIDTH,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              searchController
                                                          .historyList.isNotEmpty
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                          Text('history'.tr,
                                                              style: robotoMedium
                                                                  .copyWith(
                                                                      fontSize:
                                                                          Dimensions
                                                                              .fontSizeLarge)),
                                                          InkWell(
                                                            onTap: () =>
                                                                searchController
                                                                    .clearSearchAddress(),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          Dimensions
                                                                              .PADDING_SIZE_SMALL,
                                                                      horizontal:
                                                                          4),
                                                              child: Text(
                                                                  'clear_all'
                                                                      .tr,
                                                                  style: robotoRegular
                                                                      .copyWith(
                                                                    fontSize:
                                                                        Dimensions
                                                                            .fontSizeSmall,
                                                                    color: Theme.of(
                                                                            context)
                                                                        .disabledColor,
                                                                  )),
                                                            ),
                                                          ),
                                                        ])
                                                  : const SizedBox(),
                                              ListView.builder(
                                                itemCount: searchController
                                                            .historyList.isNotEmpty
                                                    ? searchController
                                                                .historyList
                                                                .length >
                                                            5
                                                        ? 5
                                                        : searchController
                                                            .historyList.length
                                                    : searchController
                                                        .historyList.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Column(children: [
                                                    Row(children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            searchTextEditingController
                                                                    .text =
                                                                searchController
                                                                        .historyList[
                                                                    index];
                                                            searchController
                                                                .setSearchText(
                                                                    searchTextEditingController
                                                                        .text
                                                                        .trim());
                                                            if (searchTextEditingController
                                                                    .text
                                                                    .trim() !=
                                                                "") {
                                                              searchController
                                                                  .searchProducts(
                                                                      pageNo:
                                                                          1);
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        Dimensions
                                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                            child: Text(
                                                              searchController
                                                                      .historyList[
                                                                  index],
                                                              style: robotoRegular.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .disabledColor),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () =>
                                                            searchController
                                                                .removeHistory(
                                                                    index),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      Dimensions
                                                                          .PADDING_SIZE_EXTRA_SMALL),
                                                          child: Icon(
                                                              Icons.close,
                                                              color: Theme.of(
                                                                      context)
                                                                  .disabledColor,
                                                              size: 20),
                                                        ),
                                                      )
                                                    ]),
                                                    index !=
                                                            searchController
                                                                    .historyList
                                                                    .length -
                                                                1
                                                        ? const Divider()
                                                        : const SizedBox(),
                                                  ]);
                                                },
                                              ),
                                              const SizedBox(
                                                  height: Dimensions
                                                      .PADDING_SIZE_LARGE),
                                            ]))),
                              )
                            : Expanded(
                                child: searchController
                                        .showingSearchProductList!.isEmpty
                                    ? searchController.loaderHelper.isLoading
                                        ? Center(
                                            child: SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: LoadingAnimationWidget
                                                  .twistingDots(
                                                leftDotColor:
                                                    const Color(0xFF4B4B4D),
                                                rightDotColor:
                                                    const Color(0xFFf7d417),
                                                size: 50,
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              "Nothing to Display",
                                              style: mediumFont(Colors.black),
                                            ),
                                          )
                                    : SmartRefresher(
                                        controller: _refreshController,
                                        enablePullDown: false,
                                        enablePullUp: true,
                                        onLoading: () => _loadData(true),
                                        footer: CustomFooter(
                                          builder: (BuildContext context,
                                              LoadStatus? mode) {
                                            Widget body;
                                            if (mode == LoadStatus.idle) {
                                              body = const Text(
                                                  "pull up to load more...");
                                            } else if (mode ==
                                                LoadStatus.loading) {
                                              body =
                                                  const CupertinoActivityIndicator();
                                            } else if (mode ==
                                                LoadStatus.failed) {
                                              body = const Text(
                                                  "Load Failed!Click retry!");
                                            } else if (mode ==
                                                LoadStatus.canLoading) {
                                              body =
                                                  const Text("release to load more");
                                            } else {
                                              body = const Text("No more Data");
                                            }
                                            return SizedBox(
                                              height: 55.0,
                                              child: Center(child: body),
                                            );
                                          },
                                        ),
                                        child: GridView.builder(
                                          // physics: NeverScrollableScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 1.0,
                                          ),
                                          itemCount: searchController
                                              .showingSearchProductList!.length,
                                          itemBuilder: (context, index) {
                                            return SizedBox(
                                              child: SearchItemTile(
                                                  searchResultData: searchController
                                                          .showingSearchProductList![
                                                      index]),
                                            );
                                          },
                                        ),
                                      ),
                              ))
                  ],
                );
              })),
        ),
      ),
    );
  }

  void _actionSearch(ShoppeSearchController searchController, bool isSubmit) {
    if (searchController.isSearchMode || isSubmit) {
      if (searchTextEditingController.text.trim().isNotEmpty &&
          searchTextEditingController.text.trim() != "") {
        searchController.setSearchText(searchTextEditingController.text.trim());
        searchController.searchProducts(pageNo: 1);
      } else {
        searchController.clearList();
        searchController.setSearchMode(true);
      }
    } else {
      Get.dialog(const FilterWidget());
    }
  }
}
