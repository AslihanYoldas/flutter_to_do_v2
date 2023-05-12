import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase_helper.dart';
import '../services/auth.dart';
import '../widget/create_user.dart';
import 'task_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text("LOG IN"),
      ),
      body: Container(
        margin:EdgeInsets.fromLTRB(10.0,50.0,10.0,10.0),
        padding: EdgeInsets.all(10.0),

        child: Container(
          height: 300
          ,
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Enter your e mail',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.mail_solid, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                controller: passwordController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.lock_fill, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              ElevatedButton(
                  onPressed:() async {
                    User? result= await signIn(emailController.text.toString().trim(),passwordController.text.toString().trim());
                    if(result==null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("USER NOT FOUND"),
                      ));
                    }
                    else{

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("SIGN IN SUCCESSFULL"),
                      ));
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> TaskPage()));
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey,padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
                  child: Text("LOG IN")),
              SizedBox(height: 20.0,),
              Text("If you don't have an account", style: TextStyle(color: Colors.blue),),
              TextButton(
                style: ElevatedButton.styleFrom(backgroundColor:Colors.blueGrey,
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateUser()));
                },
                child: const Text('Create New User',
                style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
