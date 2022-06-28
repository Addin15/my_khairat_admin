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
    List<Member> members = await MemberController.getMembers(mosqueID, 0);

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

  Future<bool> updateMember(String mosqueID, Map<String, dynamic> data) async {
    bool res = await MemberController.updateMember(data);

    if (res) {
      initData(mosqueID);
      return true;
    }

    return false;
  }

  acceptMember(String mosqueID, String id) async {
    bool? res = await MemberController.acceptMember(mosqueID, id);

    if (res) {
      initData(mosqueID);
    }
  }

  rejectMember(String mosqueID, String id) async {
    bool? res = await MemberController.rejectMember(mosqueID, id);

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
