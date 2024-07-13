import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/project_model.dart';
import 'package:time_tracker/models/task_model.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  addUserToFirestore(UserModel userModel) async {
    return await userCollection.doc(userModel.email).set(userModel.toJson());
  }

  Future<DocumentSnapshot> findUser(String email) async {
    return await userCollection.doc(email).get();
  }

  updateUser(UserModel data) async {
    return await userCollection.doc(data.email).update(data.toJson());
  }

  addTeams(TeamModel teamData) async {
    return await firebaseFirestore.collection('teams').add(teamData.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTeams() {
    return firebaseFirestore.collection('teams').snapshots();
  }

  deleteTeam(String teamId) async {
    return await firebaseFirestore.collection('teams').doc(teamId).delete();
  }

  updateTeam(TeamModel teamData) async {
    return await firebaseFirestore.collection('teams').doc(teamData.id).update(
          teamData.toJson(),
        );
  }

  addUserToTeam(String teamId, String userEmail, String role) async {
    return await firebaseFirestore.collection('users').doc(userEmail).update({
      'teams': FieldValue.arrayUnion([
        {'teamId': teamId, 'role': role}
      ])
    });
  }

  updateUserRole(String teamId, String userEmail, String role) async {
    return await firebaseFirestore.collection('users').doc(userEmail).update({
      'teams': FieldValue.arrayUnion([
        {'teamId': teamId, 'role': role}
      ])
    });
  }

  deleteUserFromTeam(
      {required String teamId,
      required String userEmail,
      required String role}) async {
    return await firebaseFirestore.collection('users').doc(userEmail).update({
      'teams': FieldValue.arrayRemove([
        {'role': role, 'teamId': teamId}
      ])
    });
  }

  Future<String> uploadProfileToStorage(File image) async {
    final firebaseStorage = FirebaseStorage.instance;
    try {
      var snapshot =
          await firebaseStorage.ref().child('images/').putFile(image);
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return '';
    }
  }

  createNewProject(ProjectModel projectDetails) async {
    await firebaseFirestore.collection('projects').add(
          ProjectModel(
                  title: projectDetails.title,
                  paymentType: projectDetails.paymentType,
                  selectedTeam: projectDetails.selectedTeam,
                  projectMembers: projectDetails.projectMembers,
                  price: projectDetails.price)
              .toJson(),
        );
  }

  createTask(TaskModel taskData) async {
    await firebaseFirestore.collection('tasks').add(TaskModel(
            title: taskData.title,
            description: taskData.description,
            sprint: taskData.sprint,
            priority: taskData.priority,
            assigneeId: taskData.assigneeId,
            projectId: taskData.projectId)
        .toJson());
  }

  deleteTask(String taskId) async {
    await firebaseFirestore.collection('tasks').doc(taskId).delete();
  }

  updateTask(TaskModel taskData) async {
    await firebaseFirestore.collection('tasks').doc(taskData.id).update(
          taskData.toJson(),
        );
  }

  updateTaskStatus(String taskId, Map<String, dynamic> data) async {
    await firebaseFirestore.collection('tasks').doc(taskId).update(data);
  }

  Stream settingsStream(String docName) {
    return FirebaseFirestore.instance
        .collection('user_settings')
        .doc(docName)
        .snapshots();
  }

  Stream projectsTaskSettingsStream(String docName) {
    return FirebaseFirestore.instance
        .collection('user_settings')
        .doc('projects_tasks')
        .collection('settings')
        .doc(docName)
        .snapshots();
  }

  saveScreenCaptureSettings() async {
    await firebaseFirestore
        .collection('user_settings')
        .doc('projects_tasks')
        .collection('settings')
        .doc('tasks')
        .set({
      'managerCreate': true,
      'userCreate': true,
      'managerUpdate': true,
      'userUpdate': true,
      'managerDelete': true,
      'userDelete': true,
    });
    // await firebaseFirestore
    //     .collection('user_settings')
    //     .doc('projects_tasks')
    //     .set({
    //   'weeklyTrackingReport': 'enable',
    //   'dailyTrackingReport': 'disable',
    //   'dailyWarningEmail': 'disable',
    //   'weeklyWarningEmail': 'disable'
    // });
  }

  updateSetting(Map<String, dynamic> data, String docName) async {
    await firebaseFirestore
        .collection('user_settings')
        .doc(docName)
        .update(data);
  }

  updateProjectTaskSettings(String docName, Map<String, dynamic> data) async {
    await firebaseFirestore
        .collection('user_settings')
        .doc('projects_tasks')
        .collection('settings')
        .doc(docName)
        .update(data);
  }
}
