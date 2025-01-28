import 'dart:convert';

import 'package:samples/to_do_list_app.dart/model/newTodoModel.dart';
import 'package:http/http.dart' as http;

class Services {
  final String url = 'http://192.168.3.35:3000/todos';


  Future<List<NewTodomodel>> getUncompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseTodos = jsonDecode(response.body);
      List<NewTodomodel> todos = [];

      responseTodos.forEach((element) {
        NewTodomodel task = NewTodomodel.fromJson(element);

        if (task.isCompleted! == false) {
          todos.add(task);
        }
      });

      return todos;
    } else {
      print(response.statusCode);
      throw Exception(
          "Failed to load todosStatus code: ${response.statusCode}");
    }
  }

  Future<List<NewTodomodel>> getCompletedTodos() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseTodos = jsonDecode(response.body);
      List<NewTodomodel> todos = [];

      responseTodos.forEach((element) {
        NewTodomodel task = NewTodomodel.fromJson(element);

        if (task.isCompleted! == true) {
          todos.add(task);
        }
      });

      return todos;
    } else {
      throw Exception(
          "Failed to load todosStatus code: ${response.statusCode}");
    }
  }

  Future<String> addTodo(NewTodomodel newTodo) async{
    final response = await http.post(Uri.parse(url),
      body: jsonEncode(newTodo.toJson()),
      headers: <String, String> {
        "Content-Type" : "application/json; charset=UTF-8"
      }
    );
    
    return response.body;
  }
}
