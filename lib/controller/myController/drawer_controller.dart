import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationDrawerController extends GetxController implements GetxService {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }
}
