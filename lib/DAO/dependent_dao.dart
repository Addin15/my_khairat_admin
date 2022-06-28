import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/dependent_controller.dart';
import 'package:my_khairat_admin/models/dependent.dart';

class DependentDAO extends ChangeNotifier {
  List<Dependent> _dependents = [];

  List<Dependent> get dependents => _dependents;

  DependentDAO(String mosqueID) {
    initData(mosqueID);
  }

  initData(String mosqueID) async {
    List<Dependent> data = await DependentController.getDependents(mosqueID);

    _dependents = data;
    notifyListeners();
  }

  Future<bool> addDependent(Map<String, dynamic> dependent) async {
    Dependent? res = await DependentController.addDependent(dependent);
    if (res != null) {
      _dependents.add(res);
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
