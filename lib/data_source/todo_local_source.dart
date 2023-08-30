import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/data_source/todo_data_source.dart';
import 'package:simple_todo_app/database/todo_dao.dart';
import 'package:simple_todo_app/database/todo_database.dart';
import 'package:simple_todo_app/utils/constant.dart';

import '../model/todo.dart';

final todoLocalSourceProvider = Provider((ref) => TodoLocalSource(ref));

class TodoLocalSource implements TodoDataSourceLocal {
  TodoLocalSource(this._ref) {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    _todoDatabase =
        await $FloorTodoDatabase.databaseBuilder(Constant.databaseName).build();
    _todoDao = _todoDatabase.todoDao;
  }

  final Ref _ref;
  late final TodoDatabase _todoDatabase;
  late final TodoDao _todoDao;

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
