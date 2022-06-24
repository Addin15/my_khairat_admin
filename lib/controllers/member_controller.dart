import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/member.dart';

class MemberController {
  // Get all members
  static Future<List<Member>> getMembers(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/members/get';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'mosque_id': mosqueID,
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

      log(response.body);

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
}
