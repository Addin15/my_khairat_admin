import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/member.dart';

class MemberController {
  // Get all members
  static Future<List<Member>> getMembers(String mosqueID, int offset) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/get';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'mosque_id': mosqueID,
          'offset': offset,
        }),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        List members = jsonDecode(response.body);

        return members
            .map((grave) => Member.fromMap(grave as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // Get all members
  static Future<dynamic> addMember(
      String mosqueID, Map<String, dynamic> map) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/add';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'mosque_id': mosqueID,
          'village_id': map['village_id'],
          'person_member_no': map['person_member_no'],
          'person_name': map['person_name'],
          'person_ic': map['person_ic'],
          'person_phone': map['person_phone'],
          'person_occupation': map['person_occupation'],
          'person_expire_month': map['person_expire_month'],
          'person_expire_year': map['person_expire_year'],
        }),
        headers: headerswithToken(_token),
      );

      log('Add Member' + response.body);

      if (response.statusCode == 201) {
        Map member = jsonDecode(response.body);

        return Member.fromMap((member as Map<String, dynamic>));
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> acceptMember(String mosqueID, String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/accept';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'mosque_id': mosqueID,
          'person_expire_month': DateTime.now().month,
          'person_expire_year': DateTime.now().year,
          'id': id,
        }),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> rejectMember(String mosqueID, String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/reject';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'mosque_id': mosqueID,
          'id': id,
        }),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> updateMember(Map<String, dynamic> data) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/update';

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log('Update' + response.body);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
