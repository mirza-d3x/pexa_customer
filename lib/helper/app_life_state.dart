import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppe_customer/controller/myController/notificationController.dart';

class LifeCycle extends StatefulWidget {
  final Widget child;
  const LifeCycle({super.key, required this.child});
  @override
  _LifeCycleState createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> with WidgetsBindingObserver {
  late DateTime _startTime;
  late Timer _reportClicks;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _startTime = DateTime.now();
    // _reportClicks = Timer.periodic(
    //     Duration(seconds: 10), (_) => _reportClicksToServer(Counter().value));
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _reportClicks.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _reportData(DateTime.now().difference(_startTime));
        return;
      case AppLifecycleState.resumed:
        _startTime = DateTime.now();
        Get.find<NotificationController>().manageBackgroundNotification();
        return;
      default:
        return;
    }
  }
}

void _reportData(Duration time) {
  print("used app for ${time.inSeconds} seconds");
}

void _reportClicksToServer(int value) {
  print("clicked on the counter $value times");
}

class Counter {
  static final Counter _instance = Counter._internal();
  factory Counter() => _instance;
  Counter._internal();

  int _value = 0;

  void increment() {
    _value++;
  }

  int get value => _value;
}
