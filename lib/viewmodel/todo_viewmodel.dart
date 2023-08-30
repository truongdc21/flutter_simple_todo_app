import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/repository/todo_repository.dart';

import '../model/todo.dart';

final todoViewModelProvider =
    ChangeNotifierProvider((ref) => TodoViewModel(ref));

class TodoViewModel extends ChangeNotifier {
  TodoViewModel(this._ref) {
    _toDoRepository = ToDoRepositoryImpl(_ref);
  }

  final Ref _ref;
  late final ToDoRepositoryImpl _toDoRepository;

  bool _isFirstTimeGetDataSuccess = false;

  bool get isFirstTimeGetDataSuccess => _isFirstTimeGetDataSuccess;

  void setIsFirstGetData() {
    _isFirstTimeGetDataSuccess = true;
  }

  Future<List<ToDo>> getAllToDo() async {
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
