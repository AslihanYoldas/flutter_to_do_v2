import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_todo_v2/pages/home_page.dart';
import 'dependency_injection/locator.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DependencyInjection();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
  ));
}




