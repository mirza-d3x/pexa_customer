import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/authFactorController.dart';
import 'package:shoppe_customer/data/repository/carModelApi.dart';
import 'package:shoppe_customer/data/models/car_model/car_model.dart';
import 'package:shoppe_customer/data/models/car_model/make.dart';
import 'package:shoppe_customer/data/models/car_model/model.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';

class CarModelController extends GetxController implements GetxService {
  final CarModelApi carModelApi;

  var carModel = [].obs;
  List<Model> carModelVarients = [];
  var selectedBrand = 1500.obs;
  var carBrandId = "".obs;
  var carBrandAPIId = "".obs;
  String? carModelId = "";
  var carModelType = "".obs;
  String? carModelName = "";
  String? carBrandName = "";
  List<Make>? brandList = [];
  List<Model>? modelList = [];
  var nullString = "".obs;
  var isMakeSearch = false.obs;
  var isModelSearch = false.obs;
  var noMakeFound = false.obs;
  var noModelFound = false.obs;
  final boxCarDetails = GetStorage();
  LoaderHelper loaderHelper = LoaderHelper();

  CarModelController({required this.carModelApi});

  setSearchClickStatus() {
    isMakeSearch.value = !isMakeSearch.value;
    update();
  }

  setModelSearchClickStatus() {
    isModelSearch.value = !isModelSearch.value;
    update();
  }

  void carBrandsSelected(int index) {
    selectedBrand.value = index;
    update();
  }

  var selectedModel = 1500.obs;

  void carModelSelected(int index) {
    selectedModel.value = index;
    update();
  }

  void carBrandIdChange(String id) {
    carBrandId.value = id;
    update();
  }

  void carModelIdChange(String? id, String type) {
    carModelId = id;
    carModelType.value = type;
    update();
  }

  setAllMakeList(List<Make> makeList) {
    brandList = makeList;
    carModel.value =
        makeList.where((element) => (element.name != 'ALL')).toList();
    update();
  }

  setAllModelList(List<Model> modelList) {
    this.modelList = modelList;
    update();
  }

  @override
  void onInit() {
    if (boxCarDetails.read('carModelName') != null) {
      carModelName = boxCarDetails.read('carModelName');
    }
    if (boxCarDetails.read('carBrandName') != null) {
      carBrandName = boxCarDetails.read('carBrandName');
    }
    super.onInit();
  }

  Future fetchData() async {
    noMakeFound.value = false;
    loaderHelper.startLoader();
    update();
    if (carModel.isNotEmpty) {
      carModel.clear();
    }
    if (modelList!.isEmpty && brandList!.isEmpty) {
      CarModel response = await (carModelApi.fetchAllCarList());
      response.resultData!.makes!
          .removeWhere((element) => element.name == "GENERAL");
      response.resultData!.models!
          .removeWhere((element) => element.name == "GENERAL");
      if (response.status == 'OK') {
        modelList = response.resultData!.models;
        brandList = response.resultData!.makes;
        carModel.value = response.resultData!.makes!
            .toList()
            .where((element) => (element.name != 'ALL'))
            .toList();
        if (carModel.isEmpty) {
          noMakeFound.value = true;
          update();
        } else {
          noMakeFound.value = false;
          update();
        }
        loaderHelper.cancelLoader();
      }
        }
  }
  // Future fetchData() async {
  //   noMakeFound.value = false;
  //   update();
  //   if (carModel.isNotEmpty) {
  //     carModel.clear();
  //   }
  //   // var response = await carModelApi.carBrands();
  //   CarModel response = await carModelApi.fetchAllCarList();
  //   if (response != null) {
  //     if (response.status == 'OK') {
  //       carModel.value = response.resultData.makes
  //           .toList()
  //           .where((element) => (element.name != 'ALL'))
  //           .toList();
  //       if (carModel.length == 0) {
  //         noMakeFound.value = true;
  //         update();
  //       } else {
  //         noMakeFound.value = false;
  //         update();
  //       }
  //     }
  //   } else {
  //     noMakeFound.value = true;
  //     update();
  //   }
  // }

