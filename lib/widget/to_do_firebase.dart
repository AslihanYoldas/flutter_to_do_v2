import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_cubit.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_states.dart';
import 'package:flutter_firebase_todo_v2/widget/new_task.dart';
import '../dependency_injection/locator.dart';
import '../model/task_model.dart';
import '../services/auth.dart';
import '../utils/utils.dart';
import 'update_task.dart';

const List<Color> colorList = <Color>[Colors.green, Colors.blue, Colors.orange];

class TaskFirebase extends StatelessWidget {
  final TaskCubit _task_view_model;

  const TaskFirebase({Key? key,  required TaskCubit viewModel}) : _task_view_model = viewModel, super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => _task_view_model,
      child: BlocBuilder<TaskCubit, TaskStates>(
          builder: (context, state) {
        debugPrint('STATE = ${state}');
        if (state is InitState) {
          _task_view_model.fetchTask();
        } else if (state is LoadingState) {
          debugPrint("State is Loading");
          return Utils.buildLoading();
        } else if (state is ResponseState) {
          debugPrint("State is Response");
          var responseDataSql = state.taskSql;
          var responseDataFirebase = state.taskFirebase;
          debugPrint("${responseDataFirebase.length}");

          return Column(children: [
            Expanded(
                child: ListView.builder(
                    itemCount: responseDataFirebase.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          color: Colors.blueGrey.shade50,
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("DELETE"),
                                      content: Text(
                                          "Are you sure you wan to delete?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _task_view_model.deleteTask(responseDataSql[index].idSql!).then((value) => Navigator.pop(context));
                                            },
                                            child: Text("DELETE"))
                                      ],
                                    );
                                  });
                            },
                            title: Text(responseDataFirebase?[index].title ?? 'Task Name'),
                            subtitle: Text(responseDataFirebase?[index].description ??
                                'Task Description'),
                            leading: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: colorList[
                                      tag.indexOf(responseDataFirebase![index].tag!)],
                                  radius: 10.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  responseDataFirebase[index].tag!,
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                            trailing: InkWell(
                                onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => UpdateTask(Task(
                                                  locator.get<AuthHelper>().getUserId(),
                                                  responseDataFirebase[index].idFb,
                                                  responseDataSql[index].idSql,
                                                  responseDataFirebase[index].title!,
                                                  responseDataFirebase[index].description,
                                                  responseDataFirebase[index].tag))))
                                    },
                                child: Icon(Icons.edit)),
                          ),
                        ),
                      );
                    })),
          ]);
        }
        return Utils.buildLoading();
      }),
    );
  }
}

