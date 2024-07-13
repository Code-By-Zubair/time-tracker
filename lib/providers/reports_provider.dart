import 'package:flutter/material.dart';

class ReportProvider extends ChangeNotifier {
  String appBarTitle = 'Users';
  int selectedTab=0;
  int selectedAppUsageTab=0;
  changePageTab(int value){
    selectedTab=value;
    notifyListeners();
  }
  changeAppbarTitle(String value) {
    appBarTitle = value;
    notifyListeners();
  }
  changeSelectedAppUsageTab(int value) {
    selectedAppUsageTab = value;
    notifyListeners();
  }
}
