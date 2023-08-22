import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../model/todo.dart';
import 'package:simple_todo_app/database/todo_dao.dart';

part 'todo_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [ToDo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
