import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/dependent_controller.dart';
import 'package:my_khairat_admin/models/dependent.dart';

class DependentDAO extends ChangeNotifier {
  List<Dependent> _dependents = [];
  List<Dependent> _pendingDependents = [];

  List<Dependent> get dependents => _dependents;
  List<Dependent> get pendingDependents => _pendingDependents;

  DependentDAO(String mosqueID) {
    initData(mosqueID);
  }

  initData(String mosqueID) async {
    List<Dependent> data = await DependentController.getDependents(mosqueID);

    filterDependents(data);
    notifyListeners();
  }

  filterDependents(List<Dependent> unfilteredDependents) {
    List<Dependent> tempDependents = [];
    List<Dependent> tempPendingDependents = [];

    for (var dependent in unfilteredDependents) {
      if (dependent.status == 'pending') {
        tempPendingDependents.add(dependent);
      } else if (dependent.status == 'completed') {
        tempDependents.add(dependent);
      }
    }

    _dependents = tempDependents;
    _pendingDependents = tempPendingDependents;
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

  acceptDependent(String mosqueID, String id) async {
    bool res = await DependentController.acceptDependent(id);

    if (res) {
      initData(mosqueID);
    }
  }

  rejectDependent(String mosqueID, String id) async {
    bool res = await DependentController.rejectDependent(id);

    if (res) {
      initData(mosqueID);
    }
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
