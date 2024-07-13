import 'package:flutter/material.dart';

class SettingsProviderUserSide extends ChangeNotifier {
  int selectedTab = 0;
  String selectedTabTitle = 'User Settings';
  String receiveWeeklyReport = 'enable';
  String receiveDailyReport = 'disable';

  changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  changeSelectedTabTitle(int selectedTab) {
    if (selectedTab == 0) {
      selectedTabTitle = 'User Settings';
      notifyListeners();
    } else {
      selectedTabTitle = 'User Profile';
      notifyListeners();
    }
  }

  changeWeeklyReport(String status) {
    receiveWeeklyReport = status;
    notifyListeners();
  }

  changeDailyReport(String status) {
    receiveDailyReport = status;
    notifyListeners();
  }
}
