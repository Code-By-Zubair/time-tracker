import 'package:flutter/material.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class EnableDisableButtonRowWidget extends StatelessWidget {
  const EnableDisableButtonRowWidget({
    super.key,
    required this.checkWith,
    required this.showDefaultButton,
    required this.onEnableTap,
    required this.onDisableTap,
    required this.text,
    this.defaultButtonText,
    this.onDefaultTap,
  });
  final String checkWith;
  final bool showDefaultButton;
  final VoidCallback onEnableTap;
  final VoidCallback onDisableTap;
  final String text;
  final String? defaultButtonText;
  final VoidCallback? onDefaultTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Wrap(
            runSpacing: 20,
            children: [
              SizedBox(
                child: GlobalTextButton(
                  bachgroundColor: checkWith == 'enable'
                      ? AppColors.appPrimaryColor
                      : Colors.white,
                  buttonTextColor:
                      checkWith == 'enable' ? Colors.white : Colors.black,
                  borderColor: checkWith == 'enable'
                      ? AppColors.appPrimaryColor
                      : AppColors.appDarkGrey,
                  text: AppTexts.enable,
                  onTap: onEnableTap,
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                child: GlobalTextButton(
                  bachgroundColor: checkWith == 'enable'
                      ? Colors.white
                      : AppColors.appPrimaryColor,
                  buttonTextColor:
                      checkWith == 'enable' ? Colors.black : Colors.white,
                  borderColor: checkWith == 'enable'
                      ? AppColors.appDarkGrey
                      : AppColors.appPrimaryColor,
                  text: AppTexts.disable,
                  onTap: onDisableTap,
                  //  () => Provider.of<SettingsProvider>(
                  //         context,
                  //         listen: false)
                  //     .changeAutomaticMode('disable'),
                ),
              ),
              SizedBox(width: showDefaultButton ? 15 : 0),
              showDefaultButton
                  ? GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: defaultButtonText!.isNotEmpty
                          ? 'Default ($defaultButtonText)'
                          : AppTexts.defaultEnabled,
                      onTap: onDefaultTap)
                  : const SizedBox.shrink(),
            ],
          ),
        )
      ],
    );
  }
}
