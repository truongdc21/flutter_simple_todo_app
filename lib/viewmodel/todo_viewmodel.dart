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
  late ToDoRepositoryImpl _toDoRepository;
  late TodoDatabase _todoDatabase;

  final List<ToDo> _listTodo = [];

  List<ToDo> get listTodo => _listTodo;

  TodoViewModel() {
    _initDatabase();
  }

  void _initDatabase() async {
    _todoDatabase =
        await $FloorTodoDatabase.databaseBuilder(Constant.databaseName).build();
    _toDoRepository = ToDoRepositoryImpl(
        TodoLocalSource(_todoDatabase.todoDao), TodoRemoteDataSource());
    _updateListTodo();
  }

  void _updateListTodo() async {
    _listTodo.clear();
    _listTodo.addAll(await _toDoRepository.getAllTodos());
    notifyListeners();
  }

  void insertTodo(ToDo toDo) {
    _toDoRepository.insertToDo(toDo);
    _updateListTodo();
  }

  void updateTodo(ToDo toDo) {
    _toDoRepository.updateTodo(toDo);
    _updateListTodo();
  }

  void removeTodo(ToDo toDo) {
    _toDoRepository.removeTodo(toDo);
    _updateListTodo();
  }
}
