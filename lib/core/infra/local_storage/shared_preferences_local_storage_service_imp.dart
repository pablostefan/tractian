import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tractian/core/infra/local_storage/local_storage_service.dart';

class SharedPreferencesLocalStorageService implements LocalStorageService {
  SharedPreferencesLocalStorageService();

  @override
  Future<dynamic> getData(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String? data = sharedPreferences.getString(key);
      return jsonDecode(data ?? '');
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getString(String key) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> putData(String key, dynamic value) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final String data = jsonEncode(value);
      return await sharedPreferences.setString(key, data);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> putString(String key, String value) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      return await sharedPreferences.setString(key, value);
    } catch (e) {
      return false;
    }
  }
}