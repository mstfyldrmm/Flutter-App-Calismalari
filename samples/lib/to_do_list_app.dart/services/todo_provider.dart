import 'package:flutter/material.dart';
import 'package:samples/to_do_list_app.dart/model/newTodoModel.dart';
import 'package:samples/to_do_list_app.dart/services/services.dart';


class TodoProvider with ChangeNotifier {
  final Services _services = Services();
  List<NewTodomodel> _todos = [];

  List<NewTodomodel> get todos => _todos;

  Future<void> fetchTodos(bool whichMethod) async {
    if (whichMethod) {
      _todos = await _services.getCompletedTodos();
    } else {
      _todos = await _services.getUncompletedTodos();
    }
    notifyListeners(); // UI'yı günceller
  }

  void toggleTodoStatus(NewTodomodel todo) {
    final index = _todos.indexOf(todo);
    if (index != -1) {
      _todos[index].isCompleted = !_todos[index].isCompleted!;
      notifyListeners(); // UI'yı günceller
    }
  }
}