import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/access_to_report_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/email_reports_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/manual_time_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/project_and_task_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/screen_capture_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/shifts_tab_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/tracking_tab_content.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/settings_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with WidgetsBindingObserver {
  List items = [
    {'icons': IconImages.location, 'text': AppTexts.tracking},
    {'icons': IconImages.ssCapture, 'text': AppTexts.screenCapture},
    {'icons': IconImages.accessToReports, 'text': AppTexts.accessToReports},
    {'icons': IconImages.shifts, 'text': AppTexts.shifts},
    {'icons': IconImages.projecTask, 'text': AppTexts.projectsandTasks},
    {'icons': IconImages.message, 'text': AppTexts.emailReports},
    {'icons': IconImages.clock, 'text': AppTexts.manualTime},
  ];

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final v =
          Provider.of<SettingsProvider>(context, listen: false).selectedTab;
      scrollController.animateTo(v * 60,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlobalAppBarWithProfile(
              title: AppTexts.settings,
             
              isSearchfieldShow: false,
              onStartBtn: () => userDashBoardProvider.startTimer(),
              onFinishBtn: () => userDashBoardProvider.stopTimer(),
              onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
              onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
              titleRightPadding: context.w > 900 ? 0 : 150,
              workTodayRightPad: context.w > 900 ? context.w * 0.10 : 200,
              showTitle: true,
            ),
            const SizedBox(height: 65),
            Consumer<SettingsProvider>(
              builder: (context, settingsProvider, child) => Stack(
                alignment: Alignment.bottomLeft,
                fit: StackFit.loose,
                children: [
                  const SizedBox(
                    child: Divider(
                      color: AppColors.appDarkGrey,
                    ),
                  ),
                  SizedBox(
                    height: 64,
                    // width: 500,Dra
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: CustomTabItemWidget(
                            providerSelectedTab: settingsProvider.selectedTab,
                            icon: items[index]['icons'],
                            text: items[index]['text'],
                            selectedTab: index,
                            onTabPress: () {
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .changeTab(index);
                              if (settingsProvider.selectedTab == 0) {
                                moveList('start', scrollController);
                              } else if (settingsProvider.selectedTab == 6) {
                                moveList('down', scrollController);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Consumer<SettingsProvider>(
                builder: (context, settingsProvider, child) {
                  Widget selectedContent;

                  switch (settingsProvider.selectedTab) {
                    case 0:
                      selectedContent = TrackingTabContent();
                      break;
                    case 1:
                      selectedContent = ScreenCaptureTabContent();
                      break;
                    case 2:
                      selectedContent = AccessToReportsTabContent();
                      break;
                    case 3:
                      selectedContent = ShiftsTabContent();
                      break;
                    case 4:
                      selectedContent = ProjectAndTaskContentTab();
                      break;
                    case 5:
                      selectedContent = EmailReportsContentTab(
                        settingsProvider: settingsProvider,
                      );
                      break;
                    case 6:
                      selectedContent = ManualTimeContentTab();
                      break;
                    default:
                      selectedContent = const SizedBox.shrink();
                  }

                  return selectedContent;
                },
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    ));
  }
}

class CustomTabItemWidget extends StatefulWidget {
  const CustomTabItemWidget({
    super.key,
    required this.selectedTab,
    required this.onTabPress,
    required this.icon,
    required this.text,
    required this.providerSelectedTab,
  });
  final int providerSelectedTab;
  final int selectedTab;
  final VoidCallback onTabPress;
  final String icon;
  final String text;

  @override
  State<CustomTabItemWidget> createState() => _CustomTabItemWidgetState();
}

class _CustomTabItemWidgetState extends State<CustomTabItemWidget> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      onHover: (value) {
        setState(() {
          isHover = value;
        });
      },
      onTap: widget.onTabPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: isHover ? 1.1 : 1,
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  height: 15,
                  color: widget.providerSelectedTab == widget.selectedTab
                      ? AppColors.appPrimaryColor
                      : AppColors.appDarkGrey,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: widget.providerSelectedTab == widget.selectedTab
                          ? AppColors.appPrimaryColor
                          : AppColors.appDarkGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          widget.providerSelectedTab == widget.selectedTab
              ? SizedBox(
                  width: 135,
                  child: Divider(
                    color: widget.providerSelectedTab == widget.selectedTab
                        ? AppColors.appPrimaryColor
                        : AppColors.appDarkGrey,
                    thickness: 2,
                  ))
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
