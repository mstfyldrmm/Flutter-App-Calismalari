class NewTodomodel {
  String? taskName;
  String? taskDescription;
  bool? isCompleted;
  String? type;

  NewTodomodel({required this.taskName, required this.isCompleted, required this.taskDescription, required this.type});

  NewTodomodel.fromJson(Map<String, dynamic> json) {
    taskName = json["taskName"];
    taskDescription = json["taskDescription"];
    isCompleted = json["isCompleted"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["taskName"] = taskName;
    data["taskDescription"] = taskDescription;
    data["isCompleted"] = isCompleted;
    data["type"] = type;

    return data;
  }
}