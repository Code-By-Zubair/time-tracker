import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/main.dart';

extension ContextExtensions on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;

  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  ThemeData get themeContext => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  void showSuccessSnackBar(String message) {
    globalKey.currentState?.removeCurrentSnackBar();
    globalKey.currentState?.showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20) +
            EdgeInsets.only(
                left: ((globalKey.currentContext)?.size?.width ?? 1) * .7),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showInfoSnackBar(String message) {
    globalKey.currentState?.removeCurrentSnackBar();
    globalKey.currentState?.showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20) +
            EdgeInsets.only(
                left: ((globalKey.currentContext)?.size?.width ?? 1) * .7),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: AppColors.appPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showErrorSnackBar(String message) {
    globalKey.currentState?.removeCurrentSnackBar();
    globalKey.currentState?.showSnackBar(
      SnackBar(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20) +
            EdgeInsets.only(
                left: ((globalKey.currentContext)?.size?.width ?? 1) * .7),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
