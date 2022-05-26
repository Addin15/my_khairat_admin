import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/grave_controller.dart';
import 'package:my_khairat_admin/models/grave.dart';

class GraveDAO extends ChangeNotifier {
  List<Grave> _graves = [];

  GraveDAO(String mosqueID) {
    initData(mosqueID);
  }

  get graves => _graves;

  initData(String mosqueID) async {
    List<Grave> graves = await GraveController.getGraves(mosqueID);

    // TODO Cache with hive

    _graves = graves;
    notifyListeners();
  }

  addGrave(String mosqueID, Grave grave) async {
    dynamic data = await GraveController.addGrave(mosqueID, grave);

    if (data != null) {
      _graves.add(data);
      notifyListeners();
    }
  }

  editGrave(Grave grave) async {
    dynamic data = await GraveController.editGrave(grave);

    if (data != null) {
      int index = _graves.indexWhere((g) => g.id == grave.id);
      _graves[index] = grave;

      notifyListeners();
    }
  }

  deleteGrave(Grave grave) async {
    bool res = await GraveController.deleteGrave(grave);

    if (res) {
      _graves.remove(grave);

      notifyListeners();
    }
  }
}
