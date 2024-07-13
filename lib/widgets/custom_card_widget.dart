

import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget(
      {super.key,
      required this.child,
      required this.elevation,
      this.borderRadiusbottomLeft,
      this.borderRadiusbottomRight,
      this.borderRadiustopLeft,
      this.borderRadiustopRight});
  final Widget child;
  final double elevation;
  final double? borderRadiusbottomLeft;
  final double? borderRadiusbottomRight;
  final double? borderRadiustopLeft;
  final double? borderRadiustopRight;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadiustopLeft ?? 30),
              bottomRight: Radius.circular(borderRadiusbottomRight ?? 30),
              topLeft: Radius.circular(borderRadiustopLeft ?? 30),
              topRight: Radius.circular(borderRadiusbottomRight ?? 30))),
      child: child,
    );
  }
}


