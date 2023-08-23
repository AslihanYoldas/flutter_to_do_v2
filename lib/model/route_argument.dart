
import 'package:flutter_firebase_todo_v2/model/task_model.dart';

class Arg{
  Task? task;
  int? selectedIndex;


  Arg(this.task,this.selectedIndex);


  void setTask(Task task){
    this.task=task;
  }
  void setSelectedIndex(int selectedIndex){
    this.selectedIndex=selectedIndex;
  }
}