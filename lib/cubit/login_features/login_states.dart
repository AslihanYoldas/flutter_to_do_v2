import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginStates{}
class InitState extends LoginStates{

}



class SuccessState extends LoginStates{
  User? user;
  SuccessState(this.user);
}

class FailState extends LoginStates{
  String message;

  FailState(this.message);
}




