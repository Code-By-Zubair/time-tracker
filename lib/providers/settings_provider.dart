import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  int selectedTab = 0;
  //Tracking tab
  String automaticMode = 'enable';
  String stealthModeInfo = 'disable';
  String extendedStealthMode = 'enable';
  String stopTrackingifIdle = 'disable';
  String continueTrackingIfComputerSleeping = 'enable';
  String allowWorkAwayFromComputer = 'enable';
  String startsTrackingWhenComputerStarts = 'enable';
  String stopTrackingIfNoInternetConnection = 'enable';
  String showIndicator = 'enable';
  String showBackToWorkReminder = 'enable';
  String trackApplicationUsage = 'enable';
  String locationTracking = 'enable';
  //screen capture tab
  String takeSSWhileTrackingEnable = 'enable';
  String randomizeSSInterval = 'enable';
  String blurSSBeforeUploadingToCloud = 'slightly';
  //access to reports tab

  String usersCanSeeReports = 'enable';
  String usersCanSeeSS = 'enable';
  //shifts tab
  String shiftingSchedule = 'enable';

  //projectandTaskTab
  bool sendEmailNotificationToUSerWhenTaskAssigned = false;
  bool canUserCreateProject = false;
  bool canManagerCreateProject = true;
  bool canUserUpdateProject = false;
  bool canManagerUpdateProject = true;
  bool canUserDeleteProject = false;
  bool canManagerDeleteProject = false;
  //
  bool canUserCreateSprints = false;
  bool canManagerCreateSprints = true;
  bool canUserUpdateSprints = false;
  bool canManagerUpdateSprints = true;
  bool canUserDeleteSprints = false;
  bool canManagerDeleteSprints = false;
  //
  bool canUserCreateTasks = false;
  bool canManagerCreateTasks = true;
  bool canUserUpdateTasks = false;
  bool canManagerUpdateTasks = true;
  bool canUserDeleteTasks = false;
  bool canManagerDeleteTasks = false;

  // email report tab
  String receiveWeeklyReports = 'enable';
  String receiveDailyReports = 'enable';
  String sendDailyWarningEmails = 'disable';
  String sendWeeklyWarningEmails = 'disable';

  //manual time tab
  String allowUserToSubmitAManualTime = 'enable';
  String manualTimeHasToBeApproved = 'enable';
  String managerCanApprove = 'enable';
  String adminsAlwaysReceiveManual = 'enable';

  changeTab(int value) {
    selectedTab = value;
    notifyListeners();
  }

  //Tracking tab
  changeAutomaticMode(String value) {
    automaticMode = value;
    notifyListeners();
  }

  changeStealthModeInfo(String value) {
    stealthModeInfo = value;
    notifyListeners();
  }

  changeExtendedStealthMode(String value) {
    extendedStealthMode = value;
    notifyListeners();
  }

  changeStopTrackingIfIdle(String value) {
    stopTrackingifIdle = value;
    notifyListeners();
  }

  changeContinueTrackingIfComputerSleeping(String value) {
    continueTrackingIfComputerSleeping = value;
    notifyListeners();
  }

  changeAllowWorkAwayFromComputer(String value) {
    allowWorkAwayFromComputer = value;
    notifyListeners();
  }

  changeStartsTrackingWhenComputerStarts(String value) {
    startsTrackingWhenComputerStarts = value;
    notifyListeners();
  }

  changeStopTrackingIfNoInternetConnection(String value) {
    stopTrackingIfNoInternetConnection = value;
    notifyListeners();
  }

  changeShowIndicator(String value) {
    showIndicator = value;
    notifyListeners();
  }

  changeShowBackToWorkReminder(String value) {
    showBackToWorkReminder = value;
    notifyListeners();
  }

  changeTrackApplicationUsage(String value) {
    trackApplicationUsage = value;
    notifyListeners();
  }

  changeLocationTracking(String value) {
    locationTracking = value;
    notifyListeners();
  }

  //screen capture tab
  changeTakeSSWhileTrackingEnable(String value) {
    takeSSWhileTrackingEnable = value;
    notifyListeners();
  }

  changeRandomizeSSInterval(String value) {
    randomizeSSInterval = value;
    notifyListeners();
  }

  changeBlurSSBeforeUploadingToCloud(String value) {
    blurSSBeforeUploadingToCloud = value;
    notifyListeners();
  }
  //access to reports tab

  changeUsersCanSeeReports(String value) {
    usersCanSeeReports = value;
    notifyListeners();
  }

  changeUsersCanSeeSS(String value) {
    usersCanSeeSS = value;
    notifyListeners();
  }

  //shifts tab
  changeShiftingSchedule(String value) {
    shiftingSchedule = value;
    notifyListeners();
  }

  //project and task tab
  sendEmailNotificationToUSerWhenTaskAssignedFunc(bool value) {
    sendEmailNotificationToUSerWhenTaskAssigned = value;
    notifyListeners();
  }

  canUserCreateProjectFunc(bool value) {
    canUserCreateProject = value;
    notifyListeners();
  }

  canManagerCreateProjectFunc(bool value) {
    canManagerCreateProject = value;
    notifyListeners();
  }

  canUserUpdateProjectFunc(bool value) {
    canUserUpdateProject = value;
    notifyListeners();
  }

  canManagerUpdateProjectFunc(bool value) {
    canManagerUpdateProject = value;
    notifyListeners();
  }

  canUserDeleteProjectFunc(bool value) {
    canUserDeleteProject = value;
    notifyListeners();
  }

  canManagerDeleteProjectFunc(bool value) {
    canManagerDeleteProject = value;
    notifyListeners();
  }

  //
  canUserCreateSprintsFunc(bool value) {
    canUserCreateSprints = value;
    notifyListeners();
  }

  canManagerCreateSprintsFunc(bool value) {
    canManagerCreateSprints = value;
    notifyListeners();
  }

  canUserUpdateSprintsFunc(bool value) {
    canUserUpdateSprints = value;
    notifyListeners();
  }

  canManagerUpdateSprintsFunc(bool value) {
    canManagerUpdateSprints = value;
    notifyListeners();
  }

  canUserDeleteSprintsFunc(bool value) {
    canUserDeleteSprints = value;
    notifyListeners();
  }

  canManagerDeleteSprintsFunc(bool value) {
    canManagerDeleteSprints = value;
    notifyListeners();
  }
  canUserCreateTasksFunc(bool value){
    canUserCreateTasks=value;
    notifyListeners();
  }
  canManagerCreateTasksFunc(bool value){
    canManagerCreateTasks=value;
    notifyListeners();
  }
  canUserUpdateTasksFunc(bool value){
    canUserUpdateTasks=value;
    notifyListeners();
  }
  canManagerUpdateTasksFunc(bool value){
    canManagerUpdateTasks=value;
    notifyListeners();
  }
  canUserDeleteTasksFunc(bool value){
    canUserDeleteTasks=value;
    notifyListeners();
  }
  canManagerDeleteTasksFunc(bool value){
    canManagerDeleteTasks=value;
    notifyListeners();
  }






















  //email roports tab

  changeReceiveWeeklyReports(String value) {
    receiveWeeklyReports = value;
    notifyListeners();
  }

  changeReceiveDailyReports(String value) {
    receiveDailyReports = value;
    notifyListeners();
  }

  changeSendDailyWarningEmails(String value) {
    sendDailyWarningEmails = value;
    notifyListeners();
  }

  changeSendWeeklyWarningEmails(String value) {
    sendWeeklyWarningEmails = value;
    notifyListeners();
  }

  // Manual time tab

  changeAllowUserToSubmitAManualTime(String value) {
    allowUserToSubmitAManualTime = value;
    notifyListeners();
  }

  changeManualTimeHasToBeApproved(String value) {
    manualTimeHasToBeApproved = value;
    notifyListeners();
  }

  changeManagerCanApprove(String value) {
    managerCanApprove = value;
    notifyListeners();
  }

  changeAdminsAlwaysReceiveManual(String value) {
    adminsAlwaysReceiveManual = value;
    notifyListeners();
  }
}
