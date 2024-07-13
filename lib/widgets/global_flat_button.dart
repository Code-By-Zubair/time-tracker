import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class GlobalFlatButton extends StatelessWidget {
  const GlobalFlatButton({
    super.key,
    required this.text,
    required this.onTap,
    this.backgroundColor,
    this.foregroundColor,
    this.height,
    this.width,
    this.textStyle,
    this.textColor,
    this.isLoading = false,
  });
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final Color? textColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height ?? 60,
        width: width ?? double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? AppColors.appPrimaryColor,
              foregroundColor: foregroundColor ?? Colors.white),
          onPressed: isLoading ? null : onTap,
          child: isLoading
              ? const WaveLoadingWidget(
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: textColor ?? Colors.black),
                ),
        ));
  }
}
