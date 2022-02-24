import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/presentation_layer/modules/boarding/onbourding_screen.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }

    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else {
      return await sharedPreferences!.setBool(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({required key}) async {
    return await sharedPreferences!.remove(key);
  }
}
