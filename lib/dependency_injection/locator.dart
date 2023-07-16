import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_cubit.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';
import 'package:flutter_firebase_todo_v2/services/firebase_helper.dart';
import 'package:flutter_firebase_todo_v2/services/sql_helper.dart';
import 'package:get_it/get_it.dart';

import '../cubit/login_features/login_cubit_.dart';

final locator=GetIt.instance;

class DependencyInjection{

  DependencyInjection(){
    provideTask();
    provideAuth();
    provideHelpers();
    provideCubit();

  }
  void provideTask(){

    locator.registerLazySingleton<CollectionReference>(() => FirebaseFirestore.instance.collection('task')
    );
  }
  void provideAuth(){
    locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

        }


  void provideHelpers(){
    locator.registerLazySingleton<CustomFireabseHelper>(() => CustomFireabseHelper(reference: locator.get<CollectionReference>()));
    locator.registerLazySingleton<SqlHelper>(() => SqlHelper());
    locator.registerLazySingleton<AuthHelper>(() => AuthHelper(locator.get<FirebaseAuth>(),locator.get<FirebaseFirestore>()));
  }

  void provideCubit() {
    locator.registerLazySingleton<TaskCubit>(() => TaskCubit());
    locator.registerLazySingleton<LoginCubit>(() => LoginCubit());
  }



}