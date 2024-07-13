import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';

class GlobalSwitchButton extends StatelessWidget {
  const GlobalSwitchButton({
    super.key,
    required this.onTap,
    required this.currentState,
  });

  final ValueChanged onTap;
  final bool currentState;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(useMaterial3: false),
      child: Switch(
        activeColor: Colors.white,
        inactiveThumbColor: AppColors.appPrimaryColor,
        inactiveTrackColor: AppColors.appLightGrey.withOpacity(0.4),
        activeTrackColor: AppColors.appPrimaryColor,
        value: currentState,
        onChanged: onTap,
      ),
    );
  }
}
