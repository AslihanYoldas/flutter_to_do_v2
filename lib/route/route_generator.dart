import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/dependency_injection/locator.dart';
import 'package:flutter_firebase_todo_v2/model/task_model.dart';
import 'package:flutter_firebase_todo_v2/pages/login_page.dart';
import 'package:flutter_firebase_todo_v2/pages/task_page.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';
import 'package:flutter_firebase_todo_v2/services/firebase_helper.dart';
import 'package:flutter_firebase_todo_v2/widget/create_user.dart';

import '../cubit/login_features/login_cubit_.dart';
import '../widget/new_task.dart';
import '../widget/update_task.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/task':
         return MaterialPageRoute(builder: (_) => TaskPage(firebaseHelper: locator.get<CustomFireabseHelper>(),));
      case '/createUser':
        return MaterialPageRoute(builder: (_) => CreateUser());
      case '/newTask':
        return MaterialPageRoute(builder: (_) => NewTask());
      case '/login':
        return MaterialPageRoute(builder: (_) =>LoginPage( LoginCubit()));
     case '/update':
        var data = settings.arguments as Task;
        return MaterialPageRoute(builder: (_) =>UpdateTask(data));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }

}