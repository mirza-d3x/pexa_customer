import 'dart:async';
import 'dart:convert';

import 'package:shoppe_customer/data/api/api_client.dart';
import 'package:shoppe_customer/data/repository/authApi.dart';
import 'package:shoppe_customer/controller/myController/addressController.dart';
import 'package:shoppe_customer/controller/myController/carModelController.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shoppe_customer/helper/loader_helper.dart';
import 'package:shoppe_customer/data/models/address_model.dart';
import 'package:shoppe_customer/data/models/user/userDetails.dart';
import 'package:shoppe_customer/util/app_constants.dart';
import 'package:shoppe_customer/view/base/custom_snackbar.dart';

class AuthFactorsController extends GetxController implements GetxService {
  var token = ''.obs;
  var userId = ''.obs;
  var isLoggedIn = false.obs;
  var phoneNumber = ''.obs;
  var phoneNumberState = "".obs;
  final boxUser = GetStorage();
  var passwordState = "".obs;
  var timerCount = 30.obs;
  var timeStarted = false.obs;
  final AuthApi authApi;
  final boxToken = GetStorage();
  LoaderHelper loaderHelper = LoaderHelper();

  var isMIdAvailable = false;
  final bool _isUpdate = true;
  var _mailUpdated = false;
  User? userDetails;
  var _carModel;
  var _carModelName;
  var _carBrandName;
  var setUserName;
  var _userPhone;

  get isUpdate => _isUpdate;
  get mailUpdated => _mailUpdated;
  get carModel => _carModel;
  get carModelName => _carModelName;
  get carBrandName => _carBrandName;
  get userName => setUserName;
  get userPhone => _userPhone;

  AuthFactorsController({required this.authApi});

  @override
  void onInit() {
    super.onInit();
    if(boxUser.read("isLogged")!=null){
      isLoggedIn.value = boxUser.read("isLogged");
      token.value = boxUser.read("userToken");
     userId.value = boxUser.read("userId");
     phoneNumber.value = boxUser.read("phone");
    }
    //token.value = boxUser.read('userToken');

  

    //userId.value = boxUser.read('userId');
    // print("=========== ${userId.value}");
    // phoneNumber.value =
    //     boxUser.read('phone') != null ? boxUser.read('phone') : null;
    //
    // isLoggedIn.value = false;
    //
    // if (boxUser.read('userName') != null) {
    //   setUserName = boxUser.read('userName');
    // }
    // if (boxUser.read('userPhone') != null) {
    //   _userPhone = boxUser.read('userPhone');
    // }
  }

  updateLoadingStatus(bool status) {
    loaderHelper.isLoading = status;
    update();
  }

  timerReset() {
    timeStarted.value = false;
    timerCount.value = 0;
    update();
  }

  setMIDValue(bool status) {
    isMIdAvailable = status;
    update();
  }

  setCarType() {
    userDetails =
        User(carType: Get.find<CarModelController>().carModelType.value);
    // userDetails.carType = Get.find<CarModelController>().carModelType.value;
    update();
  }

  Future saveUserToken(String? token, bool isUser) async {
    boxUser.write("userToken", token);
    boxUser.write("isLogged", isUser);
    isLoggedIn.value = isUser;
    update();
  }

  Future saveUserId(String? userId, bool isUser) async {
    boxUser.write("userId", userId);
    isLoggedIn.value = isUser;
    update();
  }

  Future savePhone(String? phoneNumber, bool isUser) async {
    boxUser.write("phone", phoneNumber);
    isLoggedIn.value = isUser;
    update();
  }

  Future<bool> logOut() async {
    boxUser.remove("userToken");
    boxUser.remove("userId");
    boxUser.remove("userName");
    boxUser.remove("phone");
    boxUser.remove("userPhone");
    boxUser.remove("isLogged");
    isLoggedIn.value = false;
    boxToken.erase();
    boxUser.erase();
    userDetails = User();
    update();

    Get.find<CarModelController>().carModelName = "";
    Get.find<CarModelController>().carBrandName = "";
    isMIdAvailable = false;
    if (Get.find<AddressControllerFile>().addressList != null) {
      Get.find<AddressControllerFile>().addressList!.clear();
    }
    Get.find<AddressControllerFile>().defaultAddress = Address();
    return true;
  }

  Future login({String? phone}) async {
    startTimer();
    loaderHelper.startLoader(countDown: 30);
    update();
    Response response = await authApi.login(phone: phone);
    if (response.statusCode == 200) {
      if (response.body['status'] == "OK") {
        phoneNumberState.value = '';
      } else {
        phoneNumberState.value = 'Invalid Number';
      }
    } else {
      phoneNumberState.value = 'Invalid Number';
    }
    loaderHelper.cancelLoader();
    update();
  }

