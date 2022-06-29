import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/dependent.dart';

class DependentController {
  static Future<List<Dependent>> getDependents(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/dependent/get';
      Map<String, dynamic> data = {'mosque_id': mosqueID};

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log('Dependent' + response.body);

      if (response.statusCode == 200) {
        List dependents = jsonDecode(response.body);

        return dependents
            .map((dependent) =>
                Dependent.fromMap(dependent as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<Dependent?> addDependent(Map<String, dynamic> data) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/dependent/add';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 201) {
        Map dependent = jsonDecode(response.body);

        return Dependent.fromMap(dependent as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> acceptDependent(String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/dependent/accept';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
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

  static Future<bool> rejectDependent(String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/dependent/reject';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
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
}
