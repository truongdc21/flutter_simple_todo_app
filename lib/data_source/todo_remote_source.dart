import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/data_source/todo_data_source.dart';

final todoRemoteSourceProvider = Provider((_) => TodoRemoteSource());

class TodoRemoteSource implements TodoDataSourceRemote {}
