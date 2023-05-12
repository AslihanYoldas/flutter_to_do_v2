import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/constant.dart';
import 'package:flutter_firebase_todo_v2/pages/login_page.dart';
import 'package:flutter_firebase_todo_v2/pages/task_page.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapsshot){
          if(snapsshot.hasData){
            return TaskPage();
          }
          else{
            return LoginPage();
          }
        },
      )
    );
  }
}
