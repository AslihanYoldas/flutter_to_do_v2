import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/services/firebase_helper.dart';
import 'package:flutter_firebase_todo_v2/widget/to_do_firebase.dart';
import 'package:flutter_firebase_todo_v2/widget/to_do_sql.dart';

import '../cubit/task_features/task_cubit.dart';
import '../utils/utils.dart';

class TaskPage extends StatefulWidget {
  final CustomFireabseHelper _firebaseHelper;
  const TaskPage({Key? key, required CustomFireabseHelper firebaseHelper}) : _firebaseHelper = firebaseHelper, super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}



class _TaskPageState extends State<TaskPage> {
  int _selectedIndex=0;

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  late final List<Widget> _pages=[

    TaskSql(viewModel: TaskCubit()),
    TaskFirebase(viewModel: TaskCubit()),


  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

              Utils.navigate(context: context, routeName: '/login', arguments: null);

            },
          )
        ],
        title: const Text("TO DO LIST"),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () {
          Utils.navigate(context: context, routeName: '/newTask', arguments: null);
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      bottomNavigationBar:BottomNavigationBar(

        backgroundColor: Colors.blueGrey[800],
        selectedItemColor:Colors.amber ,
        currentIndex: _selectedIndex,
        onTap:_navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dataset_linked),label:'SQL'),
          BottomNavigationBarItem(icon: Icon(Icons.dataset),label:'Firebase')
        ],
      ) ,
      body:_pages[_selectedIndex],

    );
  }
}
