class TeamModel {
  String? id;
  String teamName;

  TeamModel({this.id, required this.teamName});

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      id: json['id'],
      teamName: json['teamName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'teamName': teamName,
    };
  }

  TeamModel copyWith({
    String? id,
    String? teamName,
  }) {
    return TeamModel(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
    );
  }
}
