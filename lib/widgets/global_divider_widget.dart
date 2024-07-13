

import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';

class GlobalDividerWidget extends StatelessWidget {
  const GlobalDividerWidget({
    super.key,
    this.width,
    this.dividerColor,
    this.height,
  });
  final double? width;
  final Color? dividerColor;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Divider(
        height: height,
        color: dividerColor ?? AppColors.appDarkGrey,
      ),
    );
  }
}
