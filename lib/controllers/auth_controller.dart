import 'dart:convert';
import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:my_khairat_admin/config/config.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/constants/headers.dart';
import 'package:my_khairat_admin/models/mosque.dart';

class AuthController {
  // Register
  static Future<bool> register(
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

        // Cache token
        SecureStorage _secureStorage = SecureStorage();
        bool cached = await _secureStorage.add('token', data['token']);
        if (cached) {
          // Cache user data by token
          Box _mosqueBox = await Hive.openBox('mosque');
          _mosqueBox.put(
            data['token'],
            Mosque.fromMap(data),
          );
        }

        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Login
  static Future<bool> login(
      {required String email, required String password}) async {
    try {
      String url = '${Config.hostName}/committee/login';

      var response = await post(Uri.parse(url),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: headersWithoutToken());

      log(response.body);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        // Cache token
        SecureStorage _secureStorage = SecureStorage();
        bool cached = await _secureStorage.add('token', data['token']);
        if (cached) {
          // Cache user data by token
          Box _mosqueBox = await Hive.openBox('mosque');
          _mosqueBox.put(
            data['token'],
            Mosque.fromMap(data),
          );
        }

        return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Complete profile
  static Future<bool> complete({required Mosque mosque}) async {
    try {
      SecureStorage _secureStorage = SecureStorage();
      String _token = await _secureStorage.read('token');
      String url = '${Config.hostName}/committee/complete';

      var response = await put(
        Uri.parse(url),
        body: jsonEncode(mosque.toMap()),
        headers: headerswithToken(_token),
      );

      if (response.statusCode == 201) {
        if (jsonDecode(response.body) == 1) return true;
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
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
}
