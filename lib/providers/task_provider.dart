import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/services/database_services.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseServices databaseServices = DatabaseServices();
  String selectedProjectIndex = '';
  List<TeamModel> teamsList = [];
  List<UserModel> usersList = [];
  List<UserModel> teamMembers = [];
  List<UserModel> selectedTeamMembers = [];
  List<UserModel> selectedUsers = [];
  List<ProjectModel> projectList = [];
  List<String>? projectMembers = [];
  List<TaskModel> tasksList = [];
  List<TaskModel> priorityTasks = [];
  List<TaskModel> inProgressTask = [];
  List<TaskModel> comletedTask = [];
  List<TaskModel> pendingTask = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> selectedProjectTasks = [];
  bool isLoading = false;

  selectedProjectIndexChange(String value) {
    selectedProjectIndex = value;
    notifyListeners();
  }

  onInit() {
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
        if (projectList.isNotEmpty && selectedProjectIndex.isEmpty) {
          selectedProjectIndex = projectList.first.id ?? '';
          getProjectMembers(selectedProjectIndex);

          notifyListeners();
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

  fetchSelectedTeamMembers(String teamId) {
    selectedTeamMembers = usersList
        .where(
            (user) => user.teams?.any((team) => team.teamId == teamId) ?? false)
        .toList();
    notifyListeners();
  }

  addSelectedUsers(UserModel userData) {
    if (selectedUsers.any((element) => element.email == userData.email)) {
      selectedUsers.removeWhere((element) => element.email == userData.email);
      notifyListeners();
    } else {
      selectedUsers.add(userData);
      notifyListeners();
    }
  }

  addAllUsers(List<UserModel> userList) {
    List<String> existingEmails =
        List.from(selectedUsers.map((user) => user.email));

    for (var user in userList) {
      if (!(existingEmails.contains(user.email))) {
        selectedUsers.add(user);
        existingEmails.add(user.email);
        notifyListeners();
      }
    }

    notifyListeners();
  }

  loading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  getProjectMembers(String projectId) {
    projectMembers = projectList
        .where((element) => element.id == projectId)
        .firstWhere((element) => element.id == projectId)
        .projectMembers;

    notifyListeners();
  }

  getSelectedProjectTasks(String projectId) {
    selectedProjectTasks.clear();
    selectedProjectTasks =
        tasksList.where((element) => element.projectId == projectId).toList();
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
}
