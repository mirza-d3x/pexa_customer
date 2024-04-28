import 'package:shoppe_customer/data/repository/productApi.dart';
import 'package:shoppe_customer/controller/myController/categoryController.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/search_api.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/data/models/carShoppe/searchModel.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class ShoppeSearchController extends GetxController implements GetxService {
  List<SearchResultData>? _totalSearchProductList;
  List<SearchResultData>? _showingSearchProductList;
  final List<double> _allPrices = [];
  ProductAPI? productAPI;
  final SearchRepo searchRepo;
  int? totalPages = 1;
  var currentPage = 1;
  LoaderHelper loaderHelper = LoaderHelper();
  double _maxPrice = 0;
  bool isFilterApplied = false;

  ShoppeSearchController({required this.searchRepo});
  bool _isSearchMode = true;
  bool _searchListHasExpanded = false;
  final List<String> _sortList = ['ascending'.tr, 'descending'.tr];
  int _sortIndex = -1;
  List<String> _historyList = [];
  String _searchText = '';
  double _lowerValue = 0;
  double _upperValue = 0;

  bool get isSearchMode => _isSearchMode;
  List<String> get historyList => _historyList;
  List<String> get sortList => _sortList;
  int get sortIndex => _sortIndex;
  String get searchText => _searchText;
  double get lowerValue => _lowerValue;
  bool get searchListHasExpanded => _searchListHasExpanded;
  double get upperValue => _upperValue;
  double get maxPrice => _maxPrice;
  List<double> get allPrices => _allPrices;
  List<SearchResultData>? get totalSearchProductList => _totalSearchProductList;
  List<SearchResultData>? get showingSearchProductList =>
      _showingSearchProductList;


  void setSearchText(String text) {
    _searchText = text;
    update();
  }

  void setSearchMode(bool isSearchMode) {
    _isSearchMode = isSearchMode;
    if (isSearchMode) {
      _searchText = '';
      _sortIndex = -1;
    }
    update();
  }

  setFilterStatus(bool status) {
    isFilterApplied = status;
    update();
  }

  Future searchProducts({int pageNo = 1}) async {
    String query = _searchText;
    if (pageNo == 1) {
      loaderHelper.startLoader();
      _showingSearchProductList = [];
      _totalSearchProductList = [];
      _searchListHasExpanded = false;
      update();
    } else {
      _searchListHasExpanded = true;
      update();
    }
    currentPage = pageNo;
    _isSearchMode = false;
    update();
    if (Get.find<ProductCategoryController>().productLocationList.isNotEmpty) {
      var response = await searchRepo.searchProduct(
          data: Get.find<ProductCategoryController>().productLocationList,
          value: query,
          page: pageNo.toString());

      if (response.body['resultData'] != null) {
        List<SearchResultData> temp = [];
        totalPages = response.body['totalPages'];
        response.body['resultData'].forEach((element) {
          temp.add(SearchResultData.fromJson(element));
        });
        // searchResultList = response.body['resultData'];
        if (pageNo == 1) {
          _totalSearchProductList!.clear();
          _totalSearchProductList!.addAll(temp);
          setRanger();
          _showingSearchProductList = totalSearchProductList;
        } else {
          for (var element in temp) {
            _totalSearchProductList!.add(element);
          }
          setRanger();
          sortSearchList();
        }
      }
      loaderHelper.cancelLoader();
      update();
    } else {
      showCustomSnackBar("Please set a location",
          title: "Error", isError: true);
    }
  }

  void setLowerAndUpperValue(double lower, double upper) {
    _lowerValue = lower;
    _upperValue = upper;
    update();
  }

  void sortSearchList() {
    List<SearchResultData> temp = [];
    temp.addAll(totalSearchProductList!);
    if (_upperValue > 0 && isFilterApplied) {
      temp.removeWhere((product) =>
          product.offerPrice! <= _lowerValue ||
          product.offerPrice! > _upperValue);
      if (temp.length <= 10 && currentPage <= totalPages!) {
        searchProducts(pageNo: currentPage + 1)
            .then((value) => sortSearchList());
      }
      _showingSearchProductList = [];
      showingSearchProductList!.addAll(temp);
      update();
    }
    // if(_rating != -1) {
    //   _tempSearchProductList.removeWhere((product) => product.avgRating < _rating);
    // }
    // if(!_veg && _nonVeg) {
    //   _tempSearchProductList.removeWhere((product) => product.veg == 1);
    // }
    // if(!_nonVeg && _veg) {
    //   _tempSearchProductList.removeWhere((product) => product.veg == 0);
    // }
    // if(_isAvailableFoods || _isDiscountedFoods) {
    //   if(_isAvailableFoods) {
    //     _tempSearchProductList.removeWhere((product) => !DateConverter.isAvailable(product.availableTimeStarts, product.availableTimeEnds));
    //   }
    //   if(_isDiscountedFoods) {
    //     _tempSearchProductList.removeWhere((product) => product.discount == 0);
    //   }
    // }
    if (_sortIndex != -1) {
      if (_sortIndex == 0) {
        _showingSearchProductList!.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      } else {
        _showingSearchProductList!.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        Iterable iterable = _showingSearchProductList!.reversed;
        _showingSearchProductList = iterable.toList() as List<SearchResultData>?;
      }
    }
    update();
  }

  setRanger() {
    _allPrices.clear();
    for (var product in totalSearchProductList!) {
      _allPrices.add(double.parse(product.offerPrice.toString()));
    }
    _allPrices.sort();
    _maxPrice =
        _allPrices.isNotEmpty ? _allPrices[_allPrices.length - 1] : 1000;
    update();
  }

  clearList() {
    if (_showingSearchProductList != null) {
      _showingSearchProductList!.clear();
    }
    if (_totalSearchProductList != null) {
      _totalSearchProductList!.clear();
    }
    update();
  }

  void saveSearchHistory(String query) {
    if (!_historyList.contains(query)) {
      _historyList.insert(0, query);
    }
    searchRepo.saveSearchHistory(_historyList);
  }

  void getHistoryList() {
    _searchText = '';
    _historyList = [];
    for (var element in searchRepo.getSearchAddress()!) {
      _historyList.add(element);
    }
  }

  void removeHistory(int index) {
    _historyList.removeAt(index);
    searchRepo.saveSearchHistory(_historyList);
    update();
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchHistory();
    _historyList = [];
    update();
  }

  void setSortIndex(int index) {
    _sortIndex = index;
    update();
  }

  void resetFilter() {
    _sortIndex = -1;
    _upperValue = 0;
    _lowerValue = 0;
    sortSearchList();
    setFilterStatus(false);
    _showingSearchProductList = totalSearchProductList;
    update();
  }

  @override
  void dispose() {
    clearList();
    update();
    super.dispose();
  }
}
