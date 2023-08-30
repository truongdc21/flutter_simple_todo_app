import 'package:floor/floor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import '../model/todo.dart';


@dao
abstract class TodoDao {

  @Query('SELECT * FROM todo')
  Future<List<ToDo>> getAllTodos();

  @insert
  Future<void> insertTodo(ToDo todo);

  @update
  Future<void> updateTodo(ToDo todo);

  @delete
  Future<void> deleteTodo(ToDo todo);
}
