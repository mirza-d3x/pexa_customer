import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  // A map to keep track of opened boxes
  final Map<String, Box> _openedBoxes = {};

  // Register Adapter
  Future<void> registerAdapters(TypeAdapter adapter) async {
    log("Adapter registered");
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter(adapter);
    }
  }

  // init Hive flutter
  Future<void> initHive() async {
    log("Hive Initializing");
    await Hive.initFlutter();
  }

  // Generic method to add data to a box
  Future<void> saveData<T>(String boxName, T data) async {
    final box = await _getOpenBox(boxName);

    // Check if the data already exists in the box
    final existingData =
        await box.values.firstWhere((element) => element == data);
    if (existingData != null) {
      log("Data already exists in $boxName");
      return; // Exit the function if data already exists
    }

    await box.add(data); // Add data to the box
    log("$data added to $boxName");
  }

  // Generic method to get data from a box
  Future<T?> getData<T>(String boxName, dynamic key) async {
    final box = await _getOpenBox(boxName);
    return box.get(key); // Get data from the box
  }

  // Generic method to get all data from a box
  Future<List> getAllData<T>(String boxName) async {
    final box = await _getOpenBox(boxName);
    return box.values.toList();
  }

  // Generic method to update data in a box
  Future<void> updateData<T>(String boxName, dynamic key, T data) async {
    final box = await _getOpenBox(boxName);
    await box.put(key, data); // Update data in the box
  }

  Future<void> updateAllData<T>(String boxName, List<T> newData) async {
    final box = await _getOpenBox(boxName);
    await box.clear(); // Clear all existing data in the box
    await box.addAll(newData); // Add all new data to the box
    log("All data updated in $boxName");
  }

  // Method to delete data from a box
  Future<void> deleteData(String boxName, dynamic key) async {
    final box = await _getOpenBox(boxName);
    await box.delete(key); // Delete data from the box
  }

  // Method to open a box
  Future<Box<T>> _getOpenBox<T>(String boxName) async {
    if (_openedBoxes.containsKey(boxName)) {
      // If box is already open, return the opened box
      return _openedBoxes[boxName]! as Box<T>;
    } else {
      // If box is not open, open it and store it in the map
      final box = await Hive.openBox<T>(boxName);
      _openedBoxes[boxName] = box;
      log("Hive Box opened : $boxName");
      return box;
    }
  }

  // Method to close a box
  Future<void> closeBox(String boxName) async {
    if (_openedBoxes.containsKey(boxName)) {
      // If box is open, close it and remove from the map
      await _openedBoxes[boxName]!.close();
      _openedBoxes.remove(boxName);
      log("Hive Box closed : $boxName");
    }
  }

  // Method to check if a box is open
  bool isBoxOpen(String boxName) => _openedBoxes.containsKey(boxName);
}
