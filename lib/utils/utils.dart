import 'package:flutter/material.dart';

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

}