import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/member_controller.dart';
import 'package:my_khairat_admin/models/member.dart';

class MemberDAO extends ChangeNotifier {
  List<Member> _members = [];

  MemberDAO(String mosqueID) {
    initData(mosqueID);
  }

  get members => _members;

  initData(String mosqueID) async {
    List<Member> members = await MemberController.getMembers(mosqueID);

    _members = members;
    notifyListeners();
  }
}
