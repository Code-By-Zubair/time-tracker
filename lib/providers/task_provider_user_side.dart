import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/providers/shared_pref_provider.dart';
import 'package:time_tracker/services/database_services.dart';

class TaskProviderUserSide extends ChangeNotifier {
  final DatabaseServices databaseServices = DatabaseServices();
  int selectedTab = 0;
  String selectedTabName = 'Projects';
  String selectedProjectIndex = '';
  List<UserModel> usersList = [];
  List<TeamModel> teamsList = [];
  List<ProjectModel> projectList = [];
  List<String>? projectMembers = [];
  List<TaskModel> tasksList = [];
  List<TaskModel> selectedProjectTasks = [];
  List<ProjectModel> userProjects = [];
  List<TaskModel> priorityTasks = [];
  List<TaskModel> inProgressTask = [];
  List<TaskModel> comletedTask = [];
  List<TaskModel> pendingTask = [];
  List<TaskModel> todoTasks = [];
  onInit(BuildContext context) {
    databaseServices.getTeams().listen((QuerySnapshot teamSnapshot) {
      teamsList = teamSnapshot.docs.map((doc) {
        return TeamModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
      }).toList();

      notifyListeners();
    });

    // Users Stream
    FirebaseFirestore.instance.collection('users').snapshots().listen(
      (QuerySnapshot userSnapshot) {
        usersList = userSnapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id);
        }).toList();

        notifyListeners();
      },
    );
    FirebaseFirestore.instance.collection('projects').snapshots().listen(
      (QuerySnapshot projectSnapshot) {
        projectList = projectSnapshot.docs.map((doc) {
          return ProjectModel.fromJson(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id);
        }).toList();
        for (int i = 0; i <= projectList.length; i++) {
          userProjects = projectList
              .where((element) => element.projectMembers.contains(
                  Provider.of<SharedPrefProvider>(context, listen: false)
                          .data
                          ?.email ??
                      ''))
              .toList();
        }
        if (userProjects.isNotEmpty && selectedProjectIndex.isEmpty) {
          selectedProjectIndex = userProjects.first.id ?? '';
        }

        notifyListeners();
      },
    );
    FirebaseFirestore.instance
        .collection('tasks')
        .snapshots()
        .listen((QuerySnapshot tasksSnapshot) {
      tasksList = tasksSnapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
      }).toList();
      selectedProjectTasks.clear();
      if (tasksList.isNotEmpty && selectedProjectIndex.isNotEmpty) {
        getSelectedProjectTasks(selectedProjectIndex);
      }
      notifyListeners();
    });
  }

  getProjectMembers(String projectId) {
    projectMembers = projectList
        .where((element) => element.id == projectId)
        .firstWhere((element) => element.id == projectId)
        .projectMembers;

    notifyListeners();
  }

  getSelectedProjectTasks(String projectId) {
    selectedProjectTasks =
        tasksList.where((element) => (element.projectId == projectId)).toList();
    priorityTasks = selectedProjectTasks
        .where(
          (element) => (element.status == 'priority'),
        )
        .toList();
    inProgressTask = selectedProjectTasks
        .where(
          (element) => (element.status == 'inprogress'),
        )
        .toList();
    comletedTask = selectedProjectTasks
        .where(
          (element) => (element.status == 'completed'),
        )
        .toList();
    pendingTask = selectedProjectTasks
        .where(
          (element) => (element.status == 'pending'),
        )
        .toList();
    todoTasks = selectedProjectTasks
        .where(
          (element) =>
              (element.status == 'todo' || (element.status?.isEmpty ?? true)),
        )
        .toList();
    notifyListeners();
  }

  changeTab(int value) {
    selectedTab = value;
    notifyListeners();
  }

  selectedProjectIndexChange(String value) {
    selectedProjectIndex = value;
    notifyListeners();
  }
}
