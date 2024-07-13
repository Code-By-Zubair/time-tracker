


import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';

class ContainerColumsWidget extends StatelessWidget {
  const ContainerColumsWidget({
    super.key,
    required this.title,
    required this.crossAxisAlignment,
    required this.itemLength,
    required this.widgetToGenerate,
  });

  final String title;
  final CrossAxisAlignment crossAxisAlignment;
  final int itemLength;
  final Widget widgetToGenerate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.appLightGrey,
        ),
        const SizedBox(
          height: 15,
        ),
        ...List.generate(itemLength, (index) => widgetToGenerate)
      ],
    );
  }
}