  fetchCarModelDetails(String? id) async {
    if (modelList!.isNotEmpty) {
      late Model carmodelData;
      late Make carBrandData;
      try {
        carmodelData = modelList!.firstWhere((element) => element.id == id);
      } catch (e) {
        print(e);
      }
      carModelName = carmodelData.name;
      boxCarDetails.write("carModelName", carModelName);
      update();
      try {
        carBrandData = brandList!
            .firstWhere((element) => element.id == carmodelData.makeId);
      } catch (e) {
        print(e);
      }
      carBrandName = carBrandData.name;
      boxCarDetails.write("carBrandName", carBrandName);
      update();
    } else {
      fetchData().then((value) =>
          fetchCarModelDetails(Get.find<AuthFactorsController>().carModel));
    }
    // var res = await carModelApi.fetchCarModelDetail(id);
    // if (res != null) {
    //   carModelName = res['resultData']['name'];
    //   boxCarDetails.write("carModelName", carModelName);
    //   update();
    //   if (res != null) {
    //     if (res['status'] == 'OK') {
    //       var response = await carModelApi
    //           .fetchCarBrandDetail(res['resultData']['make_id'].toString());
    //       if (response != null) {
    //         carBrandName = response['resultData']['name'];
    //         boxCarDetails.write("carBrandName", carBrandName);
    //         update();
    //       }
    //       update();
    //     }
    //   }
    // }
  }

  Future fetchCarModelVarients(String id) async {
    noModelFound.value = false;
    update();
    if (carModelVarients.isNotEmpty) {
      carModelVarients.clear();
    }
    carBrandAPIId.value = id;
    update();
    if (modelList != null && modelList!.isNotEmpty) {
      fetchCarModelVarientFromList(id);
      noModelFound.value = false;
    } else {
      Response response = (await carModelApi.fetchCarModels(id))!;
      if (response.isOk) {
        carModelVarients.clear();
        modelList!.clear();
        response.body['resultData'].forEach((element) {
          if (element['name'] != "GENERAL") {
            carModelVarients.add(Model.fromJson(element));
            modelList!.add(Model.fromJson(element));
          }
        });
        if (carModelVarients.isEmpty) {
          noModelFound.value = true;
          update();
        } else {
          noModelFound.value = false;
          update();
        }
      }
    }
  }

  fetchCarModelVarientFromList(String brandId) {
    carModelVarients = [];
    for (var element in modelList!) {
      if (element.makeId == brandId) {
        carModelVarients.add(element);
      }
    }
  }

  Future<void> searchBrand(String value) async {
    noMakeFound.value = false;
    update();
    if (value == '') {
      fetchData();
    } else {
      if (carModel.isNotEmpty) {
        carModel.clear();
      }
      var response = (await carModelApi.carBrands())!;
      if (response.status == 'OK') {
        carModel.value = response.resultData!
            .toList()
            .where((element) =>
                (element.name!.startsWith(value)) && (element.name != 'ALL'))
            .toList();
        if (carModel.isEmpty) {
          noMakeFound.value = true;
          update();
        } else {
          noMakeFound.value = false;
          update();
        }
      }
    }
  }

  Future<void> searchModel(String value, String id) async {
    noModelFound.value = false;
    update();
    if (value == '') {
      fetchCarModelVarients(id);
    } else {
      if (carModelVarients.isNotEmpty) {
        carModelVarients.clear();
        update();
      }
      if (modelList != null && modelList!.isNotEmpty) {
        carModelVarients.clear();
        update();
        for (var element in modelList!) {
          if (element.makeId == id && element.name!.contains(value)) {
            carModelVarients.add(element);
          }
        }
        update();
      } else {
        var response = (await carModelApi.fetchCarModels(id))!;
        if (response.statusText == "OK") {
          carModelVarients.clear();
          update();
          response.body['resultData'].forEach((element) {
            if (Model.fromJson(element).name!.startsWith(value)) {
              carModelVarients.add(Model.fromJson(element));
            }
          });
          if (carModelVarients.isEmpty) {
            noModelFound.value = true;
            update();
          } else {
            noModelFound.value = false;
            update();
          }
        }
      }
    }
  }
}
