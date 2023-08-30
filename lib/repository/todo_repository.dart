import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/data_source/todo_data_source.dart';
import 'package:simple_todo_app/data_source/todo_local_source.dart';
import 'package:simple_todo_app/data_source/todo_remote_source.dart';

import '../model/todo.dart';

final todoRepositoryProvider = Provider((ref) => ToDoRepositoryImpl(ref));

class ToDoRepositoryImpl {
  ToDoRepositoryImpl(this._ref);

  late final _todoDataSourceLocal = _ref.read(todoLocalSourceProvider);
  late final _todoDataSourceRemote = _ref.read(todoRemoteSourceProvider);

  late final Ref _ref;

  void insertToDo(ToDo todo) => _todoDataSourceLocal.insertTodo(todo);

  void removeTodo(ToDo todo) => _todoDataSourceLocal.removeTodo(todo);

  void updateTodo(ToDo todo) => _todoDataSourceLocal.updateTodo(todo);

  Future<List<ToDo>> getAllTodos() => _todoDataSourceLocal.getAllTodos();
}
