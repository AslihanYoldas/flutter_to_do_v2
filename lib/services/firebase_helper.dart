import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../constant.dart';
import '../dependency_injection/locator.dart';
import '../model/task_model.dart';



final _tasks= locator.get<CollectionReference>();

//Firebasedeki datanın okunma listeye çevrilme işlemi
Stream<List<Task>> read() {

  return _tasks.where("userId", isEqualTo: Constant.USER_ID).snapshots().map((querySnapshot) =>querySnapshot.docs.map((e)=> Task.fromSnapshot(e)).toList());
  //return _tasks.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => Task.fromSnapshot(e)).toList());
}
Future update( String id,String title, String tag, String desc) async{

  final docRef=_tasks.doc(id);

  final newtask=Task(Constant.USER_ID,id,title,tag,desc).toJson();
  try{
    await docRef.update(newtask);

  }catch(e){
    debugPrint('UPDATE Task ERROR $e');
  }
}
//Kullanıcı alıp firebase kullanıcının eklenmesi
Future create(String title, String tag, String desc) async{
  final uid=_tasks.doc().id;
  final docRef=_tasks.doc(uid);

  final newTask=Task(Constant.USER_ID,uid,title,tag,desc).toJson();
  try{
    await docRef.set(newTask);

  }catch(e){
    debugPrint('CREATE Task ERROR $e');
  }
}
Future delete(String id) async{

  final docRef=_tasks.doc(id);


  try{
    await docRef.delete();

  }catch(e){
    debugPrint('DELETE Task ERROR $e');
  }
}


