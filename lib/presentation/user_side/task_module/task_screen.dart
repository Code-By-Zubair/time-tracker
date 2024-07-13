// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_icons.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/settings_module/setting_screen.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/new_project_tab.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/tasks_screen.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/providers/task_provider_user_side.dart';
import 'package:time_tracker/providers/user_dash_board_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_appbar_with_profile.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/icon_button_with_label.dart';
import 'package:time_tracker/widgets/multi_select_dropdown_widget.dart';
import 'package:time_tracker/widgets/owner_name_container_widget.dart';
import 'package:time_tracker/widgets/project_details_widget.dart';
import 'package:time_tracker/widgets/rounded_text_field.dart';

class TaskScreenUserSide extends StatefulWidget {
  const TaskScreenUserSide({super.key});

  @override
  State<TaskScreenUserSide> createState() => _TaskScreenUserSide();
}

class _TaskScreenUserSide extends State<TaskScreenUserSide> {
  final GlobalKey<FormState> createTask = GlobalKey();
  String? selectedProjectStatus;
  String? selectedAssignee;
  String? selectedPriority;
  String? selectedSprint;
  String? selectedStatus;
  final GlobalKey<FormState> updateTask = GlobalKey();
  TextEditingController searchUserController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DatabaseServices databaseServices = DatabaseServices();
  ScrollController scrollController = ScrollController();
  List<String> projectStatus = ['To Do', 'In Progress', 'Done'];
  List<String> projectAssignee = ['Not Assigned', 'Muhammad Umar'];
  List<String> sprintList = ['No Sprints', '1 week', '2 week'];
  List<String> priorityList = ['High', 'Medium', 'Low'];
  List<String> statusList = [
    'In progress',
    'Completed',
    'Pending',
    'Priority',
    'Todo',
  ];
  List items = [
    {'icons': IconImages.projecTask, 'text': AppTexts.projects},
    {'icons': IconImages.backLog, 'text': AppTexts.backLog},
  ];
  @override
  void initState() {
    Provider.of<TaskProviderUserSide>(context, listen: false).onInit(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userDashBoardProvider =
        Provider.of<UserDashBoardProvider>(context, listen: false);
    final sharePrefProv =
        Provider.of<SharedPrefProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
          child: Column(
            children: [
              GlobalAppBarWithProfile(
                titleRightPadding: context.w < 900 ? 100 : 0,
                showTitle: true,
                title: AppTexts.tasks,
                onStartBtn: () => userDashBoardProvider.startTimer(),
                onFinishBtn: () => userDashBoardProvider.stopTimer(),
                onMenuTap: () => userDashBoardProvider.expandDrawerFunc(),
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
                    Padding(
                      padding:
                          EdgeInsets.only(right: context.w > 1030 ? 40 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            AppTexts.status,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                              boxDecoration: boxDecorationForContainer(),
                              itemList: projectStatus,
                              onChange: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: context.w > 1030 ? 40 : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            AppTexts.assignee,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
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
                              itemList: projectAssignee,
                              onChange: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 135,
                      child: Consumer<TaskProviderUserSide>(
                        builder: (context, taskProvUserSide, child) =>
                            IconButtonWithLabel(
                          borderColor: AppColors.appPrimaryColor,
                          iconColor: Colors.white,
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          iconHeight: 15,
                          backgroundColor: AppColors.appPrimaryColor,
                          text: AppTexts.newTask,
                          icon: IconImages.plusIcon,
                          onTap: () {
                            showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) => StatefulBuilder(
                                      builder: (context, setState1) => Form(
                                        key: createTask,
                                        child: AddOrEditTaskPopUpContent(
                                          titleController: titleController,
                                          descriptionController:
                                              descriptionController,
                                          buttonText: 'Create Task',
                                          title: AppTexts.newTask,
                                          selectedAssignee: selectedAssignee,
                                          selectedPriority: selectedPriority,
                                          selectedSprint: selectedSprint,
                                          assigneeList: [
                                            Provider.of<SharedPrefProvider>(
                                                        context,
                                                        listen: false)
                                                    .data
                                                    ?.email ??
                                                ''
                                          ],
                                          priorityList: priorityList,
                                          sprintList: sprintList,
                                          onAssigneepopupChange: (value) {
                                            setState1(() {
                                              selectedAssignee = value;
                                            });
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
                                          onCreateTap: () {
                                            if (createTask.currentState
                                                    ?.validate() ??
                                                false) {
                                              try {
                                                databaseServices
                                                    .createTask(TaskModel(
                                                  projectId: taskProvUserSide
                                                      .selectedProjectIndex,
                                                  assigneeId: selectedAssignee,
                                                  description:
                                                      descriptionController.text
                                                          .trim(),
                                                  priority: selectedPriority,
                                                  sprint: selectedSprint,
                                                  title: titleController.text
                                                      .trim(),
                                                  status: selectedStatus
                                                          ?.replaceAll(' ', '')
                                                          .toLowerCase() ??
                                                      'todo',
                                                ));
                                                clearTask();
                                                Navigator.pop(context);
                                              } catch (e, s) {
                                                debugPrint(e.toString() +
                                                    s.toString());
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Consumer<TaskProviderUserSide>(
                builder: (context, taskProviderUserSide, child) => Stack(
                  alignment: Alignment.bottomLeft,
                  fit: StackFit.loose,
                  children: [
                    const SizedBox(
                      child: Divider(
                        color: AppColors.appDarkGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      height: 64,
                      child: ListView.builder(
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: CustomTabItemWidget(
                              providerSelectedTab:
                                  taskProviderUserSide.selectedTab,
                              icon: items[index]['icons'],
                              text: items[index]['text'],
                              selectedTab: index,
                              onTabPress: () {
                                Provider.of<TaskProviderUserSide>(context,
                                        listen: false)
                                    .changeTab(index);
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
              Consumer<TaskProviderUserSide>(
                builder: (context, taskProvUserSide, child) {
                  return taskProvUserSide.userProjects.isEmpty
                      ? const NoDataLottieWidget(text: 'No projects found!')
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Consumer<TaskProviderUserSide>(
                                builder: (context, taskProvUserSide, child) =>
                                    Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: List.generate(
                                      taskProvUserSide.userProjects.length,
                                      (index) => OwnerNameContainerWidget(
                                        isSelected: taskProvUserSide
                                                .userProjects[index].id ==
                                            taskProvUserSide
                                                .selectedProjectIndex,
                                        ownerName: taskProvUserSide
                                            .userProjects[index].title,
                                        onTap: () {
                                          taskProvUserSide
                                              .selectedProjectIndexChange(
                                                  taskProvUserSide
                                                          .userProjects[index]
                                                          .id ??
                                                      '');
                                          taskProvUserSide
                                              .getSelectedProjectTasks(
                                                  taskProvUserSide
                                                      .selectedProjectIndex);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.w * 0.02,
                              ),
                              Expanded(
                                flex: 3,
                                child: taskProvUserSide.selectedTab == 0
                                    ? Builder(
                                        builder: (context) => taskProvUserSide
                                                .selectedProjectTasks.isEmpty
                                            ? const NoDataLottieWidget(
                                                text: 'No tasks found!')
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (taskProvUserSide
                                                      .priorityTasks.isNotEmpty)
                                                    TaskListWidget(
                                                        title: "Priority Tasks",
                                                        taskList:
                                                            taskProvUserSide
                                                                .priorityTasks),
                                                  if (taskProvUserSide
                                                      .inProgressTask
                                                      .isNotEmpty)
                                                    TaskListWidget(
                                                        title: "Ongoing Tasks",
                                                        taskList:
                                                            taskProvUserSide
                                                                .inProgressTask),
                                                  if (taskProvUserSide
                                                      .pendingTask.isNotEmpty)
                                                    TaskListWidget(
                                                        title: "Pending Tasks",
                                                        taskList:
                                                            taskProvUserSide
                                                                .pendingTask),
                                                  if (taskProvUserSide
                                                      .comletedTask.isNotEmpty)
                                                    TaskListWidget(
                                                        title:
                                                            "Completed Tasks",
                                                        taskList:
                                                            taskProvUserSide
                                                                .comletedTask),
                                                  if (taskProvUserSide
                                                      .todoTasks.isNotEmpty)
                                                    TaskListWidget(
                                                        title: "Todo Tasks",
                                                        taskList:
                                                            taskProvUserSide
                                                                .todoTasks),
                                                ],
                                              ),
                                      )
                                    : Builder(
                                        builder: (context) => taskProvUserSide
                                                .selectedProjectTasks.isEmpty
                                            ? const NoDataLottieWidget(
                                                text: 'No tasks found!')
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: List.generate(
                                                  7,
                                                  (index) => Consumer<
                                                      TaskProviderUserSide>(
                                                    builder: (context,
                                                            taskProviderUserSide,
                                                            child) =>
                                                        ProjectDetailsWidget(
                                                      title: 'Time Tracking',
                                                      priority: 'High',
                                                      status: 'To Do',
                                                      onStartBtnTap: () {},
                                                      onEditBtnTap: () {},
                                                      onDeleteBtnTap: () {},
                                                      onStatusChanged:
                                                          (value) {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                              ),
                            ]);
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearTask() {
    titleController.clear();
    descriptionController.clear();
    selectedAssignee = null;
    selectedPriority = null;
    selectedSprint = null;
  }
}

class TaskListWidget extends StatelessWidget {
  TaskListWidget({super.key, required this.taskList, required this.title});
  final DatabaseServices databaseServices = DatabaseServices();
  final String title;
  final List<TaskModel> taskList;
  String? selectedProjectStatus;
  String? selectedAssignee;
  String? selectedPriority;
  String? selectedSprint;
  String? selectedStatus;
  final GlobalKey<FormState> updateTask = GlobalKey();
  TextEditingController searchUserController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<String> projectStatus = ['To Do', 'In Progress', 'Done'];
  List<String> projectAssignee = ['Not Assigned', 'Muhammad Umar'];
  List<String> sprintList = ['No Sprints', '1 week', '2 week'];
  List<String> priorityList = ['High', 'Medium', 'Low'];
  List<String> statusList = [
    'In progress',
    'Completed',
    'Pending',
    'Priority',
    'Todo'
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProviderUserSide>(
      builder: (context, taskProvUserSide, child) =>
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            taskList.length,
            (index) {
              List<UserModel> user = taskProvUserSide.usersList
                  .where(
                      (element) => element.email == taskList[index].assigneeId)
                  .toList();
              return ProjectDetailsWidget(
                title: taskList[index].title ?? '',
                image: user.isEmpty ? '' : user.first.profile ?? '',
                priority: taskList[index].priority ?? '',
                status: taskList[index].status ?? '',
                onStartBtnTap: () {
                  if (taskList[index].status?.isEmpty ?? true) {
                    databaseServices
                        .updateTaskStatus(taskList[index].id ?? '', {
                      'status': 'start',
                    });
                  } else {
                    databaseServices
                        .updateTaskStatus(taskList[index].id ?? '', {
                      'status': 'finish',
                    });
                  }
                },
                onTitleTap: () {
                  var teamId = taskProvUserSide.projectList
                      .firstWhere((element) =>
                          element.id == taskProvUserSide.selectedProjectIndex)
                      .selectedTeam;
                  TeamModel selectedTeam = taskProvUserSide.teamsList
                      .firstWhere((element) => element.id == teamId);
                  showDialog(
                    context: context,
                    builder: (context) => TaskDetailDialogWidget(
                      selectedTeam: selectedTeam,
                      taskList: taskList,
                      user: user,
                      title: taskList[index].title ?? '',
                      project: taskProvUserSide.projectList
                          .firstWhere((element) =>
                              element.id ==
                              taskProvUserSide.selectedProjectIndex)
                          .title,
                      description: taskList[index].description ?? '',
                      priority: taskList[index].priority ?? '',
                      status: taskList[index].status ?? '',
                    ),
                  );
                },
                onEditBtnTap: () {
                  titleController.text = taskList[index].title ?? '';
                  descriptionController.text =
                      taskList[index].description ?? '';
                  selectedAssignee =
                      taskProvUserSide.selectedProjectTasks[index].assigneeId;
                  selectedPriority = taskList[index].priority;
                  selectedSprint = taskList[index].sprint;
                  selectedStatus = taskList[index].status;
                  showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                      builder: (context, setState1) {
                        return Form(
                          key: updateTask,
                          child: AddOrEditTaskPopUpContent(
                            buttonText: 'Update',
                            titleController: titleController,
                            descriptionController: descriptionController,
                            title: AppTexts.taskDetails,
                            selectedAssignee: selectedAssignee,
                            selectedPriority: selectedPriority,
                            selectedSprint: selectedSprint,
                            assigneeList: [taskList[index].assigneeId ?? ''],
                            priorityList: priorityList,
                            sprintList: sprintList,
                            onAssigneepopupChange: (value) {
                              setState1(() {
                                selectedAssignee = value;
                              });
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
                            onCreateTap: () {
                              if (updateTask.currentState?.validate() ??
                                  false) {
                                try {
                                  databaseServices.updateTask(
                                    TaskModel(
                                      title: titleController.text.trim(),
                                      description:
                                          descriptionController.text.trim(),
                                      sprint: selectedSprint,
                                      status: selectedStatus ??
                                          taskList[index].status,
                                      priority: selectedPriority,
                                      assigneeId: selectedAssignee,
                                      projectId:
                                          taskProvUserSide.selectedProjectIndex,
                                      id: taskList[index].id,
                                    ),
                                  );
                                  clearTask();
                                  Navigator.pop(context);
                                } catch (e, s) {
                                  debugPrint(e.toString() + s.toString());
                                }
                              }
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
                onDeleteBtnTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialogWidget(
                      title: 'Delete Task',
                      contentChild: Column(
                        children: [
                          const Text(
                            AppTexts.areYouSureYouWantToDeleteThisTask,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColors.appDarkGrey,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                            width: 140,
                            child: GlobalTextButton(
                              text: 'Delete Task',
                              bachgroundColor: AppColors.appPrimaryColor,
                              buttonTextColor: Colors.white,
                              onTap: () async {
                                databaseServices
                                    .deleteTask(taskList[index].id ?? '');
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                onStatusChanged: (value) {
                  databaseServices.updateTaskStatus(
                      taskList[index].id ?? '', {'status': value});
                },
              );
            },
          ),
        ),
      ]),
    );
  }

  clearTask() {
    titleController.clear();
    descriptionController.clear();
    selectedAssignee = null;
    selectedPriority = null;
    selectedSprint = null;
  }
}
