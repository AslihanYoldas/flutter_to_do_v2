
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/cubit/login_features/login_view.dart';
import 'package:flutter_firebase_todo_v2/pages/login_page.dart';
import 'package:flutter_firebase_todo_v2/widget/update_task.dart';

import '../model/route_argument.dart';
import '../widget/create_user.dart';
import '../widget/new_task.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final  args =settings.arguments  ;

    switch (settings.name) {
      case '/createUser':
        return MaterialPageRoute(builder: (_) => const CreateUser());
      case '/newTask':
        Arg? argument=args as Arg ;
        return MaterialPageRoute(builder: (_) => NewTask( selectedIndex: argument?.selectedIndex?? 0,));
      case '/login':
        return MaterialPageRoute(builder: (_) =>const LoginView());
      case '/updateTask':
        Arg argument=args as Arg ;
        return MaterialPageRoute(builder: (_) =>UpdateTask(argument.task, argument.selectedIndex));
            default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

}
