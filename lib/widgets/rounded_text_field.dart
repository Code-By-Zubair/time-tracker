import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_tracker/constants/app_colors.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField(
      {super.key,
      required this.keyboardType,
      required this.obscureText,
      this.textFieldColor,
      this.icon = '',
      this.hintText,
      this.hintTextStyle,
      this.showBorder = false,
      this.textController,
      this.borderColor,
      this.enableBorder = false,
      this.labelText,
      this.labelTextStyle,
      this.inputFormatters,
      this.filled,
      this.iconHeight,
      this.hintTextColor,
      this.errorText = '',
      this.onValueChanged,
      this.validator,
      this.contentPadding,
      this.labelTextColor,
      this.readOnly = false,
      this.maxLength});
  final TextInputType keyboardType;
  final bool obscureText;
  final Color? textFieldColor;
  final String icon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final bool showBorder;
  final TextEditingController? textController;

  final Color? borderColor;
  final bool enableBorder;
  final String? labelText;
  final TextStyle? labelTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged? onValueChanged;
  final String? Function(String?)? validator;
  final bool? filled;
  final double? iconHeight;
  final Color? hintTextColor;
  final String errorText;
  final EdgeInsets? contentPadding;
  final Color? labelTextColor;
  final bool readOnly;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: textController,
      onChanged: onValueChanged,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.appDarkGrey,
      ),
      obscuringCharacter: '*',
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      maxLength: maxLength,
      decoration: inputDecoration(
        hintText: hintText ?? '',
        label: labelText,
        radius: 30,
        fillColor: textFieldColor,
        filled: filled,
        enableBorderColor: borderColor,
        labelTextColor: labelTextColor,
        errorText: errorText,
      ).copyWith(
        contentPadding: contentPadding,
        prefixIcon: icon.isNotEmpty && icon != ''
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  icon,
                ),
              )
            : null,
      ),
    );
  }
}

InputDecoration inputDecoration({
  String? label,
  required String hintText,
  double radius = 30,
  Color? fillColor,
  bool? filled,
  Color hintTextColor = AppColors.appDarkGrey,
  Color? enableBorderColor,
  Color? labelTextColor,
  required String errorText,
}) =>
    InputDecoration(
      fillColor: fillColor ?? AppColors.appDarkGrey.withOpacity(0.2),
      filled: filled,
      hintText: hintText,
      labelText: label,
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
        color: labelTextColor,
      ),
      floatingLabelStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        color: labelTextColor,
      ),
      hintStyle: GoogleFonts.inter(
        color: hintTextColor,
      ),
      contentPadding: const EdgeInsets.only(
        right: 15,
        left: 25,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        borderSide: BorderSide(
          color: enableBorderColor ?? AppColors.appDarkGrey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          color: AppColors.appDarkGrey,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
