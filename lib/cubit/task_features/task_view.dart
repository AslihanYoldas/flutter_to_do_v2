
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/cubit/login_features/login_view.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_cubit.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_states.dart';
import '../../dependency_injection/locator.dart';
import '../../services/auth.dart';
import '../../utils/utils.dart';
import '../../pages/to_do_page.dart';

class TaskView extends StatefulWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<TaskCubit>(),
      child: buildScaffold(),

    );
  }
  Scaffold buildScaffold() {
   return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
                // Utils.navigate(context: context, routeName: '/login', arguments: null);
                locator.get<AuthHelper>().signOut();
              },
            )
          ],
          title: const Text("TO DO LIST"),
        ),

     body: BlocConsumer<TaskCubit, TaskStates>(
       listener: (context, state) {
       },
       builder: (context, state) {

         if (state is InitState) {
           BlocProvider.of<TaskCubit>(context).fetchTaskSql();
           debugPrint("sql");
         }
         else if (state is LoadingState) {
           //return buildLoading();

         } else if (state is ResponseState) {
           debugPrint("RESPONSE ");
          /* debugPrint("${state.response.length}# "
               "${state.response[0].tag}#"
               "${state.response[0].description}#"
               "${state.response[0].title}#"
               "${state.response[0].id}#"

           );*/


           return TaskPage(responseData: state.response, task_view_model: locator.get<TaskCubit>(), selectedIndex: state.selectedIndex,);
         }

         else {
           final error = state as ErrorState;
           return buildError(error);
         }
         return buildLoading();
       },
     ));}
  Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildError(ErrorState error) {
    return Center(
      child: Text("$error"),
    );
  }
}

