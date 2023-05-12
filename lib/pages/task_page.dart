import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';
import 'package:flutter_firebase_todo_v2/widget/new_task.dart';

import '../constant.dart';
import '../services/firebase_helper.dart';
import '../model/task_model.dart';
import '../widget/update_task.dart';
const List<Color> colorList=<Color>[Colors.green,Colors.blue,Colors.orange];

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("TO-DO LIST"),
            backgroundColor: Colors.blueGrey,

          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>NewTask()));
            },
            child: Icon(Icons.add,),
            backgroundColor: Colors.blueGrey,
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          body:Column(
            children: [
              StreamBuilder<List<Task>>(
                  stream: read(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState==ConnectionState.waiting){
                      return Center(child:CircularProgressIndicator());
                    }
                    else if(snapshot.hasError){
                      return Center(child:Text("some error occured"));
                    }
                    else if(snapshot.hasData){

                      final taskData=snapshot.data;




                      return Expanded(
                          child: ListView.builder(
                              itemCount: taskData?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Card(
                                    color: Colors.blueGrey.shade50,
                                    child: ListTile(
                                      onLongPress: (){
                                        showDialog(context: context, builder: (context){
                                          return AlertDialog(
                                            title: Text("DELETE"),
                                            content:Text("Are you sure you wan to delete?") ,
                                            actions: [ElevatedButton(onPressed:(){
                                              delete(taskData![index].id!).then((value) => Navigator.pop(context));
                                            }, child: Text("DELETE"))],
                                          );
                                        });
                                      },
                                      title: Text(taskData?[index].title ?? 'Task Name'),
                                      subtitle: Text(taskData?[index].description ?? 'Task Description'),
                                      leading: Column(
                                        children: [
                                          CircleAvatar(

                                            backgroundColor: colorList[tag.indexOf(taskData![index].tag!)],
                                            radius: 10.0,


                                          ),
                                          SizedBox(height: 5.0,),
                                          Text(taskData![index].tag!,
                                            style: TextStyle(
                                              fontSize: 10
                                            ),
                                          )
                                        ],
                                      ),

                                      trailing:InkWell(
                                          onTap:()=>{
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateTask(taskData?[index].id,taskData?[index].title,taskData?[index].description,taskData?[index].tag)))
                                          },
                                          child: Icon(Icons.edit)),
                                    ),
                                  ),



                                      );


                              }));
                    }
                    return  Center(child:CircularProgressIndicator());

                  }
              ),
            ],
          )


    ));
  }
}
