import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_todo_app/screens/todo_list_screen.dart';
import 'package:simple_todo_app/viewmodel/todo_viewmodel.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
        child: ChangeNotifierProvider(
      create: (_) => TodoViewModel(),
      child: const Scaffold(
        body: ToDoListScreen(),
      ),
    )),
  ));
}
