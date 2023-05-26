
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_todo_v2/dependency_injection/locator.dart';
import 'package:flutter_firebase_todo_v2/model/task_abstract.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../model/task_model.dart';
import 'auth.dart';

class SqlHelper implements TaskAbstract {
  //creating database table item
   Future<void> createTables(sql.Database database) async{
    await database.execute(
      """CREATE TABLE toDoList(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      userId TEXT NOT NULL,
      title TEXT,
      tag TEXT,
      description TEXT
      )
      """
    );
  }
  //create database if non existed and create tables

   Future<sql.Database> db() async{
    return sql.openDatabase(
      'toDoList.db',
      version: 1,
      onCreate: (sql.Database database,int version)async{
        await createTables(database);
      }
    );
  }

  @override
   Future<int> create(String title, String ?description,String ? tag) async{
    final db=await locator.get<SqlHelper>().db();
    //You have to insert map format
    final data={'title':title ,'description':description, 'tag':tag,'userId':locator.get<AuthHelper>().getUserId()};
    debugPrint("aaaaaaaaaaaaaaaaaaaaaaaa $data");

    final id= await db.insert('toDoList',data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
    return id;

  }

/*   Future<List<Map<String,dynamic>>> gettask() async{
    //database connection
    final db=await locator.get<SqlHelper>().db();
    //getting all data
    return db.query('task',orderBy: 'id');
  }*/

  //getting one item you can use for update one row
  @override
  Future<List<Task>> read() async{
    //database connection
    final db=await locator.get<SqlHelper>().db();
    //getting data
    final List<Map<String, dynamic>> maps= await db.query('toDoList', where:"userId= ?",whereArgs: [ locator.get<AuthHelper>().getUserId()],limit:10);
    return List.generate(maps.length, (i) {
      return Task.sql(
        maps[i]['userId'],
        "$maps[i]['id']",
        maps[i]['title'],
        maps[i]['tag'],
        maps[i]['description'],
      );
    });
  }



  //Before call this method we call get item to get the item
   Future<bool> update(String i, String title, String? desc,String tag) async {
     try {
       int id = int.parse(i);
       final db = await locator.get<SqlHelper>().db();
       //updated data
       final data = {
         'userId': locator.get<AuthHelper>().getUserId(),
         'id': id,
         'title': title,
         'tag': tag,
         'description': desc,

       };
       final result = await db.update(
           'toDoList', data, where: "id= ?", whereArgs: [id]);
       return true;
     }catch(e){
       debugPrint(e.toString());
       return false;
     }
   }


   Future<bool> delete(String i) async{
     debugPrint(i);
     int id= int.parse(i);
    final db=await locator.get<SqlHelper>().db();
    try{
      await db.delete('toDoList',where: "id= ?",whereArgs: [id]);
      return true;
      
    }catch(e){
      debugPrint("Delete Error $e");
      return false;
    }


  }

}
