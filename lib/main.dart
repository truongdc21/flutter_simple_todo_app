import 'package:flutter/material.dart';
import 'package:simple_todo_app/screens/todo_list_screen.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
        child: Scaffold(
      body: ToDoListScreen(),
    )),
  ));
}
