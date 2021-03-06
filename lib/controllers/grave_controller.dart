import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/grave.dart';

class GraveController {
  // Get all graves
  static Future<List<Grave>> getGraves(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/graves/get';

      Map<String, dynamic> data = {
        'mosque_id': mosqueID,
      };

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        List graves = jsonDecode(response.body);

        return graves
            .map((grave) => Grave.fromMap(grave as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // Add announcement
  static Future<dynamic> addGrave(String mosqueID, Grave grave) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/graves/add';

      Map<String, dynamic> data = {
        'mosque_id': mosqueID,
        'grave_name': grave.name,
        'grave_address': grave.address,
      };

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);

        return Grave.fromMap(data);
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Edit grave
  static Future<dynamic> editGrave(Grave grave) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/graves/edit';

      Map<String, dynamic> data = grave.toMap();

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        return grave;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Delete grave
  static Future<bool> deleteGrave(Grave grave) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/graves/delete';

      Map<String, dynamic> data = grave.toMap();

      var response = await post(
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
