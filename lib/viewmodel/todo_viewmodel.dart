import 'package:flutter/cupertino.dart';
import 'package:simple_todo_app/data_source/todo_data_source.dart';
import 'package:simple_todo_app/data_source/todo_local_source.dart';
import 'package:simple_todo_app/database/todo_dao.dart';
import 'package:simple_todo_app/database/todo_database.dart';
import 'package:simple_todo_app/repository/todo_repository.dart';
import 'package:simple_todo_app/utils/constant.dart';

import '../data_source/todo_remote_source.dart';
import '../model/todo.dart';

class TodoViewModel extends ChangeNotifier {
  late final ToDoRepositoryImpl _toDoRepository;
  late TodoDatabase _todoDatabase;

  bool _isFirstTimeGetDataSuccess = false;

  bool get isFirstTimeGetDataSuccess => _isFirstTimeGetDataSuccess;
  bool _isInitDatabase = false;

  void setIsFirstGetData() {
    _isFirstTimeGetDataSuccess = true;
  }

  Future<void> _initDatabase() async {
    _todoDatabase =
        await $FloorTodoDatabase.databaseBuilder(Constant.databaseName).build();
    _toDoRepository = ToDoRepositoryImpl(
        todoDataSourceLocal: TodoLocalSource(_todoDatabase.todoDao),
        todoDataSourceRemote: TodoRemoteSource());
  }

  Future<List<ToDo>> getAllToDo() async {
    if (!_isInitDatabase) {
      await _initDatabase();
      _isInitDatabase = true;
    }
    if (!_isFirstTimeGetDataSuccess) {
      await Future.delayed(const Duration(seconds: 5));
    }
    return await _toDoRepository.getAllTodos();
  }

  void insertTodo(ToDo toDo) {
    _toDoRepository.insertToDo(toDo);
    notifyListeners();
  }

  void updateTodo(ToDo toDo) {
    _toDoRepository.updateTodo(toDo);
    notifyListeners();
  }

  void removeTodo(ToDo toDo) {
    _toDoRepository.removeTodo(toDo);
    notifyListeners();
  }
}
