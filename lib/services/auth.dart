
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';



class AuthHelper {

  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;

  AuthHelper(this._auth, this._fireStore);


  Future<User?> signIn(String email, String password) async {
    print(email);
    print(password);
    User? user = (await _auth.signInWithEmailAndPassword(
        email: email, password: password)).user;
    //Constant.USER_ID = user!.uid;
    return user;
    }



  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createUser(String name, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    debugPrint(user.toString());
    final uid = user.user?.uid;
    final docRef = _fireStore.collection('user').doc(uid);
    await docRef.set(
        {
          'name': name,
          'email': email,
          'password': password
        });
    return user.user;

  }

  bool isUserSigned()  {

    return _auth.currentUser==null ? false: true;


  }

   String? getUserId()  {

    return _auth.currentUser?.uid;


  }


}