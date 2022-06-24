import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_khairat_admin/controllers/member_controller.dart';
import 'package:my_khairat_admin/models/member.dart';

class MemberDAO extends ChangeNotifier {
  List<Member> _members = [];
  List<Member> _pendingMembers = [];

  MemberDAO(String mosqueID) {
    initData(mosqueID);
  }

  List<Member> get members => _members;
  List<Member> get pendingMembers => _pendingMembers;

  initData(String mosqueID) async {
    List<Member> members = await MemberController.getMembers(mosqueID);

    filterMembers(members);
  }

  filterMembers(List<Member> unfilteredMembers) {
    List<Member> tempMembers = [];
    List<Member> tempPendingMembers = [];

    for (var member in unfilteredMembers) {
      if (member.status == 'pending') {
        tempPendingMembers.add(member);
      } else if (member.status == 'completed') {
        tempMembers.add(member);
      }
    }

    _members = tempMembers;
    _pendingMembers = tempPendingMembers;
    notifyListeners();
  }

  addMember(String mosqueID, Map<String, dynamic> map) async {
    Member? member = await MemberController.addMember(mosqueID, map);

    if (member != null) {
      members.add(member);
      notifyListeners();
      return true;
    }

    return false;
  }
}
