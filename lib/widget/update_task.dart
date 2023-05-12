import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_v2/constant.dart';
import 'package:flutter_firebase_todo_v2/services/firebase_helper.dart';

const List<String> tagList = <String>['Work', 'Personal', 'Other'];

class UpdateTask extends StatefulWidget {
  String? id;
  String? title;
  String? desc;
  String? tag;


  UpdateTask(this.id,this.title, this.desc, this.tag);

  @override
  State<UpdateTask> createState() => _UpdateTaskState(id,title,desc,tag);

}

class _UpdateTaskState extends State<UpdateTask> {
  String? id;
  String? title;
  String? desc;
  String? tag;
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  String? selectedValue;


  _UpdateTaskState(this.id,this.title, this.desc, this.tag);
  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    taskTitleController.text=title ?? '';
    taskDescController.text=desc ?? '';
    selectedValue = tag;

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
            update(widget.id!,taskTitleController.text, selectedValue!, taskDescController.text);
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
