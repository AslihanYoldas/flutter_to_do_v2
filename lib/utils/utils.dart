import 'package:flutter/material.dart';
import 'dart:math';

import '../model/route_argument.dart';
import '../model/task_model.dart';

class Utils{
  Utils._();

  static navigate({required BuildContext context, required String routeName, required  Arg? arguments}){

    Navigator.pushNamed(
      context,
      routeName,
      arguments:Arg(
        arguments?.task,
        arguments?.selectedIndex
      ),
    );
  }

  static Center buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
      ),
    );
  }

  static String generateId() {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(7, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}