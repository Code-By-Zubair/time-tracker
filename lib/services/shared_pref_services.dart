import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_tracker/models/share_pref_model.dart';

class SharedPrefServices {
  Future<void> saveUserDataLoacally(SharePrefModel sharePrefModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(sharePrefModel.toJson()));
  }

  Future<SharePrefModel?> getUserDataLocally() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      print('this is in string $userData');
      SharePrefModel userModel = SharePrefModel.fromString(userData);

      return userModel;
    } else {
      return null;
    }
  }

  removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
