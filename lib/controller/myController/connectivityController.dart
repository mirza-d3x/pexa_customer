import 'package:get/get.dart';
import 'package:shoppe_customer/data/repository/server_api.dart';
import 'package:shoppe_customer/data/models/initial_data_model/initial_data_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController implements GetxService {
  var status = true;
  late var subscription;
  var serverEnabled = false;
  bool isOnline = false;
  final ServerApi serverApi;

  ConnectivityController({required this.serverApi});

  InitialDataModel? initialDataModel;

  @override
  void onInit() {
    networkCheck();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      networkCheck();
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  networkCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      serverStatus();
      status = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      serverStatus();
      status = true;
    } else if (connectivityResult == ConnectivityResult.none) {
      status = false;
    }
    update();
  }

  serverStatus() async {
    var response = await serverApi.checkServer();
    if (response != null &&
        response.isNotEmpty &&
        response[0].rawAddress.isNotEmpty) {
      // if (Get.find<AuthFactorsController>().isLoggedIn.value) {
      //   getInitialData();
      // }
      return serverEnabled;
    } else {
      serverEnabled = false;
      update();
      return serverEnabled;
    }
  }

  Future getInitialData() async {
    Response res = (await serverApi.initialDatas())!;
    if (res.statusCode == 200) {
      serverEnabled = true;
      update();
      initialDataModel = InitialDataModel.fromJson(res.body);
      return serverEnabled;
    } else {
      serverEnabled = false;
      update();
      return serverEnabled;
    }
  }
}
