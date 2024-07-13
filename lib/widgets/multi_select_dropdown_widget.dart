import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/widgets/multiselect_dropdown_flutter.dart';

class MultiSelectDropdownWidget extends StatelessWidget {
  const MultiSelectDropdownWidget({
    Key? key,
    required this.includeSearch,
    required this.includeSelectAll,
    this.width,
    this.boxDecoration,
    required this.itemList,
    required this.initiallySelectedList,
    required this.onChange,
    this.padding,
    this.textStyle,
    this.splashColor,
  }) : super(key: key);
  final bool includeSearch;
  final bool includeSelectAll;
  final double? width;
  final Decoration? boxDecoration;
  final List<dynamic> itemList;
  final List<dynamic> initiallySelectedList;
  final ValueChanged onChange;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: MultiSelectDropdown.simpleList(
        listTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.appDarkGrey,
        ),
        whenEmpty: 'Select options',
        checkboxFillColor: AppColors.appPrimaryColor,
        padding: padding,
        splashColor: AppColors.bgColor,
        textStyle: textStyle ??
            const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.appDarkGrey,
            ),
        includeSearch: includeSearch,
        includeSelectAll: includeSelectAll,
        width: width,
        list: itemList,
        initiallySelected: initiallySelectedList,
        onChange: onChange,
      ),
    );
  }
}
