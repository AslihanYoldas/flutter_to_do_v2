import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubit/login_features/login_cubit_.dart';
import '../dependency_injection/locator.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
  emailController.dispose();
  passwordController.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                automaticallyImplyLeading:false,
                backgroundColor: Colors.blueGrey,
                centerTitle: true,
                title: Text("LOG IN")),
            body: Container(
                margin: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
                padding: EdgeInsets.all(10.0),
                child: Container(
                    height: 350,
                    child: SingleChildScrollView(
                      child: Column(children: [
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
                            icon: const Icon(CupertinoIcons.mail_solid,
                                color: Colors.blueGrey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black54,
                                width: 2.0,
                              ),
                          ),
                        ),
                        ),
                        const SizedBox(height: 15),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscured,
                        controller: passwordController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(fontSize: 14),
                          icon: const Icon(CupertinoIcons.lock_fill,
                            color: Colors.blueGrey,
                          ),

                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 27,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.black54,
                              width: 2.0,
                            ),


                        ),
                      ),
                      ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              locator.get<LoginCubit>().getUser(
                                  emailController.text.toString().trim(),
                                  passwordController.text.toString().trim());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10)),
                            child: Text("LOG IN")),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "If you don't have an account",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: () {
                                Utils.navigate(
                                context: context,
                                routeName: '/createUser', arguments: null,
                                );
                            },
                            child: const Text(
                              'Create New User',
                              style: TextStyle(color: Colors.white),
                            )),
                      ]),
                    )))));
  }
}
