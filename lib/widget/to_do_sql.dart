import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_cubit.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_states.dart';
import '../dependency_injection/locator.dart';
import '../model/task_model.dart';
import '../services/auth.dart';
import '../utils/utils.dart';
import 'update_task.dart';

class TaskSql extends StatelessWidget {
  final TaskCubit _task_view_model;

  const TaskSql({Key? key,  required TaskCubit viewModel}) : _task_view_model = viewModel, super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
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
            debugPrint("State is Response SQL");
            var responseDataSql = state.taskSql;
            var responseDataFirebase = state.taskFirebase;
            return Container(
                child: Column(
                  children: [
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: responseDataSql.length,
                      itemBuilder: (context, index) =>
                          Card(
                            color: Colors.orange[200],
                            margin: const EdgeInsets.all(15),
                            child: ListTile(
                                title: Text(responseDataSql[index].title!),
                                subtitle: Text(
                                    responseDataSql[index].description!),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Utils.navigate(context: context, routeName: '/update',arguments:Task(
                                                locator.get<AuthHelper>().getUserId(),
                                                responseDataFirebase[index].idFb,
                                                responseDataSql[index]
                                                    .idSql,
                                                responseDataSql[index]
                                                    .title,
                                                responseDataSql[index]
                                                    .description,
                                                responseDataSql[index]
                                                    .tag));
                                            
                                          }


                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => _task_view_model.deleteTask(responseDataSql[index].idSql),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                    ),
                  ],

                )


            );
          }
          return Utils.buildLoading();
        })
    );
  }
}
