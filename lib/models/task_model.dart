class TaskModel {
  String? id;
  String? title;
  String? description;
  String? sprint;
  String? priority;
  String? assigneeId;
  String projectId;
  String? status;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.sprint,
    this.priority,
    this.assigneeId,
    this.status,
    required this.projectId,
  });

  // CopyWith method
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? sprint,
    String? priority,
    String? assigneeId,
    String? projectId,
    String? status,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sprint: sprint ?? this.sprint,
      priority: priority ?? this.priority,
      assigneeId: assigneeId ?? this.assigneeId,
      projectId: projectId ?? this.projectId,
      status: status ?? this.status,
    );
  }

  // ToJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'sprint': sprint,
      'priority': priority,
      'assigneeId': assigneeId,
      'projectId': projectId,
      'status': status,
    };
  }

  // FromJson method
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        sprint: json['sprint'] ?? '',
        priority: json['priority'] ?? '',
        assigneeId: json['assigneeId'] ?? '',
        status: json['status'] ?? '',
        projectId: json['projectId'] ?? '');
  }
}