  Timer? time;

  Future startTimer() async {
    timeStarted.value = true;
    timerCount.value = 30;
    update();
    const oneSec = Duration(seconds: 1);
    time = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount.value == 0) {
          timeStarted.value = false;
          update();
          timer.cancel();
        } else {
          timerCount.value--;
          update();
        }
      },
    );
  }

  var otpVerified = false.obs;
  final box = GetStorage();

  Future verifyOTP({String? phone, String? otp}) async {
    loaderHelper.isLoading = true;
    update();
    Response response = await authApi.verifyOTP(phone: phone, otp: otp);
print("HI iam !!!!!");
    if ((response.statusCode == 200) || (response.statusCode == 201)) {
      print("Response!!! ${response.body['status']}");
      if (response.body['status'] == "OK") {
        passwordState.value = '';
        token.value = response.body['resultData']['userToken'].toString();
        boxToken.write(
            'userToken', response.body['resultData']['userToken'].toString());
        Get.find<ApiClient>().updateHeader(
            response.body['resultData']['userToken'].toString(),
            box.read(AppConstants.LANGUAGE_CODE));

        userId.value = response.body['resultData']['_id'].toString();
        phoneNumber.value = response.body['resultData']['phone'].toString();
        isLoggedIn.value = true;
        await saveUserToken(response.body['resultData']['userToken'], true)
            .then((value) =>
                saveUserId(response.body['resultData']['_id'], true).then(
                    (value) =>
                        savePhone(response.body['resultData']['phone'], true)));
        otpVerified(true);
        update();
        print("vyshnavv!!!! :${Get.find<AuthFactorsController>().isLoggedIn.value}");
        return response.body;
      } else {
        otpVerified(false);
        passwordState.value = 'Invalid OTP';
        update();
      }
    } else {
      return json.decode(response.bodyString!);
    }
    loaderHelper.isLoading = false;
    update();
  }

  setUserDetails(User? user) {
    userDetails = user;
    if (user != null) {
      updateUserModelId(userDetails!.modelId, userDetails!.carType);
    }
    update();
  }

  Future getUserDetails() async {
    Response response = await authApi.fetchUserDetails(box.read('userId'));
    if (response.isOk) {
      if (response.statusCode != 1) {
        userDetails = UserDetails.fromJson(response.body).resultData;
        setUserName = userDetails!.name;
        _userPhone = userDetails!.phone;
        boxUser.write("userName", setUserName);
        boxUser.write("userPhone", _userPhone);
        Get.find<AddressControllerFile>().setAddressList(userDetails!.addresses);
        if (userDetails!.email != null && userDetails!.email!.isNotEmpty) {
          _mailUpdated = true;
        }
        if (userDetails!.modelId.toString() != 'null') {
          isMIdAvailable = true;
          _carModel = userDetails!.modelId.toString();
          Get.find<CarModelController>().fetchCarModelDetails(_carModel);
        }

        update();
        return response;
      }
    } else {
      showCustomSnackBar(response.statusText, isError: true, title: "Error");
      return response;
    }
  }

  Future updateUserModelId(String? modelId, String? carType) async {
    if (userDetails != null) {
      var response = await authApi.addModelIdToProfile(modelId, carType);
      if (response != null) {
        _carModel = modelId;
        isMIdAvailable = true;
        Get.find<CarModelController>().fetchCarModelDetails(carModel);
        update();

        // showCustomSnackBar('Your Car Model Updated',
        //     title: 'Success', isError: false);
      }
    } else {
      _carModel = modelId;
      Get.find<CarModelController>().fetchCarModelDetails(carModel);
      update();
    }
  }

  Future updateUserDetails(String email, String name) async {
    var response = await authApi.updateDetailsUser(email, name, userDetails!.id!);
    if (response.body['status'] == 'OK') {
      box.write('userName', name);
      userDetails!.name = name;
      setUserName = name;
      userDetails!.email = email;
      update();
      showCustomSnackBar(response.body['message'].toString(),
          title: 'Success', isError: false);
      return true;
    } else if (response.body['status'] == 'Failed') {
      showCustomSnackBar(response.body['message'].toString(),
          title: 'Error', isError: true);
      return false;
    }
    }

  updateUserLocation(String? locationData) async {
    var response =
        await authApi.updateUserLocation(locationData, userDetails!.id!);
    if (response.body['status'] == 'OK') {}
  }
}
