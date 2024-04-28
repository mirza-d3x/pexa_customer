import 'package:get/get.dart';
import 'package:shoppe_customer/data/models/service_model.dart';

class WishListController extends GetxController implements GetxService {
  final _servicess = {}.obs;
  void addTowishlist(ServiceId services) {
    if (_servicess.containsKey(services)) {
      _servicess[services]+=1;
    }else{
      _servicess[services]=1;
    }
  }
}
