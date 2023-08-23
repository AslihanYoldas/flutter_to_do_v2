import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/pages/login_page.dart';
import 'package:flutter_firebase_todo_v2/widget/error_message.dart';
import '../../dependency_injection/locator.dart';
import '../../model/route_argument.dart';
import '../../utils/utils.dart';
import '../task_features/task_view.dart';
import 'login_cubit_.dart';
import 'login_states.dart';


class LoginView extends StatelessWidget {


  const LoginView({Key? key}):super(key: key);



@override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<LoginCubit>(),
      child: buildScaffold(),);
  }

  BlocConsumer<LoginCubit, LoginStates> buildScaffold() {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is InitState) {
          return const LoginPage();
        } else if (state is SuccessState) {
          return const TaskView();
        } else if (state is FailState) {

          return ErrorMessage(message: state.message);

        }

        return const Text("HATA");
      },
    );
  }
}

