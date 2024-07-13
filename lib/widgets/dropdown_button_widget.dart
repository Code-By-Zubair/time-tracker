import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tracker/constants/app_colors.dart';

import 'rounded_text_field.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  const DropDownButtonWidget({
    super.key,
    this.selectedItem,
    required this.items,
    required this.onChanged,
    this.width,
    this.leftPadding,
    this.rightPadding,
    this.xOffset,
    this.yOffset,
    this.bottomPadding,
    this.topPadding,
    this.hint,
    required this.displayValueCallback,
    this.selectedItemBuilder,
    this.validator,
    this.errorText,
    this.filled = false,
  });

  final T? selectedItem;
  final List<T> items;
  final ValueChanged onChanged;
  final double? width;
  final double? leftPadding;
  final double? rightPadding;
  final double? bottomPadding;
  final double? topPadding;
  final double? xOffset;
  final double? yOffset;
  final String? hint;
  final String Function(T item) displayValueCallback;
  final List<Widget> Function(BuildContext context)? selectedItemBuilder;
  final String? Function(T?)? validator;
  final String? errorText;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          borderRadius: BorderRadius.circular(5),
          decoration: inputDecoration(hint ?? '', errorText ?? '', filled),
          hint: Text(hint ?? ''),
          alignment: Alignment.centerLeft,
          value: selectedItem,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.appDarkGrey,
          ),
          selectedItemBuilder: selectedItemBuilder,
          items: items
              .map((T item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      displayValueCallback(item),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.appDarkGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: onChanged),
    );
  }

  inputDecoration(String hintText, String errorText, bool? filled) {
    return InputDecoration(
      filled: filled,
      fillColor: AppColors.appDarkGrey.withOpacity(.1),
      hintText: hintText,
      errorText: errorText.isNotEmpty && errorText != '' ? errorText : null,
      errorStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      alignLabelWithHint: true,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        // color: labelTextColor,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        // color: labelTextColor,
      ),
      hintStyle: GoogleFonts.inter(
          // color: hintTextColor,
          ),
      contentPadding: const EdgeInsets.only(
        right: 15,
        left: 25,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
        borderSide: const BorderSide(
          color: AppColors.appDarkGrey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
        borderSide: const BorderSide(
          color: AppColors.appDarkGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: const BorderSide(
          color: AppColors.appDarkGrey,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          25,
        ),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }
}
