// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/helpers/navigation_helper.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/dashboard_main_content_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/productivity_module/productivity_screen.dart';

import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/reports_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/setting_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/support_module/support_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/profiles_module/profiles_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/tasks_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/user_management_module/user_management_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/user_management_module/user_settings_screen.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/presentation/auth_screens/login_screen.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/services/auth_service.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/dashboard_sidebar_item_widget.dart';
import 'package:time_tracker/widgets/global_timetracking_text_with_icon_widget.dart';

class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  bool isHover = false;
  List<Map<String, String>> sidebarItems = [
    {'Icon': IconImages.dashboardIcon, 'text': AppTexts.dashboard},
    {'Icon': IconImages.threeUsers, 'text': AppTexts.userManagement},
    {'Icon': IconImages.productivity, 'text': AppTexts.productivity},
    {'Icon': IconImages.tasks, 'text': AppTexts.tasks},
    {'Icon': IconImages.reports, 'text': AppTexts.reports},
    {'Icon': IconImages.profile, 'text': AppTexts.profile},
    {'Icon': IconImages.support, 'text': AppTexts.support},
    {'Icon': IconImages.settings, 'text': AppTexts.settings},
  ];
  List<Widget> pages = [
    const DashboardMainContentScreen(),
    const UserManagementScreen(),
    const ProductivityScreen(),
    const TasksScreen(),
    const ReportsScreen(),
    const ProfilesScreen(),
    const SupportScreen(),
    const SettingsScreen(),
    const UserSettings(),
  ];
  @override
  Widget build(BuildContext context) {
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: true);
    final widthAndExpandCond =
        context.w < 900 || dashBoardProvider.expandDrawer == false;
    return Scaffold(
      body: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: AppColors.lightBlack,
            constraints: BoxConstraints(
              minWidth: widthAndExpandCond ? 100 : 250,
              maxWidth: widthAndExpandCond ? 100 : 250,
            ),
            child: Column(
              children: [
                const SizedBox(height: 100),
                widthAndExpandCond
                    ? Padding(
                        padding:
                            EdgeInsets.only(left: widthAndExpandCond ? 15 : 0),
                        child: SvgPicture.asset(IconImages.radar))
                    : Padding(
                        padding: EdgeInsets.only(left: context.w * 0.02),
                        child: const GlobalTimeTrackingTextWithIcon(
                          mainAxisAlignment: MainAxisAlignment.start,
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: sidebarItems.length,
                    itemBuilder: (context, index) {
                      return SideBarItemWidget(
                        dashBoardProvider: dashBoardProvider,
                        currentIndex: index,
                        onTap: () {
                          dashBoardProvider.changePage(index);
                        },
                        sidebarItems: sidebarItems,
                      );
                    },
                  ),
                ),
                Align(
                  alignment: widthAndExpandCond
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: context.w * 0.01),
                    child: SizedBox(
                      height: 40,
                      child: TextButton.icon(
                        icon: const Icon(Icons.logout),
                        label: widthAndExpandCond
                            ? const SizedBox.shrink()
                            : const Text('   Logout'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Are you sure, you want to logout?',
                                  ),
                                ),
                                actions: [
                                  SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.appPrimaryColor,
                                          foregroundColor: Colors.white),
                                      child: const Text('Logout'),
                                      onPressed: () async {
                                        if (Provider.of<SharedPrefProvider>(
                                                    context,
                                                    listen: false)
                                                .data
                                                ?.loginMethod ==
                                            'email') {
                                          AuthService()
                                              .userSignOutOfEmailAndPassword();
                                        } else {
                                          AuthService().userSignOutfromGoogle();
                                        }
                                        await SharedPrefServices()
                                            .removeUserData();
                                        Provider.of<UserDashBoardProvider>(
                                                context,
                                                listen: false)
                                            .clearController();
                                        Provider.of<UserDashBoardProvider>(
                                                context,
                                                listen: false)
                                            .stopBreakTimer();
                                        Provider.of<UserDashBoardProvider>(
                                                context,
                                                listen: false)
                                            .stopTimer();
                                        dashBoardProvider.isClicked = 0;
                                        gotoNextPageRemoveUntill(
                                            context, const LoginScreen());
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Expanded(
              child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[dashBoardProvider.isClicked];
            },
          ))
        ],
      ),
    );
  }
}
