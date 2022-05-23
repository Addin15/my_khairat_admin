import 'dart:convert';

import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/village.dart';

class VillageController {
  // Get all villages
  static Future<List<Village>> getVillages(String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/villages/get';

      Map<String, dynamic> data = {
        'mosque_id': id,
      };

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        List villages = jsonDecode(response.body);

        return villages
            .map((village) => Village.fromMap(village as Map<String, dynamic>))
            .toList();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  // Add village
  static Future<dynamic> addVillage(String id, Village village) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/villages/add';

      Map<String, dynamic> data = {
        'mosque_id': id,
        'village_name': village.name,
        'village_address': village.address,
      };

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 201) {
        Map<String, dynamic> village = jsonDecode(response.body);

        return Village.fromMap(village);
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Add village
  static Future<dynamic> editVillage(Village village) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/villages/edit';

      Map<String, dynamic> data = village.toMap();

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        return village;
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Add village
  static Future<bool> deleteVillage(Village village) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');

      String url = '${Config.hostName}/committee/villages/delete';

      Map<String, dynamic> data = village.toMap();

      var response = await post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
