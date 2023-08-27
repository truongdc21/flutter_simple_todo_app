import 'package:simple_todo_app/data_source/todo_data_source.dart';
import 'package:simple_todo_app/data_source/todo_local_source.dart';

import '../model/todo.dart';

class ToDoRepositoryImpl {
  late final TodoDataSourceLocal todoDataSourceLocal;
  late final TodoDataSourceRemote todoDataSourceRemote;

  ToDoRepositoryImpl({ required this.todoDataSourceLocal, required this.todoDataSourceRemote});

  void insertToDo(ToDo todo) => todoDataSourceLocal.insertTodo(todo);

  void removeTodo(ToDo todo) => todoDataSourceLocal.removeTodo(todo);

  void updateTodo(ToDo todo) => todoDataSourceLocal.updateTodo(todo);

  Future<List<ToDo>> getAllTodos() => todoDataSourceLocal.getAllTodos();
}
