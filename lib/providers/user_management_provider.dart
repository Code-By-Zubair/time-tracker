
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/models/teams_model.dart';
import 'package:time_tracker/models/user_model.dart';
import 'package:time_tracker/services/database_services.dart';

class UserManagementProvider extends ChangeNotifier {
  DatabaseServices databaseServices = DatabaseServices();
  List<TeamModel> teamsList = [];
  List<UserModel> usersList = [];
  List<UserModel> teamMembers = [];
  String teamMemberRole = '';
  String selectedTeam = '';

  onInit() {
    databaseServices.getTeams().listen((QuerySnapshot teamSnapshot) {
      teamsList = teamSnapshot.docs.map((doc) {
        return TeamModel.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id);
      }).toList();
      if (selectedTeam.isEmpty && teamsList.isNotEmpty) {
        selectedTeam = teamsList.first.id ?? '';
        notifyListeners();
      }
      notifyListeners();
    });

    // Users Stream
    FirebaseFirestore.instance.collection('users').snapshots().listen(
      (QuerySnapshot userSnapshot) {
        usersList = userSnapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data() as Map<String, dynamic>)
              .copyWith(id: doc.id);
        }).toList();
        if (selectedTeam.isNotEmpty) {
          teamMembers = usersList.where((element) {
            final v =
                element.teams?.where((e) => e.teamId == selectedTeam).toList();
            if (v != null && v.isNotEmpty) {
              return true;
            }
            return false;
          }).toList();
          notifyListeners();
        }
        notifyListeners();
      },
    );
  }

  selectTeamFunc(String val) {
    selectedTeam = val;
    notifyListeners();
  }

  teamMemberRoleFunc(String role) {
    teamMemberRole = role;
    notifyListeners();
  }
}
