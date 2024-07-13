class ProjectModel {
  final String title;
  final String paymentType;
  final String? selectedTeam;

  final List<String> projectMembers;
  final String? id;
  final double? price;

  ProjectModel({
    required this.projectMembers,
    required this.title,
    required this.paymentType,
    this.selectedTeam,
 
    this.id,
    this.price,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    List<String> projectMembers = [];
    if (json['projectMembers'] != null) {
      projectMembers = List<String>.from(json['projectMembers']);
    }

    return ProjectModel(
      title: json['title'],
      paymentType: json['paymentType'],
      selectedTeam: json['selectedTeam'],
      id: json['id'],
      price: json['price'],
      projectMembers: projectMembers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'paymentType': paymentType,
      'selectedTeam': selectedTeam,
      'id': id,
      'price': price,
      'projectMembers': projectMembers,
    };
  }

  ProjectModel copyWith({
    String? title,
    String? paymentType,
    String? selectedTeam,
    List<String>? projectMembers,
    double? price,
    String? id,
  }) {
    return ProjectModel(
      title: title ?? this.title,
      paymentType: paymentType ?? this.paymentType,
      selectedTeam: selectedTeam ?? this.selectedTeam,
      price: price ?? this.price,
      id: id ?? this.id,
      projectMembers: projectMembers ?? this.projectMembers,
    );
  }
}
