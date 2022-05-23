import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  // Add data to secure storage
  Future<bool> add(String key, String value) async {
    try {
      await _storage.write(
          key: key,
          value: value,
          iOptions: _getIOSOptions(),
          aOptions: _getAndroidOptions());

      return true;
    } catch (e) {
      return false;
    }
  }

  // get data
  Future<dynamic> read(String key) async {
    try {
      String? value = await _storage.read(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );

      return value;
    } catch (e) {
      return null;
    }
  }

  // Delete data
  Future<bool> delete(String key) async {
    try {
      await _storage.delete(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAll() async {
    try {
      await _storage.deleteAll(
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions(),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  // IOS config
  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'flutter_secure_storage',
      );

  // Android config
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}
