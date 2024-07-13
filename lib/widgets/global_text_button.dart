import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class GlobalTextButton extends StatelessWidget {
  const GlobalTextButton({
    super.key,
    this.bachgroundColor,
    this.foregroundColor,
    required this.text,
    this.onTap,
    this.borderColor,
    this.borderRadius,
    this.textStyle,
    this.buttonTextColor,
    this.isLoading = false,
  });
  final Color? bachgroundColor;
  final Color? foregroundColor;
  final String text;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? buttonTextColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            backgroundColor: bachgroundColor ?? AppColors.bgColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
                side: BorderSide(
                  color: borderColor ?? Colors.orange,
                ))),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const WaveLoadingWidget(
                color: Colors.white,
              )
            : Text(
                text,
                style: textStyle ??
                    TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: buttonTextColor ?? Colors.black),
              ));
  }
}
