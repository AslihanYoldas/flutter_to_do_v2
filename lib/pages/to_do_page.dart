import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/cubit/task_features/task_cubit.dart';
import 'package:flutter_firebase_todo_v2/widget/new_task.dart';
import '../dependency_injection/locator.dart';
import '../model/route_argument.dart';
import '../model/task_model.dart';
import '../services/auth.dart';
import '../utils/utils.dart';

const List<Color> colorList = <Color>[Colors.green, Colors.blue, Colors.orange];

class TaskPage extends StatefulWidget {
  final List<Task> responseData;
  final TaskCubit task_view_model;
  int selectedIndex;

   TaskPage(
      {Key? key, required this.responseData, required this.task_view_model ,  required this.selectedIndex}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  void _navigateBottomBar(int index){
    setState(() {
      if (widget.selectedIndex!= index){
        debugPrint("CHANGE DATABASE");
        widget.selectedIndex = index;
       index==0 ?widget.task_view_model.fetchTaskSql():widget.task_view_model.fetchTaskfirebase();
      }

    });}
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: ListView.builder(
              itemCount: widget.responseData.length,
              itemBuilder: (context, index) {

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    color: Colors.blueGrey.shade50,
                    child: ListTile(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("DELETE"),
                                content: const Text(
                                    "Are you sure you wan to delete?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        switch(widget.selectedIndex){
                                          case(0):
                                            widget.task_view_model.deleteTaskSql(widget.responseData[index].id).then((value) => Navigator.pop(context));

                                            break;
                                          case(1):
                                            widget.task_view_model.deleteTaskFirebase(widget.responseData[index].id).then((value) => Navigator.pop(context));
                                            break;
                                        }

                                      },
                                      child: Text("DELETE"))
                                ],
                              );
                            });
                      },
                      title: Text(widget.responseData[index].title ?? 'Task Name'),
                      subtitle: Text(widget.responseData[index].description ??
                          'Task Description'),
                      leading: Column(
                        children: [
                          CircleAvatar(

                            backgroundColor: colorList[tag.indexOf(widget.responseData[index].tag?? 'Work')],
                            radius: 10.0,
                          ),

                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            widget.responseData[index].tag!,
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      trailing: InkWell(
                          onTap: () =>
                          {
                            locator.get<Arg>().setTask(Task(locator.get<AuthHelper>().getUserId(), widget.responseData[index].id, widget.responseData[index].title!, widget.responseData[index].tag, widget.responseData[index].description)),
                            locator.get<Arg>().setSelectedIndex(widget.selectedIndex),
                            Utils.navigate(context: context, routeName: '/updateTask', arguments:locator.get<Arg>())
                      },
                          child: Icon(Icons.edit)),
                    ),
                  ),
                );
              })

      ),
      Container(
        alignment: Alignment.bottomRight,
        margin: const EdgeInsets.all(10.0),
        child: FloatingActionButton(

          onPressed: () {
            locator.get<Arg>().setSelectedIndex(widget.selectedIndex);

            Utils.navigate(context: context, routeName: '/newTask', arguments:locator.get<Arg>(),
               );
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.blueGrey,
        ),
      ),
      BottomNavigationBar(

        backgroundColor: Colors.blueGrey[800],
        selectedItemColor:Colors.amber ,
        currentIndex: widget.selectedIndex,
        onTap:_navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dataset_linked),label:'SQL'),
          BottomNavigationBarItem(icon: Icon(Icons.dataset),label:'Firebase')
        ],
      ) ,

    ]);
  }
}






