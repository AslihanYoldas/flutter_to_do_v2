import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

final locator=GetIt.instance;

class DependencyInjection{

  DependencyInjection(){
    provideTask();

  }
  void provideTask(){

    locator.registerLazySingleton<CollectionReference>(() => FirebaseFirestore.instance.collection('task')
    );
  }


}