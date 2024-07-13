
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);

    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
          child: Column(
            children: [
              GlobalAppBarWithProfile(
                  title: 'User Setting',
                  isSearchfieldShow: false,
                  onStartBtn: () => userDashBoardProvider.startTimer(),
                  onFinishBtn: () => userDashBoardProvider.stopTimer(),
                  onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
                  onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                  titleRightPadding: context.w > 1050 ? 0 : 100,
                  workTodayRightPad: 100,
                  titleLefPadding: 0,
                  showTitle: true),
              const SizedBox(height: 65),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Preferences (James Williams)',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.appPrimaryColor),
                    ),
                    const SizedBox(height: 30),
                    Consumer<DashBoardProvider>(
                      builder: (context, dashBaordProvider, child) => Container(
                        margin:
                            EdgeInsets.only(right: context.w < 1000 ? 0 : 270),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Receive Weekly Report',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      width: 72,
                                      child: GlobalTextButton(
                                          bachgroundColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? AppColors.appPrimaryColor
                                              : Colors.white,
                                          buttonTextColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? Colors.white
                                              : Colors.black,
                                          borderColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? AppColors.appPrimaryColor
                                              : AppColors.appDarkGrey,
                                          text: 'Enable',
                                          onTap: () {
                                            Provider.of<DashBoardProvider>(
                                                    context,
                                                    listen: false)
                                                .enableWeeklyReport(true);
                                          }),
                                    ),
                                    const SizedBox(width: 15),
                                    SizedBox(
                                      height: 32,
                                      width: 72,
                                      child: GlobalTextButton(
                                          bachgroundColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? Colors.white
                                              : AppColors.appPrimaryColor,
                                          buttonTextColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? Colors.black
                                              : Colors.white,
                                          borderColor: dashBaordProvider
                                                  .userWeeklyReportEnable
                                              ? AppColors.appDarkGrey
                                              : AppColors.appPrimaryColor,
                                          text: 'Disable',
                                          onTap: () {
                                            Provider.of<DashBoardProvider>(
                                                    context,
                                                    listen: false)
                                                .enableWeeklyReport(false);
                                          }),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Receive Daily Report',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      width: 72,
                                      child: GlobalTextButton(
                                          bachgroundColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? AppColors.appPrimaryColor
                                              : Colors.white,
                                          buttonTextColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? Colors.white
                                              : Colors.black,
                                          borderColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? AppColors.appPrimaryColor
                                              : AppColors.appDarkGrey,
                                          text: 'Enable',
                                          onTap: () {
                                            Provider.of<DashBoardProvider>(
                                                    context,
                                                    listen: false)
                                                .enableDailyReport(true);
                                          }),
                                    ),
                                    const SizedBox(width: 15),
                                    SizedBox(
                                      height: 32,
                                      width: 72,
                                      child: GlobalTextButton(
                                          bachgroundColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? Colors.white
                                              : AppColors.appPrimaryColor,
                                          buttonTextColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? Colors.black
                                              : Colors.white,
                                          borderColor: dashBaordProvider
                                                  .userDailyReportEnable
                                              ? AppColors.appDarkGrey
                                              : AppColors.appPrimaryColor,
                                          text: 'Disable',
                                          onTap: () {
                                            Provider.of<DashBoardProvider>(
                                                    context,
                                                    listen: false)
                                                .enableDailyReport(false);
                                          }),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
