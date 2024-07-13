import 'dart:async';

import 'package:flutter/material.dart';

class UserDashBoardProvider extends ChangeNotifier {
  bool expandDrawer = true;
  int workedTodayTime = 0;
  int breakTodayTime = 0;
  String workedTodayFormatedTime = '00:00:00';
  String breakTodayFormatedTime = '00:00:00';
  Timer? timer;
  Timer? breakTimer;
  int isClicked = 0;
  changePage(int value) {
    isClicked = value;
    notifyListeners();
  }

  expandDrawerFunc() {
    expandDrawer = !expandDrawer;
    notifyListeners();
  }

  startTimer() {
    try {
      if (breakTimer?.isActive ?? false) {
        stopBreakTimer();
      }
      // ignore: prefer_conditional_assignment
      if (timer == null) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          workedTodayTime++;
          workedTodayFormatedTime = getFormattedTime(workedTodayTime);
          notifyListeners();
        });
      }
    } catch (e) {
      debugPrint('Error starting timer: $e');
    }
  }

  startBreakTimer() {
    debugPrint('break timer called');
    try {
      if (timer?.isActive ?? false) {
        stopTimer();
      }
      // ignore: prefer_conditional_assignment
      if (breakTimer == null) {
        breakTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          breakTodayTime++;
          breakTodayFormatedTime = getFormattedTime(breakTodayTime);
          notifyListeners();
        });
      } else {
        stopBreakTimer();
      }
    } catch (e) {
      debugPrint('Error starting timer: $e');
    }
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    notifyListeners();
  }

  void stopBreakTimer() {
    breakTimer?.cancel();
    breakTimer = null;
    notifyListeners();
  }

  String getFormattedTime(int currentTime) {
    int hours = currentTime ~/ 3600;
    int minutes = (currentTime % 3600) ~/ 60;
    int seconds = currentTime % 60;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }

  clearController() {
    timer = null;
    workedTodayTime = 0;
    breakTodayTime = 0;
    workedTodayFormatedTime = '00:00:00';
    breakTodayFormatedTime = '00:00:00';
    notifyListeners();
  }
}
