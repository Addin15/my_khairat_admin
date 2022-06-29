import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_khairat_admin/config/secure_storage.dart';
import 'package:my_khairat_admin/controllers/auth_controller.dart';
import 'package:my_khairat_admin/controllers/user_controller.dart';
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

      Map<String, dynamic>? data = await AuthController.getUser(_mosque!.id!);

      if (mosque != null) {
        _mosque = Mosque.fromMap(data!);
        notifyListeners();
      }
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
      initData();
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

  editBankDetails(Map<String, dynamic> data) async {
    bool res = await UserController.editBankDetails(data);

    if (res) {
      Mosque latest = mosque!;

      latest.bankName = data['bank_name'];
      latest.bankOwnerName = data['bank_owner_name'];
      latest.bankAccountNo = data['bank_account_no'];
      latest.monthlyFee = double.parse(data['monthly_fee']);

      SecureStorage _secureStorage = SecureStorage();
      String? _token = await _secureStorage.read('token');
      // Cache user data by token
      Box _mosqueBox = await Hive.openBox('mosque');
      _mosqueBox.put(
        _token,
        latest,
      );

      notifyListeners();
    }
  }

  getAdminBank() async {
    Map<String, dynamic>? data = await AuthController.getAdminBank();

    if (data != null) {
      return data;
    }

    return null;
  }

  // Caught exception purpose
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
