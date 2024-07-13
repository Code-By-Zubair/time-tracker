import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  bool userProfile = true;
  bool enableOwner = true;
  bool enableAdmin = true;
  bool enableManager = true;
  bool enableUser = true;
  int selectedTab = 0;

  changeTab(int value) {
    selectedTab = value;
    notifyListeners();
  }

  openUSerProfile() {
    userProfile = true;
    notifyListeners();
  }

  openOrganizationProfile() {
    userProfile = false;
    notifyListeners();
  }

  enableOwnerFunc() {
    enableOwner = true;
    notifyListeners();
  }

  disableOwnerFunc() {
    enableOwner = false;
    notifyListeners();
  }

  enableAdminFunc() {
    enableAdmin = true;
    notifyListeners();
  }

  disableAdminFunc() {
    enableAdmin = false;
    notifyListeners();
  }

  enableManagerFunc() {
    enableManager = true;
    notifyListeners();
  }

  disableManagerFunc() {
    enableManager = false;
    notifyListeners();
  }

  enableUserFunc() {
    enableUser = true;
    notifyListeners();
  }

  disableUSerFunc() {
    enableUser = false;
    notifyListeners();
  }
}
