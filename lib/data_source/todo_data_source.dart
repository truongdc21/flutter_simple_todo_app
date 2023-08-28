import 'package:simple_todo_app/data_source/todo_local_source.dart';
import 'package:simple_todo_app/model/todo.dart';

import '../database/todo_dao.dart';

abstract class TodoDataSourceLocal {
  void insertTodo(ToDo todo);

  void updateTodo(ToDo todo);

  void removeTodo(ToDo todo);

  Future<List<ToDo>> getAllTodos();
}

abstract class TodoDataSourceRemote {}
