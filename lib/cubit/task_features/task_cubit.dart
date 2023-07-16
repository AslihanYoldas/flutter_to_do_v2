import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_states.dart';

import '../../../dependency_injection/locator.dart';
import '../../../services/firebase_helper.dart';
import '../../../services/sql_helper.dart';

class TaskCubit extends Cubit<TaskStates> {
  final CustomFireabseHelper _firebase = locator.get<CustomFireabseHelper>();
  final SqlHelper _sql = locator.get<SqlHelper>();

  TaskCubit() :super(InitState());

  Future<void> fetchTaskfirebase() async {
    try {
      emit(LoadingState());
      var responseFirebase = await _firebase.read();
      emit(ResponseState(responseFirebase!,1));
    }
    catch (e) {
      debugPrint('ERROR read : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> fetchTaskSql() async {
    try {
      emit(LoadingState());
      var responseSql = await _sql.read();
      emit(ResponseState (responseSql,0));
    }
    catch (e) {
      debugPrint('ERROR read : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> updateTaskFirebase(String id, String title, String tag, String desc) async {
    try {
      emit(LoadingState());
      await _firebase.update(id, title, tag, desc);
      fetchTaskfirebase();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }
  Future<void> updateTaskSql(String id, String title, String tag, String desc) async {
    try {
      emit(LoadingState());
      await _sql.update(id, title, desc, tag);
      fetchTaskSql();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> deleteTaskFirebase(String id) async {
    try {
      emit(LoadingState());
      await _firebase.delete(id);
      fetchTaskfirebase();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }
  Future<void> deleteTaskSql(String id) async {
    try {
      emit(LoadingState());
      await _sql.delete(id);
      fetchTaskSql();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }
  Future<void> createTaskFirebase(String id, String title, String tag, String desc) async {
    try {
      emit(LoadingState());
      await _firebase.create(id, title, tag, desc);
      fetchTaskfirebase();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }
  Future<void> createTaskSql(String id, String title, String tag, String desc) async {
    try {
      emit(LoadingState());
      await _sql.create(id, title, desc,tag,);
      fetchTaskSql();
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }



}


