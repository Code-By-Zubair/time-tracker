import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.checkbox,
    required this.onValueChanged,
    this.borderSide,
    this.shape,
    this.activeColor,
  });

  final bool checkbox;
  final ValueChanged onValueChanged;
  final BorderSide? borderSide;
  final OutlinedBorder? shape;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: activeColor ?? AppColors.appPrimaryColor,
        side: borderSide ??
            const BorderSide(color: AppColors.appPrimaryColor, width: 2),
        shape: shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        value: checkbox,
        onChanged: onValueChanged);
  }
}
