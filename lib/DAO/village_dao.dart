import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/village_controller.dart';
import 'package:my_khairat_admin/models/village.dart';

class VillageDAO extends ChangeNotifier {
  List<Village> _villages = [];

  VillageDAO(String mosqueID) {
    initData(mosqueID);
  }

  get villages => _villages;

  initData(String mosqueID) async {
    List<Village> data = await VillageController.getVillages(mosqueID);

    _villages = data;
    notifyListeners();
  }

  addVillage(String mosqueID, Village village) async {
    dynamic data = await VillageController.addVillage(mosqueID, village);

    if (data != null) {
      _villages.add(data);
      notifyListeners();
    }
  }

  editVillage(Village village) async {
    dynamic data = await VillageController.editVillage(village);

    if (data != null) {
      int index = _villages.indexWhere((vil) => vil.id == village.id);
      villages[index] = village;
      notifyListeners();
    }
  }

  deleteVillage(Village village) async {
    bool res = await VillageController.deleteVillage(village);

    if (res) {
      _villages.remove(village);
      notifyListeners();
    }
  }
}
