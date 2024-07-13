import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/app_usage_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/app_usage_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/attendance_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/attendance_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/location_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/productivity_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/productivity_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/screenshot_tab_bottom_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/screenshot_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/task_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/task_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/user_tab_below_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/users_tab_upper_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/setting_screen.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/reports_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:time_tracker/widgets/global_text_button.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with WidgetsBindingObserver {
  ScrollController scrollController = ScrollController();

  List items = [
    {'icons': IconImages.threeUsers, 'text': AppTexts.users},
    {'icons': IconImages.ssCapture, 'text': AppTexts.screenShots},
    {'icons': IconImages.tasks, 'text': AppTexts.tasks},
    {'icons': IconImages.appUsageRound, 'text': AppTexts.appUsage},
    {'icons': IconImages.userWithTick, 'text': AppTexts.attendance},
    {'icons': IconImages.productivity, 'text': AppTexts.productivity},
    {'icons': IconImages.location, 'text': AppTexts.location},
  ];
  List<String> containers = ['con1', 'cont2', 'cont3'];
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
      final v = Provider.of<ReportProvider>(context, listen: false).selectedTab;
      scrollController.animateTo(v * 60,
          duration: const Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final dashBoardProvider =
        Provider.of<DashBoardProvider>(context, listen: false);
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
        child: Column(
          children: [
            GlobalAppBarWithProfile(
              title: 'Reports',
              isSearchfieldShow: false,
              workTodayRightPad: 100,
              titleRightPadding: 50,
              onStartBtn: () => userDashBoardProvider.startTimer(),
              onFinishBtn: () => userDashBoardProvider.stopTimer(),
              onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
              onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
              showTitle: true,
            ),
            const SizedBox(height: 50),
            Consumer<ReportProvider>(
              builder: (context, reportProvider, child) => Builder(
                builder: (context) {
                  Widget selectedTabData;
                  switch (reportProvider.selectedTab) {
                    case 0:
                      selectedTabData = const UserTabUpperContent();
                      break;
                    case 1:
                      selectedTabData = const ScreenShotTabUpperContent();
                      break;
                    case 2:
                      selectedTabData = const TaskTabUpperContent();
                      break;
                    case 3:
                      selectedTabData = const AppUsageTabUpperContent();
                      break;
                    case 4:
                      selectedTabData = const AttendanceTabUpperContent();
                      break;
                    case 5:
                      selectedTabData = const ProductivityTabUpperContent();
                      break;
                    case 6:
                      selectedTabData = const LocationTabUpperContent();
                      break;
                    default:
                      selectedTabData = const SizedBox.shrink();
                  }

                  return selectedTabData;
                },
              ),
            ),
            const SizedBox(height: 60),
            Consumer<ReportProvider>(
              builder: (context, reportProvider, child) => Stack(
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
                    child: ListView.builder(
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: CustomTabItemWidget(
                            providerSelectedTab: reportProvider.selectedTab,
                            icon: items[index]['icons'],
                            text: items[index]['text'],
                            selectedTab: index,
                            onTabPress: () {
                              Provider.of<ReportProvider>(context,
                                      listen: false)
                                  .changePageTab(index);
                              Provider.of<ReportProvider>(context,
                                      listen: false)
                                  .changeAppbarTitle(items[index]['text']);

                              if (reportProvider.selectedTab == 0) {
                                moveList('start', scrollController);
                              } else if (reportProvider.selectedTab == 6) {
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
            const SizedBox(height: 50),
            Consumer<ReportProvider>(
              builder: (context, reportProv, child) => Builder(
                builder: (context) {
                  Widget selectedTabData;
                  switch (reportProv.selectedTab) {
                    case 0:
                      selectedTabData = const UserTabBelowContent(
                        isAdminSide: true,
                        containers: ['1', '2', '3'],
                      );

                      break;
                    case 1:
                      selectedTabData = const ScreenShotTabBottomContent();

                      break;
                    case 2:
                      selectedTabData = const TaskTabBellowContent(
                        isAdminSide: true,
                      );
                      break;
                    case 3:
                      selectedTabData = AppUsageTabBellowContent(
                        isAdminSide: true,
                        usageTabIndex: reportProvider.selectedAppUsageTab,
                        onByUserTap: () {
                          Provider.of<ReportProvider>(context, listen: false)
                              .changeSelectedAppUsageTab(0);
                        },
                        onByAppTap: () {
                          Provider.of<ReportProvider>(context, listen: false)
                              .changeSelectedAppUsageTab(1);
                        },
                      );
                      break;
                    case 4:
                      selectedTabData = const AttendanceTabBellowContent();
                      break;
                    case 5:
                      selectedTabData = const ProductivityTabBellowContent();
                      break;
                    case 6:
                      selectedTabData = const LocationTabBellowContent();
                      break;
                    default:
                      selectedTabData = const SizedBox.shrink();
                  }

                  return selectedTabData;
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}

class LocationTabBellowContent extends StatefulWidget {
  const LocationTabBellowContent({super.key});

  @override
  State<LocationTabBellowContent> createState() =>
      _LocationTabBellowContentState();
}

class _LocationTabBellowContentState extends State<LocationTabBellowContent> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 500,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(51.509364, -0.128928),
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  // minNativeZoom: -0,
                  // minZoom: 1000,
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                const CircleLayer(
                  circles: [],
                )
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          // height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 88,
                    height: 42,
                    child: GlobalTextButton(
                      text: 'Map',
                      bachgroundColor: AppColors.appPrimaryColor,
                      borderColor: AppColors.appPrimaryColor,
                      buttonTextColor: Colors.white,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 30),
                  SizedBox(
                    width: 88,
                    height: 42,
                    child: GlobalTextButton(
                      text: 'Satellite',
                      bachgroundColor: Colors.transparent,
                      borderColor: AppColors.appPrimaryColor,
                      buttonTextColor: AppColors.appPrimaryColor,
                      onTap: () {},
                    ),
                  )
                ],
              ),
              const Text(
                'Google Maps',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.appPrimaryColor),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_rounded,
                        size: 30,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 30),
                  IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: AppColors.appDarkGrey),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.remove_rounded,
                        size: 30,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
