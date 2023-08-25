// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorTodoDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TodoDatabaseBuilder databaseBuilder(String name) =>
      _$TodoDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$TodoDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$TodoDatabaseBuilder(null);
}

class _$TodoDatabaseBuilder {
  _$TodoDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$TodoDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$TodoDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<TodoDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$TodoDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$TodoDatabase extends TodoDatabase {
  _$TodoDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ToDo` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `taskName` TEXT NOT NULL, `todoTask` TEXT NOT NULL, `isCheck` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _toDoInsertionAdapter = InsertionAdapter(
            database,
            'ToDo',
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'taskName': item.taskName,
                  'todoTask': item.todoTask,
                  'isCheck': item.isCheck ? 1 : 0
                }),
        _toDoUpdateAdapter = UpdateAdapter(
            database,
            'ToDo',
            ['id'],
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'taskName': item.taskName,
                  'todoTask': item.todoTask,
                  'isCheck': item.isCheck ? 1 : 0
                }),
        _toDoDeletionAdapter = DeletionAdapter(
            database,
            'ToDo',
            ['id'],
            (ToDo item) => <String, Object?>{
                  'id': item.id,
                  'taskName': item.taskName,
                  'todoTask': item.todoTask,
                  'isCheck': item.isCheck ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ToDo> _toDoInsertionAdapter;

  final UpdateAdapter<ToDo> _toDoUpdateAdapter;

  final DeletionAdapter<ToDo> _toDoDeletionAdapter;

  @override
  Future<List<ToDo>> getAllTodos() async {
    return _queryAdapter.queryList('SELECT * FROM todo',
        mapper: (Map<String, Object?> row) => ToDo(
            row['id'] as int,
            row['taskName'] as String,
            row['todoTask'] as String,
            (row['isCheck'] as int) != 0));
  }

  @override
  Future<void> insertTodo(ToDo todo) async {
    await _toDoInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTodo(ToDo todo) async {
    await _toDoUpdateAdapter.update(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(ToDo todo) async {
    await _toDoDeletionAdapter.delete(todo);
  }
}
