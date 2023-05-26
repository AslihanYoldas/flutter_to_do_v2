import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_todo_v2/model/task_abstract.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';

import '../dependency_injection/locator.dart';
import '../model/task_model.dart';


class CustomFireabseHelper implements TaskAbstract  {
  CollectionReference _ref;

  CustomFireabseHelper({
    required CollectionReference reference,
  }) : _ref = reference;


//Firebasedeki datanın okunma listeye çevrilme işlemi
  @override
  Future<List<Task>>? read() {

    final query= _ref.where("userId", isEqualTo: locator.get<AuthHelper>().getUserId());
    return query.get().then((QuerySnapshot querySnapshot) => querySnapshot.docs.map((e)=>Task.fromSnapshot(e)).toList());

    //return null;
    //return _tasks.snapshots().map((querySnapshot) => querySnapshot.docs.map((e) => Task.fromSnapshot(e)).toList());
  }

  @override
  Future <bool> update(String id, String title, String tag, String desc) async {
    final docRef = _ref.doc(id);

    final newtask = Task.firebase(locator.get<AuthHelper>().getUserId(), id, title, tag, desc).toJson();
    try {
      await docRef.update(newtask);
      return true;
    } catch (e) {
      debugPrint('UPDATE Task ERROR $e');
      return false;
    }
  }

//Kullanıcı alıp firebase kullanıcının eklenmesi
  @override
  Future<bool> create(String title, String tag, String desc) async {
    final uid = _ref
        .doc()
        .id;
    final docRef = _ref.doc(uid);

    final newTask = Task.firebase(locator.get<AuthHelper>().getUserId(), uid, title, tag, desc).toJson();
    try {
      await docRef.set(newTask);
      return true;
    } catch (e) {
      debugPrint('CREATE Task ERROR $e');
      return false;
    }
  }

  @override
  Future<bool> delete(String id) async {
    final docRef = _ref.doc(id);


    try {
      await docRef.delete();
      return true;
    } catch (e) {
      debugPrint('DELETE Task ERROR $e');
      return false;

    }
  }

}
