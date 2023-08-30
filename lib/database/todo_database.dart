import 'dart:async';
import 'package:floor/floor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/utils/constant.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/todo.dart';
import 'package:simple_todo_app/database/todo_dao.dart';

part 'todo_database.g.dart'; // the generated code will be there

final todoDatabaseProvider = FutureProvider(
    (_) => $FloorTodoDatabase.databaseBuilder(Constant.databaseName).build());

@Database(version: 1, entities: [ToDo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
