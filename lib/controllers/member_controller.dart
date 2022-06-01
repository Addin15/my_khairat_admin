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
        List graves = jsonDecode(response.body);

        return graves
            .map((grave) => Member.fromMap(grave as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
