import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:time_tracker/models/share_pref_model.dart';
import 'package:time_tracker/services/shared_pref_services.dart';

class SharedPrefProvider extends ChangeNotifier {
  SharePrefModel? data;
  Future getPrefData() async {
    SharedPrefServices sharedPrefServices = SharedPrefServices();
    data = await sharedPrefServices.getUserDataLocally();
    notifyListeners();
    log('this is pref data $data');
  }

  clearPrefData() {
    data = null;
    notifyListeners();
  }
  
}
