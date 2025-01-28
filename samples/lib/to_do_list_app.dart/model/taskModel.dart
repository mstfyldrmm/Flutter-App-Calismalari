import 'package:samples/to_do_list_app.dart/constants/taskType.dart';

class Taskmodel {
  final String taskName;
  final String taskDescription;
  bool isCompleted;
  final Tasktype type;

  Taskmodel({required this.isCompleted,required this.taskName, required this.taskDescription, required this.type});
}