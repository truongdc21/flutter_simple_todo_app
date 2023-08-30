import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_app/viewmodel/todo_viewmodel.dart';

import '../model/todo.dart';

class ToDoListScreen extends HookConsumerWidget {
  const ToDoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoViewModel = ref.watch(todoViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-do List'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<List<ToDo>>(
            future: todoViewModel.getAllToDo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !todoViewModel.isFirstTimeGetDataSuccess) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data != null) {
                List<ToDo>? listTodo = snapshot.data;
                if (listTodo == null) {
                  return const Text("Data is Null");
                } else {
                  return ListView.builder(
                      itemCount: listTodo.length,
                      itemBuilder: (context, index) {
                        todoViewModel.setIsFirstGetData();
                        return TodoItem(listTodo[index], (newValue) {
                          final todo = listTodo[index];
                          todo.isCheck = newValue;
                          todoViewModel.updateTodo(todo);
                          showMySnackBar(context, 'Update task successfully!');
                        }, () {
                          todoViewModel.removeTodo(listTodo[index]);
                          showMySnackBar(context, 'Remove task successfully');
                        });
                      });
                }
              } else {
                var ex = snapshot.error;
                return Text(" Exception : $ex");
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskBottomSheet(context, (srtTaskName, srtTaskDetail) {
              todoViewModel
                  .insertTodo(ToDo(null, srtTaskName, srtTaskDetail, false));
              showMySnackBar(context, 'Insert task successfully');
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}

class TodoItem extends StatefulWidget {
  late ToDo todoTask;
  Function(bool) onCheckboxChanged;
  Function() onRemoveTask;

  TodoItem(this.todoTask, this.onCheckboxChanged, this.onRemoveTask,
      {super.key});

  @override
  TodoItemState createState() => TodoItemState();
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: styleTextLineThrough(
                            isCompleted: widget.todoTask.isCheck)),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.todoTask.todoTask,
                    style: TextStyle(
                        decoration: styleTextLineThrough(
                            isCompleted: widget.todoTask.isCheck)),
                  )
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
                IconButton(
                    onPressed: () {
                      widget.onRemoveTask();
                    },
                    icon: const Icon(Icons.delete))
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

  const CheckBoxToDo(this.isCheck, this.onClickButton, {super.key});

  @override
  CheckBoxToDoSate createState() => CheckBoxToDoSate();
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

void _showAddTaskBottomSheet(
    BuildContext context, Function(String, String) onAddTask) {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDetailController = TextEditingController();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white38,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: Container(
                      color: Colors.grey,
                      child: const Center(
                        child: Text(
                          "Add Task",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: taskNameController,
                      decoration: const InputDecoration(
                          labelText: 'Enter your task name!'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      controller: taskDetailController,
                      decoration: const InputDecoration(
                          labelText: 'Enter your task detail!'),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        onAddTask(
                            taskNameController.text, taskDetailController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Add Task')),
                  const SizedBox(
                    height: 35,
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

void showMySnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 1),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        /** Hide SnackBar **/
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  /** Show SnackBar **/
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

TextDecoration styleTextLineThrough({required bool isCompleted}) {
  if (isCompleted) {
    return TextDecoration.lineThrough;
  } else {
    return TextDecoration.none;
  }
}
