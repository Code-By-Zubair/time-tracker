import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/app_usage_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/attendance_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/productivity_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/screenshot_tab_bottom_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/task_tab_bellow_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/reports_module/tabs/user_tab_below_content.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/setting_screen.dart';
import 'package:time_tracker/providers/report_provider_user_side.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class ReportScreenUserSide extends StatefulWidget {
  const ReportScreenUserSide({super.key});

  @override
  State<ReportScreenUserSide> createState() => _ReportScreenUserSide();
}

class _ReportScreenUserSide extends State<ReportScreenUserSide>
    with WidgetsBindingObserver {
  TextEditingController searchUserController = TextEditingController();
  ScrollController scrollController = ScrollController();
  DateTime? picked;
  DateTimeRange? selectedDateRange;
  String selectedTeam = 'Team';
  String selectedSortType = 'Name';
  String selectedType = 'Ascending';
  String selectedProject = 'Got Stuck';
  String selectedSprint = '1 Week';
  String selectedUser = 'Ali';
  List<String> selectedTypeList = ['Ascending', 'Descending'];
  List<String> teams = ['App Team', 'Flutter Team'];
  List<String> projects = ['Got Stuck', 'Time Tracker'];
  List<String> sortByList = ['Name', 'Age'];
  List<String> sprintList = ['1 Week', '2 Weeks'];
  List<String> userList = ['Ali', 'Raza'];
  List items = [
    {'icons': IconImages.threeUsers, 'text': AppTexts.users},
    {'icons': IconImages.ssCapture, 'text': AppTexts.screenShots},
    {'icons': IconImages.tasks, 'text': AppTexts.tasks},
    {'icons': IconImages.appUsageRound, 'text': AppTexts.appUsage},
    {'icons': IconImages.userWithTick, 'text': AppTexts.attendance},
    {'icons': IconImages.productivity, 'text': AppTexts.productivity},
  ];

  String _formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime.toLocal());
  }

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
      final v = Provider.of<ReportProviderUserSide>(context, listen: false)
          .selectedTab;
      scrollController.animateTo(
        v * 60,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
          child: Column(
            children: [
              GlobalAppBarWithProfile(
                title: AppTexts.reports, //,
                isSearchfieldShow: false,
                onStartBtn: () => userDashBoardProvider.startTimer(),
                onFinishBtn: () => userDashBoardProvider.stopTimer(),
                onMenuTap: () => userDashBoardProvider.expandDrawerFunc(),
                onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                titleRightPadding: context.w < 900 ? 150 : 0,
                showTitle: true,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 15,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          AppTexts.search,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: boxDecorationForContainer(),
                          width: 250,
                          height: 40,
                          child: RoundedTextField(
                            borderColor: Colors.white,
                            textController: searchUserController,
                            hintText: 'Search',
                            keyboardType: TextInputType.name,
                            obscureText: false,
                            textFieldColor: Colors.white,
                            icon: IconImages.search,
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'All Team',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: 250,
                          decoration: boxDecorationForContainer(),
                          child: MultiSelectDropdownWidget(
                            width: 250,
                            splashColor: Colors.transparent,
                            includeSearch: false,
                            includeSelectAll: true,
                            initiallySelectedList: const [],
                            boxDecoration: boxDecorationForContainer(),
                            itemList: teams,
                            onChange: (value) {},
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          AppTexts.dateRange,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: 250,
                          decoration: boxDecorationForContainer(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: selectedDateRange != null
                                      ? Text(
                                          '${_formatDate(selectedDateRange!.start)} - ${_formatDate(selectedDateRange!.end)}')
                                      : const Text(
                                          'Nov 15,2023 - Dec 22,2023')),
                              IconButton(
                                onPressed: () async {
                                  selectedDateRange =
                                      await selectDateRange(context);
                                  setState(() {});
                                },
                                icon: SvgPicture.asset(
                                  IconImages.calender,
                                  color: AppColors.appDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: SizedBox(
                        height: 40,
                        width: 122,
                        child: GlobalTextButton(
                          text: 'Generate',
                          bachgroundColor: AppColors.appPrimaryColor,
                          buttonTextColor: Colors.white,
                          onTap: () {},
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Consumer<ReportProviderUserSide>(
                builder: (context, reportProviderUserSide, child) {
                  return reportProviderUserSide.selectedTab == 0
                      ? SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    AppTexts.sortBy,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: boxDecorationForContainer(),
                                    child: MultiSelectDropdownWidget(
                                      width: 250,
                                      splashColor: Colors.transparent,
                                      includeSearch: false,
                                      includeSelectAll: true,
                                      initiallySelectedList: const [],
                                      boxDecoration:
                                          boxDecorationForContainer(),
                                      itemList: sortByList,
                                      onChange: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(''),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: boxDecorationForContainer(),
                                    child: MultiSelectDropdownWidget(
                                      width: 250,
                                      splashColor: Colors.transparent,
                                      includeSearch: false,
                                      includeSelectAll: true,
                                      initiallySelectedList: const [],
                                      boxDecoration:
                                          boxDecorationForContainer(),
                                      itemList: selectedTypeList,
                                      onChange: (value) {},
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              Consumer<ReportProviderUserSide>(
                builder: (context, reportProviderUserSide, child) {
                  return reportProviderUserSide.selectedTab == 2
                      ? SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: boxDecorationForContainer(),
                                    child: DropDownButtonWidget(
                                      displayValueCallback: (item) => 'jdfdf',
                                      width: 250,
                                      items: projects,
                                      selectedItem: selectedProject,
                                      yOffset: -10,
                                      leftPadding: 10,
                                      rightPadding: 10,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: boxDecorationForContainer(),
                                    child: DropDownButtonWidget(
                                      displayValueCallback: (item) => 'jdfdf',
                                      width: 250,
                                      items: sprintList,
                                      selectedItem: selectedSprint,
                                      yOffset: -10,
                                      leftPadding: 10,
                                      rightPadding: 10,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text('Filter By Users'),
                                  const SizedBox(height: 10),
                                  Container(
                                    height: 40,
                                    width: 250,
                                    decoration: boxDecorationForContainer(),
                                    child: DropDownButtonWidget(
                                      displayValueCallback: (item) => 'jdfdf',
                                      width: 250,
                                      items: userList,
                                      selectedItem: selectedUser,
                                      yOffset: -10,
                                      leftPadding: 10,
                                      rightPadding: 10,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
              const SizedBox(
                height: 60,
              ),
              Consumer<ReportProviderUserSide>(
                builder: (context, reportProviderUserSide, child) => Stack(
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
                              providerSelectedTab:
                                  reportProviderUserSide.selectedTab,
                              icon: items[index]['icons'],
                              text: items[index]['text'],
                              selectedTab: index,
                              onTabPress: () {
                                Provider.of<ReportProviderUserSide>(context,
                                        listen: false)
                                    .changeSelectedTab(index);
                                if (reportProviderUserSide.selectedTab == 0) {
                                  moveList('start', scrollController);
                                } else if (reportProviderUserSide.selectedTab ==
                                    6) {
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
              const SizedBox(
                height: 40,
              ),
              Builder(
                builder: (context) {
                  Widget selectedTabData;
                  switch (Provider.of<ReportProviderUserSide>(
                    context,
                    listen: true,
                  ).selectedTab) {
                    case 0:
                      selectedTabData = const UserTabBelowContent(
                        isAdminSide: false,
                        containers: ['1', '2', '3'],
                      );
                      break;
                    case 1:
                      selectedTabData = const ScreenShotTabBottomContent();
                      break;
                    case 2:
                      selectedTabData = const TaskTabBellowContent(
                        isAdminSide: false,
                      );
                      break;
                    case 3:
                      selectedTabData = AppUsageTabBellowContent(
                        isAdminSide: false,
                        usageTabIndex: Provider.of<ReportProviderUserSide>(
                          context,
                          listen: true,
                        ).appUsageTab,
                        onByUserTap: () {
                          Provider.of<ReportProviderUserSide>(
                            context,
                            listen: false,
                          ).changeAppUsageTab(0);
                        },
                        onByAppTap: () {
                          Provider.of<ReportProviderUserSide>(
                            context,
                            listen: false,
                          ).changeAppUsageTab(1);
                        },
                      );
                      break;
                    case 4:
                      selectedTabData = const AttendanceTabBellowContent();
                      break;
                    case 5:
                      selectedTabData = const ProductivityTabBellowContent();
                      break;

                    default:
                      selectedTabData = const SizedBox.shrink();
                  }

                  return selectedTabData;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
