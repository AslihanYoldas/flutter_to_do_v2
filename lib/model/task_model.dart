import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String? userId;
  String? id;
  String? title;
  String? tag;
  String? description;

  Task(this.userId,this.id, this.title, this.tag, this.description);

  //from snapshot read the data
  factory Task.fromSnapshot(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic>;
    return Task(
        snapshot['userId'],
        snapshot['id'],
        snapshot['title'],
        snapshot['tag'],
        snapshot['description'],
    );
  }

  //dart object to raw data (json) to store in the firebase
  Map<String,dynamic> toJson()=>{
    'userId':userId,
    'id':id,
    'title':title,
    'tag':tag,
    'description':description

  };
}