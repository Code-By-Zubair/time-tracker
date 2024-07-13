import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/helpers/helper_functions.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/task_module/tasks_screen.dart';
import 'package:time_tracker/constants/app_colors.dart';
import 'package:time_tracker/constants/app_text.dart';
import 'package:time_tracker/helpers/media_query_helper.dart';
import 'package:time_tracker/presentation/admin_side/views/dashboard/user_management_module/user_management_screen.dart';
import 'package:time_tracker/providers/task_provider.dart';
import 'package:time_tracker/services/database_services.dart';
import 'package:time_tracker/widgets/alert_dialog_widget.dart';
import 'package:time_tracker/widgets/global_text_button.dart';
import 'package:time_tracker/widgets/owner_name_container_widget.dart';
import 'package:time_tracker/widgets/project_details_widget.dart';

class NewProjectTab extends StatefulWidget {
  const NewProjectTab({Key? key}) : super(key: key);

  @override
  State<NewProjectTab> createState() => _NewProjectTabState();
}

class _NewProjectTabState extends State<NewProjectTab> {
  DatabaseServices databaseServices = DatabaseServices();
  final GlobalKey<FormState> updateTaskKey = GlobalKey();
  String? selectedAssignee;
  String? selectedPriority;
  String? selectedSprint;
  String? selectedStatus;

