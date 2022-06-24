import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/claim.dart';

class ClaimController {
  //get claims
  static Future<List<Claim>> getClaims(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/claims/get';
      log(mosqueID);
      Map<String, dynamic> data = {'mosque_id': mosqueID};

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        List claims = jsonDecode(response.body);

        return claims
            .map((claim) => Claim.fromMap(claim as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  //change status
  static Future<bool> actionOnnClaims(String claimID, String status) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/claims/action';

      Map<String, dynamic> data = {
        'id': claimID,
        'status': status,
      };

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
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
}
