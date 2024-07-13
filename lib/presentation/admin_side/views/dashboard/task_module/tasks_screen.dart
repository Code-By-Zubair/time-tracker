import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/back_log_tab.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/new_project_tab.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/providers/dash_board_provider.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/custom_check_box.dart';
import 'package:time_tracker/widgets/dropdown_button_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_divider_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).onInit();
    super.initState();
  }

  TeamModel? selectedTeamIndex;
  String selectedItem = 'Users';
  String? selectedProject;
  String? selectedAssignee;
  String? selectedPriority;
  String? selectedSprint;
  String? selectedStatus;
  List<String> projectList = [
    'No Project',
    'GotStuck',
    'Vape World',
  ];
  List<String> assigneeList = [
    'Ayan',
    'Ali',
  ];
  List<String> sprintList = [
    'No Sprints',
    '1 week',
    '2 week',
  ];
  List<String> priorityList = ['No Priority', 'High', 'Medium', 'Low'];
  List<String> statusList = [
    'In progress',
    'Completed',
    'Pending',
    'Priority',
    'Todo'
  ];
  List<String> items = [
    'Users',
    'Admin',
    'Team',
  ];
  int selectedTab = 0;
  List<Widget> tabs = [const NewProjectTab(), const BackLogTab()];
  bool isLoading = false;
  final TextEditingController searchUserController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  DatabaseServices databaseServices = DatabaseServices();
  String selectedItemOfUSer = 'Users';
  final GlobalKey<FormState> createTaskKey = GlobalKey();
  final GlobalKey<FormState> createProjectKey = GlobalKey();

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
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalAppBarWithProfile(
                showTitle: true,
                title: 'Tasks',
                onStartBtn: () => userDashBoardProvider.startTimer(),
                onFinishBtn: () => userDashBoardProvider.stopTimer(),
                onMenuTap: () => dashBoardProvider.expandDrawerFunc(),
                onBreakBtn: () => userDashBoardProvider.startBreakTimer(),
                isSearchfieldShow: false,
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
                        customText(AppTexts.search),
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
                    Padding(
                      padding:
                          EdgeInsets.only(right: context.w > 1030 ? 40 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          customText(AppTexts.status),
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
                              boxDecoration: boxDecorationForContainer(),
                              itemList: items,
                              onChange: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: context.w > 1030 ? 40 : 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          customText(AppTexts.assignee),
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
                              includeSearch: true,
                              includeSelectAll: true,
                              initiallySelectedList: const [],
                              boxDecoration: boxDecorationForContainer(),
                              itemList: items,
                              onChange: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 150,
                      child: IconButtonWithLabel(
                        borderColor: AppColors.appPrimaryColor,
                        iconColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        iconHeight: 15,
                        backgroundColor: AppColors.appPrimaryColor,
                        text: AppTexts.newProject,
                        icon: IconImages.plusIcon,
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierColor: Colors.transparent,
                              builder: (context) => StatefulBuilder(
                                    builder: (context, setState1) => Form(
                                      key: createProjectKey,
                                      child: AlertDialogWidget(
                                        title: AppTexts.createProject,
                                        contentChild: Consumer<TaskProvider>(
                                          builder: (context, taskProv, child) =>
                                              Column(
                                            children: [
                                              SizedBox(
                                                // height: 40,
                                                width: 740,
                                                child: RoundedTextField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  obscureText: false,
                                                  showBorder: true,
                                                  borderColor:
                                                      AppColors.appDarkGrey,
                                                  textFieldColor: Colors.white,
                                                  hintText: AppTexts
                                                      .enterProjectTitle,
                                                  textController:
                                                      titleController,
                                                  validator: (p0) {
                                                    if (p0?.isEmpty ?? true) {
                                                      return 'Enter project title';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(
                                                      20,
                                                    ),
                                                  ),
                                                  border: Border.all(
                                                    color:
                                                        AppColors.appDarkGrey,
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 20,
                                                        vertical: 15,
                                                      ),
                                                      child: Consumer<
                                                          DashBoardProvider>(
                                                        builder: (context,
                                                                dashBoardProvider,
                                                                child) =>
                                                            Row(
                                                          children: [
                                                            const Text(
                                                              AppTexts.members,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColors
                                                                    .appDarkGrey,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                              onTap: () {
                                                                Provider.of<DashBoardProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .changeCreateProjectType(
                                                                        0);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    dashBoardProvider.createProjectType ==
                                                                            0
                                                                        ? IconImages
                                                                            .selectedCircle
                                                                        : IconImages
                                                                            .circle,
                                                                    color: dashBoardProvider.createProjectType ==
                                                                            0
                                                                        ? AppColors
                                                                            .appPrimaryColor
                                                                        : AppColors
                                                                            .appDarkGrey,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                    AppTexts
                                                                        .fixedPrice,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appDarkGrey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                              onTap: () {
                                                                Provider.of<DashBoardProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .changeCreateProjectType(
                                                                        1);
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    dashBoardProvider.createProjectType ==
                                                                            1
                                                                        ? IconImages
                                                                            .selectedCircle
                                                                        : IconImages
                                                                            .circle,
                                                                    color: dashBoardProvider.createProjectType ==
                                                                            1
                                                                        ? AppColors
                                                                            .appPrimaryColor
                                                                        : AppColors
                                                                            .appDarkGrey,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                    AppTexts
                                                                        .hourlyRate,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appDarkGrey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 30,
                                                            ),
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                              onTap: () {},
                                                              child: Row(
                                                                children: [
                                                                  SvgPicture
                                                                      .asset(
                                                                    IconImages
                                                                        .circle,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  const Text(
                                                                    AppTexts
                                                                        .notPaid,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: AppColors
                                                                          .appDarkGrey,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const GlobalDividerWidget(
                                                      dividerColor:
                                                          AppColors.appDarkGrey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 30,
                                                        bottom: 25,
                                                      ),
                                                      child: Consumer<
                                                          DashBoardProvider>(
                                                        builder: (context,
                                                                dashBoardProvider,
                                                                child) =>
                                                            Row(
                                                          children: [
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                              onTap: () {
                                                                Provider.of<
                                                                    DashBoardProvider>(
                                                                  context,
                                                                  listen: false,
                                                                ).includeTeamsInCreateProjectFunc();
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    AppTexts
                                                                        .includeTeams,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: dashBoardProvider.includeTeamsInCreateProject
                                                                          ? AppColors
                                                                              .appPrimaryColor
                                                                          : AppColors
                                                                              .appDarkGrey,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  GlobalDividerWidget(
                                                                    width: 141,
                                                                    dividerColor: dashBoardProvider.includeTeamsInCreateProject
                                                                        ? AppColors
                                                                            .appPrimaryColor
                                                                        : AppColors
                                                                            .appDarkGrey,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            InkWell(
                                                              overlayColor:
                                                                  MaterialStateProperty
                                                                      .all(
                                                                Colors
                                                                    .transparent,
                                                              ),
                                                              onTap: () {
                                                                Provider.of<DashBoardProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .includeUsersInCreateProjectFunc();
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    AppTexts
                                                                        .includeUsers,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: dashBoardProvider.includeTeamsInCreateProject
                                                                          ? AppColors
                                                                              .appDarkGrey
                                                                          : AppColors
                                                                              .appPrimaryColor,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  GlobalDividerWidget(
                                                                    width: 141,
                                                                    dividerColor: dashBoardProvider.includeTeamsInCreateProject
                                                                        ? AppColors
                                                                            .appDarkGrey
                                                                        : AppColors
                                                                            .appPrimaryColor,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Consumer<DashBoardProvider>(
                                                      builder: (context,
                                                          dashBoardProvider,
                                                          child) {
                                                        return dashBoardProvider
                                                                        .includeTeamsInCreateProject ==
                                                                    true &&
                                                                dashBoardProvider
                                                                        .createProjectType ==
                                                                    0
                                                            ? Container(
                                                                height: 40,
                                                                width: 505,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 20,
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .appDarkGrey,
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    const Text(
                                                                      AppTexts
                                                                          .projectPrice,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: AppColors
                                                                            .appDarkGrey,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            20,
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            40,
                                                                        width:
                                                                            1,
                                                                        color: AppColors
                                                                            .appDarkGrey,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              priceController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            contentPadding:
                                                                                const EdgeInsets.symmetric(horizontal: 10) + const EdgeInsets.only(bottom: 7),
                                                                            border:
                                                                                InputBorder.none,
                                                                          ),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                          inputFormatters: [
                                                                            FilteringTextInputFormatter.digitsOnly
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : const SizedBox
                                                                .shrink();
                                                      },
                                                    ),
                                                    Consumer<DashBoardProvider>(
                                                      builder: (context,
                                                              dashBoardProvider,
                                                              child) =>
                                                          Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 10,
                                                          left: 10,
                                                        ),
                                                        child: dashBoardProvider
                                                                    .includeTeamsInCreateProject ==
                                                                false
                                                            ? Row(
                                                                children: [
                                                                  customText(
                                                                      AppTexts
                                                                          .teamWithColon),
                                                                  customText(
                                                                    selectedTeamIndex
                                                                            ?.teamName ??
                                                                        'To add users select Team First',
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  GlobalTextButton(
                                                                    text: AppTexts
                                                                        .selectAll,
                                                                    bachgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    borderColor:
                                                                        Colors
                                                                            .white,
                                                                    buttonTextColor:
                                                                        AppColors
                                                                            .blueColor,
                                                                    onTap: () {
                                                                      if (taskProv
                                                                          .selectedTeamMembers
                                                                          .isNotEmpty) {
                                                                        setState1(
                                                                            () {
                                                                          taskProv
                                                                              .selectedUsers
                                                                              .addAll(taskProv.selectedTeamMembers);
                                                                        });
                                                                        log(taskProv
                                                                            .selectedUsers
                                                                            .length
                                                                            .toString());
                                                                      }
                                                                    },
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox
                                                                .shrink(),
                                                      ),
                                                    ),
                                                    const GlobalDividerWidget(
                                                      dividerColor:
                                                          AppColors.appDarkGrey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 20,
                                                        bottom: 20,
                                                        top: 15,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Consumer<
                                                              DashBoardProvider>(
                                                            builder: (context,
                                                                    dashBoardProvider,
                                                                    child) =>
                                                                Row(
                                                              children: [
                                                                dashBoardProvider
                                                                        .includeTeamsInCreateProject
                                                                    ? Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            List.generate(
                                                                          taskProv
                                                                              .teamsList
                                                                              .length,
                                                                          (index) {
                                                                            return Padding(
                                                                              padding: const EdgeInsets.symmetric(
                                                                                vertical: 5,
                                                                              ),
                                                                              child: Row(
                                                                                children: [
                                                                                  CustomCheckBox(
                                                                                    isSelected: selectedTeamIndex?.id == taskProv.teamsList[index].id,
                                                                                    onChanged: (isSelected) {
                                                                                      setState1(() {
                                                                                        if (isSelected) {
                                                                                          selectedTeamIndex = taskProv.teamsList[index];
                                                                                          taskProv.fetchSelectedTeamMembers(selectedTeamIndex?.id ?? '');
                                                                                        } else {
                                                                                          selectedTeamIndex = null;
                                                                                          taskProv.selectedTeamMembers = [];
                                                                                        }
                                                                                      });
                                                                                      // log('team index ${selectedTeamIndex?.id}');
                                                                                    },
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  customText(
                                                                                    taskProv.teamsList[index].teamName,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    : Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children:
                                                                            List.generate(
                                                                          taskProv
                                                                              .selectedTeamMembers
                                                                              .length,
                                                                          (index) =>
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                CustomCheckBox(
                                                                                  isSelected: taskProv.selectedUsers.any((element) => element.email == taskProv.selectedTeamMembers[index].email),
                                                                                  onChanged: (value) {
                                                                                    setState1(() {
                                                                                      taskProv.addSelectedUsers(taskProv.selectedTeamMembers[index]);
                                                                                      log(taskProv.selectedUsers.length.toString());
                                                                                      log(taskProv.selectedUsers.any((element) => element.email == taskProv.selectedTeamMembers[index]).toString());
                                                                                    });
                                                                                  },
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                customText('${taskProv.selectedTeamMembers[index].email}-${taskProv.selectedTeamMembers[index].firstName ?? ''} ${taskProv.selectedTeamMembers[index].lastName ?? ''}'),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 10,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    SizedBox(
                                                      height: 40,
                                                      width: 80,
                                                      child: GlobalTextButton(
                                                        buttonTextColor:
                                                            AppColors
                                                                .appPrimaryColor,
                                                        borderColor: AppColors
                                                            .appPrimaryColor,
                                                        text: 'Cancel',
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 40,
                                                      child: GlobalTextButton(
                                                        isLoading:
                                                            taskProv.isLoading,
                                                        bachgroundColor:
                                                            AppColors
                                                                .appPrimaryColor,
                                                        buttonTextColor:
                                                            Colors.white,
                                                        text: 'Create Project',
                                                        onTap: () async {
                                                          createProject(
                                                            dashBoardProvider,
                                                            taskProv,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Consumer<DashBoardProvider>(
                builder: (context, dashBoardProvider, child) => SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runAlignment: WrapAlignment.spaceBetween,
                    runSpacing: 15,
                    children: [
                      SizedBox(
                        width: context.w > 900 ? context.w - 600 : 470,
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          fit: StackFit.loose,
                          children: [
                            const SizedBox(
                              child: Divider(
                                color: AppColors.appDarkGrey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                        Colors.transparent,
                                      ),
                                      onTap: () {
                                        Provider.of<DashBoardProvider>(context,
                                                listen: false)
                                            .openNewProjectTab();
                                        Provider.of<DashBoardProvider>(context,
                                                listen: false)
                                            .changeTaskTab(0);
                                      },
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            IconImages.newProject,
                                            color: dashBoardProvider
                                                    .isNewProjectTabOpened
                                                ? AppColors.appPrimaryColor
                                                : AppColors.appDarkGrey,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            AppTexts.newProject,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: dashBoardProvider
                                                      .isNewProjectTabOpened
                                                  ? AppColors.appPrimaryColor
                                                  : AppColors.appDarkGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    dashBoardProvider.isNewProjectTabOpened
                                        ? const SizedBox(
                                            width: 135,
                                            child: Divider(
                                              color: AppColors.appPrimaryColor,
                                            ))
                                        : const SizedBox.shrink()
                                  ],
                                ),
                                const SizedBox(
                                  width: 70,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      overlayColor: MaterialStateProperty.all(
                                        Colors.transparent,
                                      ),
                                      onTap: () {
                                        Provider.of<DashBoardProvider>(context,
                                                listen: false)
                                            .openBackLogTab();
                                        Provider.of<DashBoardProvider>(context,
                                                listen: false)
                                            .changeTaskTab(1);
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                            IconImages.backLog,
                                            color: dashBoardProvider
                                                    .isNewProjectTabOpened
                                                ? AppColors.appDarkGrey
                                                : AppColors.appPrimaryColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Text(
                                            AppTexts.backLog,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: dashBoardProvider
                                                      .isNewProjectTabOpened
                                                  ? AppColors.appDarkGrey
                                                  : AppColors.appPrimaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    dashBoardProvider.isNewProjectTabOpened ==
                                            false
                                        ? const SizedBox(
                                            width: 135,
                                            child: Divider(
                                              color: AppColors.appPrimaryColor,
                                            ))
                                        : const SizedBox.shrink()
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Consumer<TaskProvider>(
                        builder: (context, taskProv, child) => SizedBox(
                          height: 45,
                          width: 135,
                          child: IconButtonWithLabel(
                            borderColor: AppColors.appPrimaryColor,
                            iconColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            iconHeight: 15,
                            backgroundColor: AppColors.appPrimaryColor,
                            text: AppTexts.newTask,
                            icon: IconImages.plusIcon,
                            onTap: () {
                              if (taskProv.projectList.isEmpty) {
                                context.showInfoSnackBar('Add project first!');
                              } else {
                                showDialog(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (context, setState1) => Form(
                                      key: createTaskKey,
                                      child: AddOrEditTaskPopUpContent(
                                        buttonText: 'Create',
                                        titleController: taskTitleController,
                                        descriptionController:
                                            taskDescriptionController,
                                        title: AppTexts.newTask,
                                        selectedAssignee: selectedAssignee,
                                        selectedPriority: selectedPriority,
                                        selectedSprint: selectedSprint,
                                        assigneeList:
                                            taskProv.projectMembers ?? [],
                                        priorityList: priorityList,
                                        sprintList: sprintList,
                                        onAssigneepopupChange: (value) {
                                          setState1(() {
                                            selectedAssignee = value;
                                          });
                                          print(selectedAssignee);
                                        },
                                        onPrioritypopupChange: (value) {
                                          setState1(() {
                                            selectedPriority = value;
                                          });
                                        },
                                        onSprintpopupChange: (value) {
                                          setState1(() {
                                            selectedSprint = value;
                                          });
                                        },
                                        onCreateTap: () async {
                                          // Navigator.pop(context);
                                          if (createTaskKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            try {
                                              databaseServices.createTask(TaskModel(
                                                  title: taskTitleController
                                                      .text
                                                      .trim(),
                                                  description:
                                                      taskDescriptionController
                                                          .text
                                                          .trim(),
                                                  sprint: selectedSprint,
                                                  priority: selectedPriority,
                                                  assigneeId: selectedAssignee,
                                                  status: selectedStatus
                                                      ?.replaceAll(' ', '')
                                                      .toLowerCase(),
                                                  projectId: taskProv
                                                      .selectedProjectIndex));
                                              taskTitleController.clear();
                                              taskDescriptionController.clear();
                                              selectedAssignee = null;
                                              selectedPriority = null;
                                              selectedSprint = null;
                                              context.showSuccessSnackBar(
                                                  'Add task successfully!');
                                              Navigator.pop(context);
                                            } catch (e, s) {
                                              print(
                                                  e.toString() + s.toString());
                                              context.showErrorSnackBar(
                                                  e.toString());
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: 500,
                  child: Consumer<DashBoardProvider>(
                    builder: (context, dashBoardProv, child) =>
                        PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          tabs[dashBoardProv.taskTab],
                      onPageChanged: (value) {
                        dashBoardProv.changeTaskTab(value);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customText(String text) {
    return Text(
      text, //AppTexts.search
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }

  createProject(
      DashBoardProvider dashBoardProvider, TaskProvider taskProv) async {
    if (createProjectKey.currentState?.validate() ?? false) {
      try {
        if (selectedTeamIndex != null) {
          if (taskProv.selectedUsers.isNotEmpty) {
            taskProv.loading(true);

            databaseServices.createNewProject(
              ProjectModel(
                title: titleController.text.trim(),
                paymentType: dashBoardProvider.createProjectType == 0
                    ? 'Fixed'
                    : 'Hourly',
                price: double.tryParse(priceController.text.trim()),
                selectedTeam: selectedTeamIndex?.id,
                projectMembers:
                    taskProv.selectedUsers.map((e) => e.email).toList(),
              ),
            );
            titleController.clear();
            priceController.clear();
            selectedTeamIndex = null;
            taskProv.selectedUsers = [];
            context.showSuccessSnackBar('Project created successfully!');
            taskProv.loading(false);
            Navigator.pop(context);
          } else {
            Provider.of<DashBoardProvider>(context, listen: false)
                .includeUsersInCreateProjectFunc();
            // dashBoardProvider.includeTeamsInCreateProject
            context.showInfoSnackBar('Add users');
          }
        } else {
          Provider.of<DashBoardProvider>(context, listen: false)
              .includeTeamsInCreateProjectFunc();
          context.showInfoSnackBar('Select Team');
        }
      } catch (e, s) {
        taskProv.loading(false);
        debugPrint(e.toString() + s.toString());
      }
    }
  }
}

class AddOrEditTaskPopUpContent extends StatelessWidget {
  const AddOrEditTaskPopUpContent({
    super.key,
    required this.title,
    required this.selectedSprint,
    required this.sprintList,
    required this.selectedPriority,
    required this.priorityList,
    required this.selectedAssignee,
    required this.assigneeList,
    required this.onSprintpopupChange,
    required this.onPrioritypopupChange,
    required this.onAssigneepopupChange,
    required this.onCreateTap,
    required this.titleController,
    required this.descriptionController,
    required this.buttonText,
  });

  final String title;
  final String? selectedSprint;

  final String? selectedPriority;
  final String? selectedAssignee;
  final List<String> sprintList;

  final List<String> priorityList;
  final List<String> assigneeList;
  final VoidCallback onCreateTap;
  final ValueChanged onSprintpopupChange;
  final ValueChanged onPrioritypopupChange;
  final ValueChanged onAssigneepopupChange;

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: title, //AppTexts.newTask
      contentChild: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 310,
                    // height: 40,
                    child: RoundedTextField(
                      textController: titleController,
                      keyboardType: TextInputType.text,
                      textFieldColor: Colors.white,
                      showBorder: true,
                      hintText: AppTexts.title,
                      obscureText: false,
                      maxLength: 30,
                      validator: (p0) {
                        if (p0?.isEmpty ?? true) {
                          return 'Add title';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.appDarkGrey,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      height: 196,
                      width: 310,
                      child: TextField(
                        controller: descriptionController,
                        maxLines: 10,
                        maxLength: 500,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Description'),
                      )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: DropDownButtonWidget<String>(
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'Selcet sprints';
                          }
                          return null;
                        },
                        hint: 'Select sprints',
                        displayValueCallback: (item) => item,
                        rightPadding: 10,
                        yOffset: -10,
                        selectedItem: selectedSprint,
                        items: sprintList,
                        onChanged: onSprintpopupChange,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 300,
                      child: DropDownButtonWidget<String>(
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'Selcet priority';
                          }
                          return null;
                        },
                        hint: 'Select priority',
                        displayValueCallback: (item) => item,
                        rightPadding: 10,
                        yOffset: -10,
                        selectedItem: selectedPriority,
                        items: priorityList,
                        onChanged: onPrioritypopupChange,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: 300,
                      child: DropDownButtonWidget<String>(
                        validator: (p0) {
                          if (p0?.isEmpty ?? true) {
                            return 'Select assignee';
                          }
                          return null;
                        },
                        selectedItemBuilder: (context) => [
                          Center(
                            child: SizedBox(
                              width: 230,
                              child: Text(
                                selectedAssignee ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: 230,
                              child: Text(
                                selectedAssignee ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                        hint: 'Select Assignee',
                        displayValueCallback: (item) => item,
                        rightPadding: 10,
                        yOffset: -10,
                        selectedItem: selectedAssignee,
                        items: assigneeList,
                        onChanged: onAssigneepopupChange,
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 105,
            height: 40,
            child: GlobalTextButton(
              bachgroundColor: AppColors.appPrimaryColor,
              buttonTextColor: Colors.white,
              text: buttonText,
              onTap: onCreateTap,
            ),
          )
        ],
      ),
    );
  }
}
