import 'package:flutter/material.dart';

class DashBoardProvider extends ChangeNotifier {
  int isClicked = 0;
  bool userWeeklyReportEnable = true;
  bool userDailyReportEnable = true;
  bool trackingWhenIdle = true;
  bool takeSSWhileTracking = true;
  bool stealthMode = true;
  bool automaticMode = true;
  bool sendWarningEmailsToUSers = true;
  String trackingAwayTimeTrack = 'Always';
  bool showMoreOptions = false;
  bool importBulkUsers = false;
  bool excludeTeams = true;
  bool isNewProjectTabOpened = true;
  int selectedProjectIndex = 0;
  int createProjectType = 0;
  bool includeTeamsInCreateProject = true;
  bool expandDrawer = true;
  int taskTab = 0;

  changeTaskTab(int tab) {
    taskTab = tab;
    notifyListeners();
  }

  changePage(int value) {
    isClicked = value;
    notifyListeners();
  }

  enableWeeklyReport(bool value) {
    userWeeklyReportEnable = value;
    notifyListeners();
  }

  enableDailyReport(bool value) {
    userDailyReportEnable = value;
    notifyListeners();
  }

  enableTrackingWhenIdle(bool value) {
    trackingWhenIdle = value;
    notifyListeners();
  }

  enableTakingSSWhileTracking(bool value) {
    takeSSWhileTracking = value;
    notifyListeners();
  }

  enableAutomaticMode(bool value) {
    automaticMode = value;
    notifyListeners();
  }

  enableStealthMode(bool value) {
    stealthMode = value;
    notifyListeners();
  }

  allowTrackingAwayTime(String value) {
    trackingAwayTimeTrack = value;
    notifyListeners();
  }

  allowSendWarningEmailsToUSers(bool value) {
    sendWarningEmailsToUSers = value;
    notifyListeners();
  }

  showMoreOptionsfunc() {
    showMoreOptions = true;
    importBulkUsers = false;
    notifyListeners();
  }

  importBulkUsersFunc() {
    importBulkUsers = true;
    showMoreOptions = false;
    notifyListeners();
  }

  excludeTeamsFunc() {
    excludeTeams = true;
    notifyListeners();
  }

  excludeUsers() {
    excludeTeams = false;
    notifyListeners();
  }

  openNewProjectTab() {
    isNewProjectTabOpened = true;
    notifyListeners();
  }

  openBackLogTab() {
    isNewProjectTabOpened = false;
    notifyListeners();
  }

  selectedProjectIndexChange(int value) {
    selectedProjectIndex = value;
    notifyListeners();
  }

  changeCreateProjectType(int value) {
    createProjectType = value;
    notifyListeners();
  }

  includeTeamsInCreateProjectFunc() {
    includeTeamsInCreateProject = true;
    notifyListeners();
  }

  includeUsersInCreateProjectFunc() {
    includeTeamsInCreateProject = false;
    notifyListeners();
  }

  expandDrawerFunc() {
    expandDrawer = !expandDrawer;
    notifyListeners();
  }
}
