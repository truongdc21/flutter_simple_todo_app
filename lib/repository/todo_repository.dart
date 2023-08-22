import 'package:simple_todo_app/data_source/todo_data_source.dart';

import '../model/todo.dart';

class ToDoRepositoryImpl {
  final TodoDataSourceLocal _todoDataSourceLocal;
  final TodoDataSourceRemote _todoDataSourceRemote;

  ToDoRepositoryImpl(this._todoDataSourceLocal, this._todoDataSourceRemote);

  void insertToDo(ToDo todo) => _todoDataSourceLocal.insertTodo(todo);

  void removeTodo(ToDo todo) => _todoDataSourceLocal.removeTodo(todo);

  void updateTodo(ToDo todo) => _todoDataSourceLocal.updateTodo(todo);

  Future<List<ToDo>> getAllTodos() => _todoDataSourceLocal.getAllTodos();
}
