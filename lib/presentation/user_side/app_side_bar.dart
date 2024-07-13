// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/helpers/navigation_helper.dart';
import 'package:time_tracker/presentation/auth_screens/login_screen.dart';
import 'package:time_tracker/presentation/user_side/dashboard/dashboard_main_screen.dart';
import 'package:time_tracker/presentation/user_side/report_module/report_screen.dart';
import 'package:time_tracker/presentation/user_side/settings_module/settings_screen.dart';
import 'package:time_tracker/presentation/user_side/support_module/support_screen.dart';
import 'package:time_tracker/presentation/user_side/task_module/task_screen.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/services/auth_service.dart';
import 'package:time_tracker/services/shared_pref_services.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/global_timetracking_text_with_icon_widget.dart';
import 'package:time_tracker/widgets/user_dashboard_sidebar_item.dart';

class AppSideBarUser extends StatefulWidget {
  const AppSideBarUser({super.key});

  @override
  State<AppSideBarUser> createState() => _AppSideBarUserState();
}

class _AppSideBarUserState extends State<AppSideBarUser> {
  SharedPrefServices sharedPrefServices = SharedPrefServices();
  AuthService authService = AuthService();
  bool isHover = false;
  List<Map<String, String>> sidebarItems = [
    {'Icon': IconImages.dashboardIcon, 'text': AppTexts.dashboard},
    {'Icon': IconImages.tasks, 'text': AppTexts.tasks},
    {'Icon': IconImages.reports, 'text': AppTexts.reports},
    {'Icon': IconImages.support, 'text': AppTexts.support},
    {'Icon': IconImages.settings, 'text': AppTexts.settings},
  ];
  List<Widget> pages = [
    const DashBoardMainScreenUserSide(),
    const TaskScreenUserSide(),
    const ReportScreenUserSide(),
    const SupportScreenUserSide(),
    const SettingsScreenUserSide(),
  ];
  @override
  void initState() {
    getPrefData();
    super.initState();
  }

  getPrefData() async {
    Provider.of<SharedPrefProvider>(context, listen: false).getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: true);
    final sharedPrefProv =
        Provider.of<SharedPrefProvider>(context, listen: false);
    final widthAndExpandCond = context.w < 900 ||
        Provider.of<UserDashBoardProvider>(context, listen: false)
                .expandDrawer ==
            false;
    return Scaffold(
      body: Row(
        children: [
          Consumer<UserDashBoardProvider>(
            builder: (context, userDashBoardProvider, child) =>
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
                          padding: EdgeInsets.only(
                              left: widthAndExpandCond ? 15 : 0),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: sidebarItems.length,
                      itemBuilder: (context, index) {
                        return USerDashboardSideBarItemWidget(
                            dashBoardProvider: userDashBoardProvider,
                            currentIndex: index,
                            onTap: () {
                              userDashBoardProvider.changePage(index);
                            },
                            sidebarItems: sidebarItems);
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
                                          if (sharedPrefProv
                                                  .data?.loginMethod ==
                                              'email') {
                                            await authService
                                                .userSignOutOfEmailAndPassword();
                                            await sharedPrefServices
                                                .removeUserData();
                                            Provider.of<SharedPrefProvider>(
                                                    context,
                                                    listen: false)
                                                .clearPrefData();
                                          } else if (sharedPrefProv
                                                  .data?.loginMethod ==
                                              'google') {
                                            try {
                                              await GoogleSignIn().disconnect();
                                              await sharedPrefServices
                                                  .removeUserData();
                                              Provider.of<SharedPrefProvider>(
                                                      context,
                                                      listen: false)
                                                  .clearPrefData();
                                            } catch (e) {
                                              print(e);
                                            }
                                          }
                                          await sharedPrefServices
                                              .removeUserData();
                                          Provider.of<SharedPrefProvider>(
                                                  context,
                                                  listen: false)
                                              .clearPrefData();
                                          userDashBoardProvider
                                              .clearController();
                                          userDashBoardProvider
                                              .stopBreakTimer();
                                          userDashBoardProvider.stopTimer();
                                          userDashBoardProvider
                                              .clearController();
                                          userDashBoardProvider.isClicked = 0;
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
          ),
          Expanded(
              child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[userDashBoardProvider.isClicked];
            },
          ))
        ],
      ),
    );
  }
}
