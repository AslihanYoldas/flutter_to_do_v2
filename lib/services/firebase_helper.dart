import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_todo_v2/model/database_helper_interface.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';

import '../dependency_injection/locator.dart';
import '../model/task_model.dart';


class CustomFireabseHelper implements DatabaseHelper {
  CollectionReference _ref;

  CustomFireabseHelper({
    required CollectionReference reference,
  }) : _ref = reference;


//Firebasedeki datanın okunma listeye çevrilme işlemi
  @override
  Future<List<Task>>? read() {

    final query= _ref.where("userId", isEqualTo: locator.get<AuthHelper>().getUserId());
    debugPrint("burda");
    return query.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.map((e)=>Task.fromSnapshot(e)).toList());

    //return null;
    //return _tasks.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => Task.fromSnapshot(e)).toList());
  }

  @override
  Future<bool> update(String id, String title, String tag, String desc) async {
    final docRef = _ref.doc(id);

    final newtask = Task(locator.get<AuthHelper>().getUserId(), id, title, tag, desc).toJson();
    try {
      await docRef.update(newtask);
      final query= _ref.where("userId", isEqualTo: locator.get<AuthHelper>().getUserId());
      query.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.map((e)=>Task.fromSnapshot(e)).toList());
      return true;

    } catch (e) {
      debugPrint('UPDATE Task ERROR $e');
      return false;

    }
  }

//Kullanıcı alıp firebase kullanıcının eklenmesi
  @override
  Future<bool> create(String id,String title, String tag, String desc) async {

    final docRef = _ref.doc(id);

    final newTask = Task(locator.get<AuthHelper>().getUserId(), id, title, tag, desc).toJson();
    try {
      await docRef.set(newTask);
      final query= _ref.where("userId", isEqualTo: locator.get<AuthHelper>().getUserId());
      query.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.map((e)=>Task.fromSnapshot(e)).toList());
      return true;
    } catch (e) {
      debugPrint('CREATE Task ERROR $e');
      return false;;


    }
  }

  @override
  Future<bool> delete(String id) async {
    final docRef = _ref.doc(id);
    debugPrint(id);
    debugPrint(docRef.path);
    try {
      await docRef.delete();
      return true;
    } catch (e) {
      debugPrint('DELETE Task ERROR $e');
      return false;

    }
  }

}
