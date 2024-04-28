import 'package:get/get.dart';

class ExpandableListController extends GetxController implements GetxService {
  var isOpen = false.obs;

  setState(bool bool) {
    isOpen.value = bool;
    update();
  }
}
