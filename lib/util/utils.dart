import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

Future<void> checkForUpdate() async {
  try {
    final info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      _showUpdateDialog(info); // Handle update availability here (custom logic)
    }
  } catch (error, stackTrace) {
    log("Error while checking update", error: error, stackTrace: stackTrace);
  }
}

void _showUpdateDialog(AppUpdateInfo info) {
  showDialog(
    context: Get.context!,
    builder: (context) => AlertDialog(
      title: const Text('Update Available'),
      content: Text(
          'A new version (v${info.availableVersionCode}) is available. Would you like to update now?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Later',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () => InAppUpdate.performImmediateUpdate(),
          child: const Text(
            'Update Now',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
