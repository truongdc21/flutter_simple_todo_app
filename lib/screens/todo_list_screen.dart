import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoListScreen extends StatefulWidget {
  List<ToDo> mListToDo = [
    ToDo(1, "Task A", "message from task A", true),
    ToDo(1, "Task B", "message from task B", false)
  ];

  @override
  State<StatefulWidget> createState() {
    return ToDoListScreenState();
  }
}

class ToDoListScreenState extends State<ToDoListScreen> {
  void _handleCheckboxChanged(int index, bool newValue) {
    setState(() {
      widget.mListToDo[index].isCheck = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
              itemCount: widget.mListToDo.length,
              itemBuilder: (context, index) {
                return TodoItem(widget.mListToDo[index],
                    (newValue) => _handleCheckboxChanged(index, newValue));
              })),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          widget.mListToDo
              .add(ToDo(0, 'Task Add', 'messaging from task Add', false));
        });
      }),
    );
  }
}

class TodoItem extends StatefulWidget {
  late ToDo todoTask;

  final Function(bool) onCheckboxChanged;

  TodoItem(this.todoTask, this.onCheckboxChanged, {super.key});

  @override
  State<StatefulWidget> createState() {
    return TodoItemState();
  }
}

class TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    widget.todoTask.taskName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.todoTask.todoTask)
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CheckBoxToDo(widget.todoTask.isCheck,
                    (newValue) => {widget.onCheckboxChanged(newValue)}),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.delete)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxToDo extends StatefulWidget {

  final bool isCheck;
  final Function(bool) onClickButton;

  void onClickCheckbox(bool newValue) {
    onClickButton(newValue);
  }

  CheckBoxToDo(this.isCheck, this.onClickButton, {super.key});

  @override
  State<StatefulWidget> createState() {
    return CheckBoxToDoSate();
  }
}

class CheckBoxToDoSate extends State<CheckBoxToDo> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.isCheck,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          widget.onClickCheckbox(newValue);
        }
      },
    );
  }
}
