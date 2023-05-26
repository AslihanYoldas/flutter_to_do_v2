import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  String? userId;
  String idFb='';
  String idSql='';
  String? title;
  String? tag;
  String? description;

  Task(this.userId,this.idFb, this.idSql, this.title, this.tag, this.description,);

  Task.sql(this.userId, this.idSql, this.title, this.tag, this.description);
  Task.firebase(this.userId, this.idFb, this.title, this.tag, this.description);
  //from snapshot read the data
  factory Task.fromSnapshot(DocumentSnapshot snap){
    var snapshot =snap.data() as Map<String,dynamic>;
    return Task.firebase(
        snapshot['userId'],
        snapshot['idFb'],
        snapshot['title'],
        snapshot['tag'],
        snapshot['description'],
    );
  }

  //dart object to raw data (json) to store in the firebase
  Map<String,dynamic> toJson()=>{
    'userId':userId,
    'idFb':idFb,
    'idSql':idSql,
    'title':title,
    'tag':tag,
    'description':description

  };
}