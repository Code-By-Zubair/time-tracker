import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class UserSettingsPopupContentWidget extends StatelessWidget {
  const UserSettingsPopupContentWidget(
      {super.key,
      required this.onTapEnableTrackingWhenIdle,
      required this.onTapDisableTrackingWhenIdle,
      required this.onTapStopTrackingIdIdleXMinutes,
      required this.onTapEnableTakingSSWhileTracking,
      required this.onTapTakeSSEveryXMinutes,
      required this.onTapEnableAutomaticMode,
      required this.onTapDisableAutomaticMode,
      required this.onTapEnableStealthMode,
      required this.onTapDisableStealthMode,
      required this.onTapEnableTrackingAwayTime,
      required this.onTapWhenTrackingTrackingAwayTime,
      required this.onTapNeverAllowTrackingAwayTime,
      required this.onTapEnableSendingWarningEmail,
      required this.onTapDisableSendingWarningEmail});
  final VoidCallback onTapEnableTrackingWhenIdle;
  final VoidCallback onTapDisableTrackingWhenIdle;
  final VoidCallback onTapStopTrackingIdIdleXMinutes;
  final VoidCallback onTapEnableTakingSSWhileTracking;
  final VoidCallback onTapTakeSSEveryXMinutes;
  final VoidCallback onTapEnableAutomaticMode;
  final VoidCallback onTapDisableAutomaticMode;
  final VoidCallback onTapEnableStealthMode;
  final VoidCallback onTapDisableStealthMode;
  final VoidCallback onTapEnableTrackingAwayTime;
  final VoidCallback onTapWhenTrackingTrackingAwayTime;
  final VoidCallback onTapNeverAllowTrackingAwayTime;
  final VoidCallback onTapEnableSendingWarningEmail;
  final VoidCallback onTapDisableSendingWarningEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.stopTrackingIfIdle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.trackingWhenIdle
                            ? AppColors.appPrimaryColor
                            : Colors.white,
                        buttonTextColor: dashBaordProvider.trackingWhenIdle
                            ? Colors.white
                            : Colors.black,
                        borderColor: dashBaordProvider.trackingWhenIdle
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableTrackingWhenIdle),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.trackingWhenIdle
                            ? Colors.white
                            : AppColors.appPrimaryColor,
                        buttonTextColor: dashBaordProvider.trackingWhenIdle
                            ? Colors.black
                            : Colors.white,
                        borderColor: dashBaordProvider.trackingWhenIdle
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.disable,
                        onTap: onTapDisableTrackingWhenIdle),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.stopTrackingIdIdleXMinutes,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  height: 40,
                  width: 150,
                  child: RoundedTextField(
                      hintText: 'Minutes',
                      enableBorder: true,
                      borderColor: AppColors.appLightGrey,
                      textFieldColor: Colors.white,
                      keyboardType: TextInputType.number,
                      obscureText: false),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  height: 35,
                  child: GlobalTextButton(
                      bachgroundColor: AppColors.appPrimaryColor,
                      buttonTextColor: Colors.white,
                      text: AppTexts.save,
                      onTap: onTapStopTrackingIdIdleXMinutes),
                ),
                const SizedBox(width: 70)
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.takeSSWhileTracking,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.takeSSWhileTracking
                            ? AppColors.appPrimaryColor
                            : Colors.white,
                        buttonTextColor: dashBaordProvider.takeSSWhileTracking
                            ? Colors.white
                            : Colors.black,
                        borderColor: dashBaordProvider.takeSSWhileTracking
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableTakingSSWhileTracking),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.takeSSWhileTracking
                            ? Colors.white
                            : AppColors.appPrimaryColor,
                        buttonTextColor: dashBaordProvider.takeSSWhileTracking
                            ? Colors.black
                            : Colors.white,
                        borderColor: dashBaordProvider.takeSSWhileTracking
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.disable,
                        onTap: () {
                          Provider.of<DashBoardProvider>(context, listen: false)
                              .enableTakingSSWhileTracking(false);
                        }),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.takeSSEveryXMinutes,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  height: 40,
                  width: 150,
                  child: RoundedTextField(
                      hintText: 'Minutes',
                      borderColor: AppColors.appLightGrey,
                      enableBorder: true,
                      textFieldColor: Colors.white,
                      keyboardType: TextInputType.number,
                      obscureText: false),
                ),
                const SizedBox(width: 15),
                SizedBox(
                  height: 35,
                  child: GlobalTextButton(
                      bachgroundColor: AppColors.appPrimaryColor,
                      buttonTextColor: Colors.white,
                      text: AppTexts.save,
                      onTap: onTapTakeSSEveryXMinutes),
                ),
                const SizedBox(width: 70)
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.automaticMode,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.automaticMode
                            ? AppColors.appPrimaryColor
                            : Colors.white,
                        buttonTextColor: dashBaordProvider.automaticMode
                            ? Colors.white
                            : Colors.black,
                        borderColor: dashBaordProvider.automaticMode
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableAutomaticMode),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.automaticMode
                            ? Colors.white
                            : AppColors.appPrimaryColor,
                        buttonTextColor: dashBaordProvider.automaticMode
                            ? Colors.black
                            : Colors.white,
                        borderColor: dashBaordProvider.automaticMode
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.disable,
                        onTap: onTapDisableAutomaticMode),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.stealthMode,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.stealthMode
                            ? AppColors.appPrimaryColor
                            : Colors.white,
                        buttonTextColor: dashBaordProvider.stealthMode
                            ? Colors.white
                            : Colors.black,
                        borderColor: dashBaordProvider.stealthMode
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableStealthMode),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor: dashBaordProvider.stealthMode
                            ? Colors.white
                            : AppColors.appPrimaryColor,
                        buttonTextColor: dashBaordProvider.stealthMode
                            ? Colors.black
                            : Colors.white,
                        borderColor: dashBaordProvider.stealthMode
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.disable,
                        onTap: onTapDisableStealthMode),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.allowTrackingAwayTime,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor:
                            dashBaordProvider.trackingAwayTimeTrack ==
                                    AppTexts.enable
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                        buttonTextColor:
                            dashBaordProvider.trackingAwayTimeTrack ==
                                    AppTexts.enable
                                ? Colors.white
                                : Colors.black,
                        borderColor: dashBaordProvider.trackingAwayTimeTrack ==
                                AppTexts.enable
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableTrackingAwayTime),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor:
                            dashBaordProvider.trackingAwayTimeTrack ==
                                    AppTexts.whenTracking
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                        buttonTextColor:
                            dashBaordProvider.trackingAwayTimeTrack ==
                                    AppTexts.whenTracking
                                ? Colors.white
                                : Colors.black,
                        borderColor: dashBaordProvider.trackingAwayTimeTrack ==
                                AppTexts.whenTracking
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.whenTracking,
                        onTap: onTapWhenTrackingTrackingAwayTime),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor:
                            dashBaordProvider.trackingAwayTimeTrack !=
                                    AppTexts.never
                                ? Colors.white
                                : AppColors.appPrimaryColor,
                        buttonTextColor:
                            dashBaordProvider.trackingAwayTimeTrack !=
                                    AppTexts.never
                                ? Colors.black
                                : Colors.white,
                        borderColor: dashBaordProvider.trackingAwayTimeTrack !=
                                AppTexts.never
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.never,
                        onTap: onTapNeverAllowTrackingAwayTime),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Divider(
            color: AppColors.appDarkGrey,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              AppTexts.sendWarningEmailsToUSers,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Consumer<DashBoardProvider>(
              builder: (context, dashBaordProvider, child) => Row(
                children: [
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor:
                            dashBaordProvider.sendWarningEmailsToUSers
                                ? AppColors.appPrimaryColor
                                : Colors.white,
                        buttonTextColor:
                            dashBaordProvider.sendWarningEmailsToUSers
                                ? Colors.white
                                : Colors.black,
                        borderColor: dashBaordProvider.sendWarningEmailsToUSers
                            ? AppColors.appPrimaryColor
                            : AppColors.appDarkGrey,
                        text: AppTexts.enable,
                        onTap: onTapEnableSendingWarningEmail),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    child: GlobalTextButton(
                        bachgroundColor:
                            dashBaordProvider.sendWarningEmailsToUSers
                                ? Colors.white
                                : AppColors.appPrimaryColor,
                        buttonTextColor:
                            dashBaordProvider.sendWarningEmailsToUSers
                                ? Colors.black
                                : Colors.white,
                        borderColor: dashBaordProvider.sendWarningEmailsToUSers
                            ? AppColors.appDarkGrey
                            : AppColors.appPrimaryColor,
                        text: AppTexts.disable,
                        onTap: onTapDisableSendingWarningEmail),
                  ),
                  const SizedBox(width: 15),
                  GlobalTextButton(
                      bachgroundColor: Colors.white,
                      borderColor: AppColors.appDarkGrey,
                      text: AppTexts.defaultEnabled,
                      onTap: () {})
                ],
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
          child: Divider(
            color: AppColors.appDarkGrey,
          ),
        ),
        GlobalTextButton(
            bachgroundColor: AppColors.appPrimaryColor,
            buttonTextColor: Colors.white,
            text: AppTexts.close,
            onTap: () => Navigator.pop(context))
      ],
    );
  }
}