  List<String> assigneeList = [
    'Not Assigned',
    'Ayan',
    'Ali',
  ];
  List<String> sprintList = [
    'No Sprints',
    '1 week',
    '2 week',
  ];
  List<String> priorityList = ['No Priority', 'High', 'Medium', 'Low'];

  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider.of<TaskProvider>(context, listen: true).projectList.isEmpty
        ? const NoDataLottieWidget(
            text: 'No projects found!',
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _expanded1(),
                    SizedBox(
                      width: context.w * 0.03,
                    ),
                    Consumer<TaskProvider>(
                      builder: (context, taskProv, child) {
                        return expanded2(taskProv, context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Expanded expanded2(TaskProvider taskProv, BuildContext context) {
    return Expanded(
      flex: 3,
      child: taskProv.selectedProjectTasks.isEmpty
          ? const NoDataLottieWidget(
              text: 'No tasks found!',
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (taskProv.priorityTasks.isNotEmpty)
                  TaskListWidget(
                      title: "Priority Tasks",
                      taskList: taskProv.priorityTasks),
                if (taskProv.inProgressTask.isNotEmpty)
                  TaskListWidget(
                      title: "Ongoing Tasks",
                      taskList: taskProv.inProgressTask),
                if (taskProv.pendingTask.isNotEmpty)
                  TaskListWidget(
                      title: "Pending Tasks", taskList: taskProv.pendingTask),
                if (taskProv.comletedTask.isNotEmpty)
                  TaskListWidget(
                      title: "Completed Tasks",
                      taskList: taskProv.comletedTask),
                if (taskProv.todoTasks.isNotEmpty)
                  TaskListWidget(
                      title: "Todo Tasks", taskList: taskProv.todoTasks),
              ],
            ),
      // : Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           children: [
      //             ...List.generate(
      //               taskProv.selectedProjectTasks.length,
      //               (index) => Padding(
      //                 padding: const EdgeInsets.only(
      //                   bottom: 7,
      //                 ),
      //                 child: Container(
      //                   height: 47,
      //                   width: double.infinity,
      //                   padding: const EdgeInsets.symmetric(
      //                         vertical: 15,
      //                       ) +
      //                       const EdgeInsets.only(
      //                         left: 10,
      //                       ),
      //                   decoration: const BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.only(
      //                       bottomLeft: Radius.circular(
      //                         20,
      //                       ),
      //                       topLeft: Radius.circular(
      //                         20,
      //                       ),
      //                     ),
      //                   ),
      //                   child: Text(
      //                     taskProv.selectedProjectTasks[index].title ?? '',
      //                     overflow: TextOverflow.ellipsis,
      //                     maxLines: 1,
      //                     style: const TextStyle(
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.w400,
      //                       color: AppColors.appDarkGrey,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             ...List.generate(
      //               taskProv.selectedProjectTasks.length,
      //               (index) => Padding(
      //                 padding: const EdgeInsets.only(
      //                   bottom: 7,
      //                 ),
      //                 child: Container(
      //                   height: 47,
      //                   width: double.infinity,
      //                   padding: const EdgeInsets.symmetric(
      //                     vertical: 10,
      //                   ),
      //                   decoration: const BoxDecoration(
      //                     color: Colors.white,
      //                   ),
      //                   child: Text(
      //                     taskProv.selectedProjectTasks[index].priority ??
      //                         '',
      //                     style: const TextStyle(
      //                       fontSize: 14,
      //                       fontWeight: FontWeight.w400,
      //                       color: AppColors.appPrimaryColor,
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             ...List.generate(
      //               taskProv.selectedProjectTasks.length,
      //               (index) => Padding(
      //                 padding: const EdgeInsets.only(
      //                   bottom: 7,
      //                 ),
      //                 child: Container(
      //                   height: 47,
      //                   width: double.infinity,
      //                   padding: const EdgeInsets.symmetric(
      //                     vertical: 10,
      //                   ),
      //                   decoration: const BoxDecoration(
      //                     color: Colors.white,
      //                   ),
      //                   child: const Text(
      //                     'Done',
      //                     style: TextStyle(
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w400,
      //                         color: AppColors.appDarkGrey),
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             ...List.generate(
      //               taskProv.selectedProjectTasks.length,
      //               (index) {
      //                 List<UserModel> user = taskProv.usersList
      //                     .where((element) =>
      //                         element.email ==
      //                         taskProv
      //                             .selectedProjectTasks[index].assigneeId)
      //                     .toList();
      //                 return Padding(
      //                   padding: const EdgeInsets.only(
      //                     bottom: 7,
      //                   ),
      //                   child: Container(
      //                     height: 47,
      //                     padding: const EdgeInsets.symmetric(
      //                       vertical: 10,
      //                     ),
      //                     decoration: const BoxDecoration(
      //                       color: Colors.white,
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         NetworkImageWidget(
      //                             imageUrl: user.isEmpty
      //                                 ? ''
      //                                 : user.first.profile ?? ''),
      //                         const SizedBox(
      //                           width: 5,
      //                         ),
      //                         context.w > 1100
      //                             ? Flexible(
      //                                 child: Text(
      //                                   user.first.firstName ??
      //                                       user.first.lastName ??
      //                                       '',
      //                                   overflow: TextOverflow.ellipsis,
      //                                   maxLines: 1,
      //                                   style: const TextStyle(
      //                                     fontSize: 14,
      //                                     fontWeight: FontWeight.w400,
      //                                     color: AppColors.appDarkGrey,
      //                                   ),
      //                                 ),
      //                               )
      //                             : const SizedBox.shrink(),
      //                       ],
      //                     ),
      //                   ),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //       Expanded(
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             ...List.generate(
      //               taskProv.selectedProjectTasks.length,
      //               (index) => Padding(
      //                 padding: const EdgeInsets.only(
      //                   bottom: 7,
      //                 ),
      //                 child: Container(
      //                   height: 47,
      //                   decoration: const BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.only(
      //                       bottomRight: Radius.circular(
      //                         20,
      //                       ),
      //                       topRight: Radius.circular(
      //                         20,
      //                       ),
      //                     ),
      //                   ),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       IconButton(
      //                         icon: SvgPicture.asset(IconImages.userEdit),
      //                         onPressed: () {
      //                           taskTitleController.text = taskProv
      //                                   .selectedProjectTasks[index]
      //                                   .title ??
      //                               '';
      //                           taskDescriptionController.text = taskProv
      //                                   .selectedProjectTasks[index]
      //                                   .description ??
      //                               '';
      //                           selectedAssignee = taskProv
      //                               .selectedProjectTasks[index].assigneeId;
      //                           selectedPriority = taskProv
      //                               .selectedProjectTasks[index].priority;
      //                           selectedSprint = taskProv
      //                               .selectedProjectTasks[index].sprint;
      //                           showDialog(
      //                             context: context,
      //                             builder: (context) => StatefulBuilder(
      //                               builder: (context, setState1) {
      //                                 return Form(
      //                                   key: updateTaskKey,
      //                                   child: AddOrEditTaskPopUpContent(
      //                                     buttonText: 'Update',
      //                                     titleController:
      //                                         taskTitleController,
      //                                     descriptionController:
      //                                         taskDescriptionController,
      //                                     title: AppTexts.taskDetails,
      //                                     selectedAssignee:
      //                                         selectedAssignee,
      //                                     selectedPriority:
      //                                         selectedPriority,
      //                                     selectedSprint: selectedSprint,
      //                                     assigneeList:
      //                                         taskProv.projectMembers ?? [],
      //                                     priorityList: priorityList,
      //                                     sprintList: sprintList,
      //                                     onAssigneepopupChange: (value) {
      //                                       setState1(() {
      //                                         selectedAssignee = value;
      //                                       });
      //                                     },
      //                                     onPrioritypopupChange: (value) {
      //                                       setState1(() {
      //                                         selectedPriority = value;
      //                                       });
      //                                     },
      //                                     onSprintpopupChange: (value) {
      //                                       setState1(() {
      //                                         selectedSprint = value;
      //                                       });
      //                                     },
      //                                     onCreateTap: () {
      //                                       if (updateTaskKey.currentState
      //                                               ?.validate() ??
      //                                           false) {
      //                                         try {
      //                                           databaseServices.updateTask(
      //                                             TaskModel(
      //                                                 title:
      //                                                     taskTitleController
      //                                                         .text
      //                                                         .trim(),
      //                                                 description:
      //                                                     taskDescriptionController
      //                                                         .text
      //                                                         .trim(),
      //                                                 sprint:
      //                                                     selectedSprint,
      //                                                 priority:
      //                                                     selectedPriority,
      //                                                 assigneeId:
      //                                                     selectedAssignee,
      //                                                 projectId: taskProv
      //                                                     .selectedProjectTasks[
      //                                                         index]
      //                                                     .projectId,
      //                                                 id: taskProv
      //                                                     .selectedProjectTasks[
      //                                                         index]
      //                                                     .id,
      //                                                 status: selectedStatus ??
      //                                                     taskProv
      //                                                         .selectedProjectTasks[
      //                                                             index]
      //                                                         .status),
      //                                           );
      //                                           log(selectedPriority
      //                                               .toString());
      //                                           selectedAssignee = null;
      //                                           selectedPriority = null;
      //                                           selectedSprint = null;
      //                                           Navigator.pop(context);
      //                                         } catch (e, s) {
      //                                           log(e.toString() +
      //                                               s.toString());
      //                                         }
      //                                       }
      //                                     },
      //                                   ),
      //                                 );
      //                               },
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                       IconButton(
      //                         icon: SvgPicture.asset(
      //                           IconImages.userDelete,
      //                         ),
      //                         onPressed: () {
      //                           showDialog(
      //                             barrierColor: Colors.transparent,
      //                             context: context,
      //                             builder: (context) => AlertDialogWidget(
      //                               title: 'Delete Task',
      //                               contentChild: Column(
      //                                 children: [
      //                                   const Text(
      //                                     AppTexts
      //                                         .areYouSureYouWantToDeleteThisTask,
      //                                     style: TextStyle(
      //                                       fontWeight: FontWeight.w500,
      //                                       fontSize: 18,
      //                                       color: AppColors.appDarkGrey,
      //                                     ),
      //                                   ),
      //                                   const SizedBox(
      //                                     height: 20,
      //                                   ),
      //                                   SizedBox(
      //                                     height: 40,
      //                                     width: 140,
      //                                     child: GlobalTextButton(
      //                                       text: 'Delete Task',
      //                                       bachgroundColor:
      //                                           AppColors.appPrimaryColor,
      //                                       buttonTextColor: Colors.white,
      //                                       onTap: () async {
      //                                         Navigator.pop(context);
      //                                         try {
      //                                           databaseServices.deleteTask(
      //                                               taskProv
      //                                                       .selectedProjectTasks[
      //                                                           index]
      //                                                       .id ??
      //                                                   '');
      //                                           log('deleted');
      //                                         } catch (e) {
      //                                           debugPrint(e.toString());
      //                                         }
      //                                       },
      //                                     ),
      //                                   )
      //                                 ],
      //                               ),
      //                             ),
      //                           );
      //                         },
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
    );
  }

  Expanded _expanded1() {
    return Expanded(
      child: Consumer<TaskProvider>(
        builder: (context, taskProv, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              taskProv.projectList.length,
              (index) => OwnerNameContainerWidget(
                isSelected: taskProv.projectList[index].id ==
                    taskProv.selectedProjectIndex,
                ownerName: taskProv.projectList[index].title,
                onTap: () {
                  Provider.of<TaskProvider>(context, listen: false)
                      .selectedProjectIndexChange(
                          taskProv.projectList[index].id ?? '');
                  Provider.of<TaskProvider>(context, listen: false)
                      .getProjectMembers(taskProv.projectList[index].id ?? '');
                  Provider.of<TaskProvider>(context, listen: false)
                      .getSelectedProjectTasks(
                          taskProv.projectList[index].id ?? '');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NoDataLottieWidget extends StatelessWidget {
  const NoDataLottieWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          'assets/lottie/nodata.json',
          height: context.h * 0.40,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.appDarkGrey,
          ),
        )
      ],
    );
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
    return Consumer<TaskProvider>(
      builder: (context, taskProv, child) =>
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
              List<UserModel> user = taskProv.usersList
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
                  var teamId = taskProv.projectList
                      .firstWhere((element) =>
                          element.id == taskProv.selectedProjectIndex)
                      .selectedTeam;
                  TeamModel selectedTeam = taskProv.teamsList
                      .firstWhere((element) => element.id == teamId);
                  showDialog(
                    context: context,
                    builder: (context) => TaskDetailDialogWidget(
                      selectedTeam: selectedTeam,
                      taskList: taskList,
                      user: user,
                      title: taskList[index].title ?? '',
                      project: taskProv.projectList
                          .firstWhere((element) =>
                              element.id == taskProv.selectedProjectIndex)
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
                      taskProv.selectedProjectTasks[index].assigneeId;
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
                            assigneeList: taskProv.projectMembers ?? [],
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
                                      projectId: taskProv.selectedProjectIndex,
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

class TaskDetailDialogWidget extends StatelessWidget {
  const TaskDetailDialogWidget({
    super.key,
    required this.selectedTeam,
    required this.taskList,
    required this.user,
    required this.title,
    required this.project,
    required this.description,
    required this.status,
    required this.priority,
  });

  final TeamModel selectedTeam;
  final List<TaskModel> taskList;
  final List<UserModel> user;
  final String title;
  final String project;
  final String description;
  final String status;

  final String priority;

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: 'Task Details',
      contentChild: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                project,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '/${selectedTeam.teamName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.appDarkGrey,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // height: 40,
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                        color: getStatusColor(
                          status,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(status.isEmpty ? 'Todo' : status,
                        style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Assigned to',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NetworkImageWidget(
                        imageUrl: user.isEmpty ? '' : user.first.profile ?? '',
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(user.first.firstName ?? user.first.lastName ?? '')
                    ],
                  )
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Priority',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.flag,
                        color: priority == 'High'
                            ? Colors.red
                            : priority == 'Medium'
                                ? Colors.yellow
                                : Colors.green,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(priority)
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
