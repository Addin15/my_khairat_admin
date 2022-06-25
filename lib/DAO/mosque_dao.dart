import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/models/mosque.dart';

class MosqueDAO extends ChangeNotifier {
  Mosque? _mosque;

  Mosque? get mosque => _mosque;

  MosqueDAO() {
    initData();
  }

  initData() async {
    SecureStorage _secureStorage = SecureStorage();
    String? _token = await _secureStorage.read('token');

    if (_token != null) {
      Box _mosqueBox = await Hive.openBox('mosque');
      _mosque = _mosqueBox.get(_token);

      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    dynamic data = await AuthController.login(email: email, password: password);
    if (data != null) {
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

      _mosque = Mosque.fromMap(data);
      log('logged in');
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    dynamic data =
        await AuthController.register(email: email, password: password);

    if (data != null) {
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

      _mosque = Mosque.fromMap(data);
      log('registered');
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  completeProfile(Mosque mosque, XFile image) async {
    bool res = await AuthController.complete(
      mosque: mosque,
      image: image,
    );
    if (res) {
      SecureStorage _secureStorage = SecureStorage();
      String? _token = await _secureStorage.read('token');
      // Cache user data by token
      Box _mosqueBox = await Hive.openBox('mosque');
      _mosqueBox.put(
        _token,
        mosque,
      );

      _mosque = mosque;
      notifyListeners();
    }
  }

  logout() async {
    SecureStorage _secureStorage = SecureStorage();
    _secureStorage.deleteAll();
    Box _mosqueBox = await Hive.openBox('mosque');
    _mosqueBox.clear();

    _mosque = null;
    notifyListeners();
  }
}
