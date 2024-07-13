import 'package:flutter/material.dart';

class ReportProviderUserSide extends ChangeNotifier {

  int selectedTab = 0;
  int appUsageTab=0;

  changeSelectedTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  
  changeAppUsageTab(int index) {
    appUsageTab = index;
    notifyListeners();
  }
}
