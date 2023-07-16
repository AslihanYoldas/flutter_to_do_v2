import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cubit/task_features/task_cubit.dart';
import '../dependency_injection/locator.dart';
import '../model/task_model.dart';

const List<String> tagList = <String>['Work', 'Personal', 'Other'];

class UpdateTask extends StatefulWidget {
  Task task;
  final int selectedIndex;


  UpdateTask(this.task, this.selectedIndex);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();

}

class _UpdateTaskState extends State<UpdateTask> {

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  String? selectedValue;
  TaskCubit _task_view_model =locator.get<TaskCubit>();


  _UpdateTaskState();
  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    taskTitleController.text=widget.task.title ?? '';
    taskDescController.text=widget.task.description ?? '';
    selectedValue = widget.task.tag;

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Update Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        width: MediaQuery.of(context).size.width,
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: taskTitleController,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Task',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.square_list, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Description',
                  hintStyle: const TextStyle(fontSize: 14),
                  icon: const Icon(CupertinoIcons.bubble_left_bubble_right, color: Colors.blueGrey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children:  <Widget>[
                  Icon(CupertinoIcons.tag, color: Colors.blueGrey),
                  SizedBox(width: 15.0),
                  DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (String? newValue){
                      setState(() {
                        selectedValue = newValue!;

                      });
                    },
                    items: tagList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )

                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            switch(widget.selectedIndex){
              case(0):
                _task_view_model.updateTaskSql(widget.task.id,taskTitleController.text, selectedValue!, taskDescController.text);
                break;
              case(1):
                _task_view_model.updateTaskFirebase(widget.task.id,taskTitleController.text, selectedValue!, taskDescController.text);
                break;
            }


            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Task Updated'),
            ));
            Navigator.pop(context);

          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
