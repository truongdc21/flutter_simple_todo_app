import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/screens/todo_list_screen.dart';
import 'package:simple_todo_app/viewmodel/todo_viewmodel.dart';

void main() {
  runApp(const MaterialApp(
    home: SafeArea(
        child: Scaffold(
          body: ProviderScope(child: ToDoListScreen()),
        )),
  ));
}
