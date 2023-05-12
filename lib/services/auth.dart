
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_todo_v2/constant.dart';

import '../dependency_injection/locator.dart';

final _auth= locator.get<FirebaseAuth>();
final _fireStore=locator.get<FirebaseFirestore>();


Future<User?> signIn(String email,String password) async{
  try{
    print(email);
    print(password);
    User? user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    Constant.USER_ID=user!.uid;
    return  user;


  } catch(e){
    debugPrint("SIGN IN ERROR");
    }
  return null;

}

Future<void> signOut() async{
  return await _auth.signOut();

}

Future<User?> createUser (String name ,String email,String password) async {
  try {
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    debugPrint(user.toString());
    final uid=user.user?.uid;
    final docRef=_fireStore.collection('user').doc(uid);
    await docRef.set(
        {
          'name': name,
          'email': email,
          'password': password
        });
    return user.user;
  }catch(e){
    debugPrint("CREATE USER ERROR");

  }
  return null;
}
