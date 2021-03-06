import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/mosque.dart';
import 'package:my_khairat_admin/models/plan.dart';

class AuthController {
  // Register
  static Future<dynamic> register(
      {required String email, required String password}) async {
    try {
      String url = '${Config.hostName}/committee/register';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Login
  static Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      String url = '${Config.hostName}/committee/login';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Complete profile
  static Future<bool> complete(
      {required Mosque mosque, required XFile image}) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/complete';

      Map<String, String> data = mosque.toMap();

      // var response = await put(
      //   Uri.parse(url),
      //   body: jsonEncode(data),
      //   headers: headerswithToken(_token),

      // );

      var request = MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(data)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        })
        ..files.add(await MultipartFile.fromPath('image', image.path));

      StreamedResponse stream = await request.send();

      var response = await Response.fromStream(stream);
      log(response.body);

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<List<Plan>> getPlans(String mosqueID) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/plan';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'mosque_id': mosqueID,
          }),
          headers: headerswithToken(_token));

      log(response.body);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);

        List<Plan> plans = data
            .map((plan) => Plan.fromMap(plan as Map<String, dynamic>))
            .toList();

        return plans;
      }

      return <Plan>[];
    } catch (e) {
      log(e.toString());
      return <Plan>[];
    }
  }

  static Future<Plan?> uploadPayment(
      Map<String, String> data, XFile image) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/plan/subscribe';

      var request = MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(data)
        ..headers.addAll({
          'Content-Type': 'multipart/form-data',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + _token,
        })
        ..files.add(await MultipartFile.fromPath('image', image.path));

      StreamedResponse stream = await request.send();

      var response = await Response.fromStream(stream);
      log(response.body);

      if (response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);

        return Plan.fromMap(data);
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Log out
  static Future<bool> logout() async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/logout';

      var response = await post(
        Uri.parse(url),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['isLogOut'] == true) return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getUser(String id) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/get';

      var response = await post(
        Uri.parse(url),
        body: jsonEncode({
          'id': id,
        }),
        headers: headerswithToken(_token),
      );

      log(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getAdminBank() async {
    try {
      String url = '${Config.hostName}/bankdetails';

      var response = await get(
        Uri.parse(url),
        headers: headersWithoutToken(),
      );

      log(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }

      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
