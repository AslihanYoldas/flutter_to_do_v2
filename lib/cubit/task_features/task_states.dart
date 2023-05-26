import '../../model/task_model.dart';

abstract class TaskStates{}

class InitState extends TaskStates {
}
class LoadingState  extends TaskStates{
}
class ErrorState extends TaskStates{
  final String message;
  ErrorState(this.message);
}
//This state responsible for holding the response
class ResponseState extends TaskStates{
  List<Task> taskFirebase;
  List<Task> taskSql;
  ResponseState (this.taskFirebase,this.taskSql);
}



