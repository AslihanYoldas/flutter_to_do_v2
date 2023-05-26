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
      debugPrint('ERROR  : ${e.toString()}');
      emit(FailState(e.toString()));
    }
  }
}











