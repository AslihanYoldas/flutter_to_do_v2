import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String? id;
  String? title;
  String? tag;
  String? description;

  Task(this.id, this.title, this.tag, this.description);

  //from snapshot read the data
  factory Task.fromSnapshot(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic>;
    return Task(
        snapshot['id'],
        snapshot['title'],
        snapshot['tag'],
        snapshot['description'],
    );
  }

  //dart object to raw data (json) to store in the firebase
  Map<String,dynamic> toJson()=>{
    'id':id,
    'title':title,
    'tag':tag,
    'description':description

  };
}