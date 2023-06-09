
import 'package:flutter_firebase_todo_v2/model/task_model.dart';

abstract class TaskAbstract{
  Future<List<Task>>? read();
  Future<void> create( String title, String tag, String desc);
  Future<void> update(String id, String title, String tag, String desc);
  Future<bool> delete(String id);

}