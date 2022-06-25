import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/controllers/village_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/village.dart';

class VillageDAO extends ChangeNotifier {
  List<Village> _villages = [];

  VillageDAO() {
    initData();
  }

  List<Village> get villages => _villages;

  initData() async {
    SecureStorage _secureStorage = SecureStorage();
    String? _token = await _secureStorage.read('token');

    if (_token != null) {
      Box _mosqueBox = await Hive.openBox('mosque');
      Box _villageBox = await Hive.openBox('village');

      String? mosqueID = (_mosqueBox.get(_token) as Mosque).id;

      if (_villageBox.get(mosqueID) != null) {
        List<Village>? villages = _villageBox.get(mosqueID).cast<Village>();
        if (villages != null) {
          _villages = villages;
          log('from cache');
          notifyListeners();
        }
      }
      getLatestData(mosqueID!);
    }
  }

  getLatestData(String mosqueID) async {
    List<Village> data = await VillageController.getVillages(mosqueID);

    Box _villageBox = await Hive.openBox('village');
    _villageBox.put(mosqueID, data);
    log('from db');
    _villages = data;
    notifyListeners();
  }

  Future<dynamic> addVillage(String mosqueID, Village village) async {
    dynamic data = await VillageController.addVillage(mosqueID, village);

    if (data != null) {
      _villages.add(data);
      log('added');
      notifyListeners();
      return data;
    }

    return null;
  }

  Future<bool> editVillage(Village village) async {
    dynamic data = await VillageController.editVillage(village);

    if (data != null) {
      int index = _villages.indexWhere((vil) => vil.id == village.id);
      log('index $index');
      villages[index] = village;
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> deleteVillage(Village village) async {
    bool res = await VillageController.deleteVillage(village);

    if (res) {
      _villages.remove(village);
      notifyListeners();

      return true;
    }

    return false;
  }

  // Caught exception purpose
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
