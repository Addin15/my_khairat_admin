import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/claim_controller.dart';
import 'package:my_khairat_admin/models/claim.dart';

class ClaimDAO extends ChangeNotifier {
  List<Claim> _claims = [];

  ClaimDAO(String mosqueID) {
    initData(mosqueID);
  }

  get claims => _claims;

  void initData(String mosqueID) async {
    _claims = await ClaimController.getClaims(mosqueID);
    notifyListeners();
  }

  changeClaimStatus(String claimID, String status) async {
    bool res = await ClaimController.actionOnClaims(claimID, status);
    if (res) {
      claims.where((claim) => claim.id == claimID).first.status = status;
    }
    notifyListeners();
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
