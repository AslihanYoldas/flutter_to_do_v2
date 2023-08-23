import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';

import '../../dependency_injection/locator.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final AuthHelper _authHelper = locator.get<AuthHelper>();

  LoginCubit() :super(InitState());


  Future<void> getUser(String email, String password) async {
    try {
      final responseFirebase = await _authHelper.signIn(email, password);
      debugPrint('${responseFirebase?.uid}');
      emit(SuccessState(responseFirebase));
    }
    catch (e) {
      String error=e.toString();
      debugPrint('ERROR  : $error');
      int endIndex = error.indexOf(']');

      String str = error.substring( endIndex+1);
      emit(FailState(str));
    }
  }
  Future<void> Init() async {
    emit(InitState());


  }
}











