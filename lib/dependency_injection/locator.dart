import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final locator=GetIt.instance;

class DependencyInjection{

  DependencyInjection(){
    provideTask();
    provideAuth();


  }
  void provideTask(){

    locator.registerLazySingleton<CollectionReference>(() => FirebaseFirestore.instance.collection('task')
    );
  }
  void provideAuth(){
    locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

        }




}