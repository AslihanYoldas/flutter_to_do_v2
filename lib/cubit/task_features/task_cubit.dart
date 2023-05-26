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

  Future<void> fetchTask() async {
    //try {
      emit(LoadingState());
      final responseFirebase = await _firebase.read();
      final responseSql = await _sql.read();
      //debugPrint('${responseSql.last.title}');
      //debugPrint('${responseFirebase?.last.title}');
      emit(ResponseState(responseFirebase!, responseSql));
    //}
   /* catch (e) {
      debugPrint('ERROR read : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }*/
  }

  Future<void> updateTask(String idFb, String idSql, String title, String tag,
      String desc) async {
    try {
      emit(LoadingState());
      _firebase.update(idFb, title, tag, desc);
      _sql.update(idSql, title, desc, tag);
      final responseFirebase = await _firebase.read();
      final responseSql = await _sql.read();
      emit(ResponseState(responseFirebase!, responseSql));
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> deleteTask( String idSql,) async {
    try {
      emit(LoadingState());
      //_firebase.delete(idFb);
      _sql.delete(idSql);
      final responseFirebase = await _firebase.read();
      final responseSql = await _sql.read();
      emit(ResponseState(responseFirebase!, responseSql));
    }
    catch (e) {
      debugPrint('ERROR : ${e.toString()}');
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> createTask(String title, String tag, String desc) async {
      _firebase.create(title, tag, desc);
      _sql.create(title, desc, tag);
      fetchTask();

  }


}