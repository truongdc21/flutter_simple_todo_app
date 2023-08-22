
import 'package:floor/floor.dart';

@Entity()
class ToDo {

  @PrimaryKey(autoGenerate: true)
  int? id;
  String taskName = '';
  String todoTask = '';
  bool isCheck = false;

  ToDo(this.id, this.taskName, this.todoTask, this.isCheck);
}