import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_todo_v2/route/route_generator.dart';
import 'package:flutter_firebase_todo_v2/services/auth.dart';
import 'cubit/task_features/task_view.dart';
import 'dependency_injection/locator.dart';
import 'firebase_options.dart';
import 'cubit/login_features/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection();

  debugPrint(locator.get<AuthHelper>().getUserId());



  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      home:locator.get<AuthHelper>().isUserSigned() ?const TaskView():const LoginView()

  ));
}




