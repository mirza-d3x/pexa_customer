import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class LoaderHelper implements GetxController {
  bool isLoading = false;
  Timer? _timer;

  void startLoader({int countDown = 10}) {
    isLoading = true;
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (isLoading == true && countDown == 0) {
          cancelLoader();
        } else {
          countDown--;
        }
      },
    );
  }

  cancelLoader() {
    isLoading = false;
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  void $configureLifeCycle() {
    // TODO: implement $configureLifeCycle
  }

  @override
  Disposer addListener(GetStateUpdate listener) {
    // TODO: implement addListener
    throw UnimplementedError();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void disposeId(Object id) {
    // TODO: implement disposeId
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  // TODO: implement initialized
  bool get initialized => throw UnimplementedError();

  @override
  // TODO: implement isClosed
  bool get isClosed => throw UnimplementedError();

  @override
  // TODO: implement listeners
  int get listeners => throw UnimplementedError();

  @override
  void notifyChildrens() {
    // TODO: implement notifyChildrens
  }

  @override
  void onClose() {
    // TODO: implement onClose
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => throw UnimplementedError();

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void onReady() {
    // TODO: implement onReady
  }

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => throw UnimplementedError();

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  void refreshGroup(Object id) {
    // TODO: implement refreshGroup
  }

  @override
  void removeListener(VoidCallback listener) {
    // TODO: implement removeListener
  }

  @override
  void removeListenerId(Object id, VoidCallback listener) {
    // TODO: implement removeListenerId
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
  }

  @override
  Disposer addListenerId(Object? key, GetStateUpdate listener) {
    // TODO: implement addListenerId
    throw UnimplementedError();
  }
}
