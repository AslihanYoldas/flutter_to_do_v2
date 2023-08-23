import 'package:flutter/material.dart';

import '../cubit/login_features/login_cubit_.dart';
import '../dependency_injection/locator.dart';

class ErrorMessage extends StatelessWidget {
  final String   message;
  const ErrorMessage({Key? key, required  this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        scrollable: true,
        title: Text(
        'ERROR',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
    ),
    content: Text(message),
    actions: [
    ElevatedButton(
    onPressed: () {
      locator.get<LoginCubit>().Init();
    },
    style: ElevatedButton.styleFrom(
    primary: Colors.grey,
    ),
    child: Text('OK'),
    ),
    ]);}
}
