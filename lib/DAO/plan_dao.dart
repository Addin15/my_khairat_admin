import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/models/plan.dart';

class PlanDAO extends ChangeNotifier {
  List<Plan> _plans = [];

  List<Plan> get plans => _plans;

  PlanDAO(String mosqueID) {
    initData(mosqueID);
  }

  initData(String mosqueID) async {
    List<Plan> plans = await AuthController.getPlans(mosqueID);

    _plans = plans;
    notifyListeners();
  }

  makePayment(Map<String, String> data, XFile image) async {
    Plan? res = await AuthController.uploadPayment(data, image);

    if (res != null) {
      _plans.add(res);
      notifyListeners();
    }
  }
}
