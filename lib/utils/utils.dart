import 'package:flutter/material.dart';
import 'dart:math';

class Utils{
  Utils._();

  static navigate({required BuildContext context, required String routeName, required arguments}){
    Navigator.of(context).pushNamed(routeName);
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