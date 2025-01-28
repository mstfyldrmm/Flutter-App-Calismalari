import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:samples/to_do_list_app.dart/model/todoModel.dart';

class TodoServices {
  final String url = 'https://dummyjson.com/todos';

  Future<List<TodoModel>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> responseTodos = jsonDecode(response.body)["todos"];
      List<TodoModel> todos = [];

      responseTodos.forEach((element) {
        TodoModel task = TodoModel.fromJson(element);
        if(task.completed! == false) {
          todos.add(task);
        }
      });

      return todos;
    } else {
      throw Exception("Failed to load todos. Status code: ${response.statusCode}");
    }
  }

    Future<List<TodoModel>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      List<dynamic> responseTodos = jsonDecode(response.body)["todos"];
      List<TodoModel> todos = [];

      responseTodos.forEach((element) {
        TodoModel task = TodoModel.fromJson(element);
        if(task.completed! == true) {
          todos.add(task);
        }
      });

      return todos;
    } else {
      throw Exception("Failed to load todos. Status code: ${response.statusCode}");
    }
  }
}
