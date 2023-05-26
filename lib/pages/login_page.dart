import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/utils/utils.dart';
import '../cubit/login_features/login_cubit_.dart';
import '../cubit/login_features/login_states.dart';

class LoginPage extends StatefulWidget {
  final LoginCubit _login_view_model;

  const LoginPage(LoginCubit viewModel, {Key? key})
      : _login_view_model = viewModel,
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return BlocProvider(
        create: (c) => widget._login_view_model,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
            title: Text("LOG IN"),
          ),
          body: Container(
            margin: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
            padding: EdgeInsets.all(10.0),
            child: Container(
              height: 300,
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
                    icon: const Icon(CupertinoIcons.lock_fill,
                        color: Colors.blueGrey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () async {
                      widget._login_view_model.getUser(
                          emailController.text.toString().trim(),
                          passwordController.text.toString().trim());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
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
                          routeName: '/createUser',
                          arguments: null);
                    },
                    child: const Text(
                      'Create New User',
                      style: TextStyle(color: Colors.white),
                    )),
                BlocBuilder<LoginCubit, LoginStates>(
                  builder: (context, state) {
                    debugPrint('STATE = ${state}');

                    if (state is SuccessState) {
                        Utils.navigate(
                        context: context,
                        routeName: '/task',
                        arguments: null);
    return Text("SIGN IN SUCCESSFULL");
                        }

                      else if(state is FailState){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("USER NOT FOUND:${state.message}"),
                      ));
                    }
                    return Utils.buildLoading();
                  },
                ),
              ]),
            ),
          ),
        )));
  }
}
