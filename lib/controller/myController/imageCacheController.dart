import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
// import 'package:path_provider/path_provider.dart';

class ImageCacheController extends GetxController implements GetxService {
  Future clearCache() async {
    imageCache.clear();
    imageCache.clearLiveImages();
    DefaultCacheManager().emptyCache();

    update();
    // final cacheDir = await getTemporaryDirectory();
    // if (cacheDir.existsSync()) {
    //   cacheDir.deleteSync(recursive: true);
    // }
    // deleteAppDir();
  }

  // Future<void> deleteAppDir() async {
  //   final appDir = await getApplicationSupportDirectory();
  //   if (appDir.existsSync()) {
  //     appDir.deleteSync(recursive: true);
  //   }
  //
  // }
}
