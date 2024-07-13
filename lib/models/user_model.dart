class TeamData {
  String role;
  String teamId;

  TeamData({
    required this.role,
    required this.teamId,
  });

  factory TeamData.fromJson(Map<String, dynamic> json) {
    return TeamData(
      role: json['role'],
      teamId: json['teamId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'teamId': teamId,
    };
  }
}

class UserModel {
  String? firstName;
  String? lastName;
  String email;
  String? organizationUserName;
  String? id;
  String? profile;
  List<TeamData>? teams; // List of teams, can be null
  String role;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.profile,
    this.organizationUserName,
    required this.email,
    required this.role,
    this.teams,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Extract teams from JSON if available
    List<dynamic>? teamsJson = json['teams'];
    List<TeamData>? teams;

    if (teamsJson != null) {
      teams = teamsJson.map((team) => TeamData.fromJson(team)).toList();
    }

    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      organizationUserName: json['organizationUserName'],
      email: json['email'],
      id: json['id'],
      profile: json['profile'],
      role: json['role'],
      teams: teams,
    );
  }

  Map<String, dynamic> toJson() {
    // Convert teams to JSON if available
    List<Map<String, dynamic>>? teamsJson;
    if (teams != null) {
      teamsJson = teams!.map((team) => team.toJson()).toList();
    }

    return {
      'firstName': firstName,
      'lastName': lastName,
      'organizationUserName': organizationUserName,
      'email': email,
      'id': id,
      'profile': profile,
      'role': role,
      'teams': teamsJson,
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? organizationUserName,
    String? id,
    String? profile,
    String? role,
    List<TeamData>? teams,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      organizationUserName: organizationUserName ?? this.organizationUserName,
      id: id ?? this.id,
      profile: profile ?? this.profile,
      role: role ?? this.role,
      teams: teams ?? this.teams,
    );
  }
}
