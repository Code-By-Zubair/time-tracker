import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/widgets/custom_loading.dart';

class IconButtonWithLabel extends StatelessWidget {
  const IconButtonWithLabel({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconHeight,
    this.borderRadius,
    this.textStyle,
    this.borderColor,
    this.backgroundColor,
    this.height,
    this.iconColor,
    this.textColor,
    this.minimumSize,
    this.iconRightSpacing,
    this.isLoading = false,
  });
  final String text;
  final String icon;
  final VoidCallback onTap;
  final double? iconHeight;
  final double? borderRadius;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? height;
  final Color? iconColor;
  final Color? textColor;
  final Size? minimumSize;
  final double? iconRightSpacing;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isLoading
          ? const WaveLoadingWidget(
              color: Colors.red,
            )
          : TextButton.icon(
              style: TextButton.styleFrom(
                  minimumSize: minimumSize,
                  backgroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius ?? 30),
                      side: BorderSide(
                          color: borderColor ?? AppColors.appDarkGrey))),
              onPressed: onTap,
              icon: Padding(
                padding: EdgeInsets.only(right: iconRightSpacing ?? 0),
                child: SvgPicture.asset(
                  icon,
                  height: iconHeight ?? 30,
                  color: iconColor,
                ),
              ),
              label: Text(text,
                  style: textStyle ??
                      TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textColor ?? Colors.white))),
    );
  }
}
