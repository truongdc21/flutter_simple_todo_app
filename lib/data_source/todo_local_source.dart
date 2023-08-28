import 'package:simple_todo_app/data_source/todo_data_source.dart';
import 'package:simple_todo_app/database/todo_dao.dart';

import '../model/todo.dart';

class TodoLocalSource implements TodoDataSourceLocal {
  final TodoDao _todoDao;

  TodoLocalSource(this._todoDao);

  @override
  Future<List<ToDo>> getAllTodos() {
    return _todoDao.getAllTodos();
  }

  @override
  void insertTodo(ToDo todo) => _todoDao.insertTodo(todo);

  @override
  void removeTodo(ToDo todo) => _todoDao.deleteTodo(todo);

  @override
  void updateTodo(ToDo todo) => _todoDao.updateTodo(todo);
}
