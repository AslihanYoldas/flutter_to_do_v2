
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_todo_v2/dependency_injection/locator.dart';
import 'package:flutter_firebase_todo_v2/model/task_abstract.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../model/task_model.dart';
import 'auth.dart';

class SqlHelper  {
  //creating database table item
   Future<void> createTables(sql.Database database) async{
    await database.execute(
      """CREATE TABLE tasks(
      id TEXT NOT NULL,
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
      'tasks.db',
      version: 1,
      onCreate: (sql.Database database,int version)async{
        await createTables(database);
      }
    );
  }

  @override
   Future<List<Task>?>? create(String id,String title, String ?description,String ? tag) async{
     try{
       final db=await locator.get<SqlHelper>().db();
       //You have to insert map format
       final data={'userId':locator.get<AuthHelper>().getUserId(),'id':id, 'title':title , 'tag':tag,'description':description,};
       debugPrint("aaaaaaaaaaaaaaaaaaaaaaaa $data");

       await db.insert('tasks',data,conflictAlgorithm:sql.ConflictAlgorithm.replace);
       final List<Map<String, dynamic>> maps= await db.query('tasks', where:"userId= ?",whereArgs: [ locator.get<AuthHelper>().getUserId()],limit:10);
       return List.generate(maps.length, (i) {
         return Task(
           maps[i]['userId'],
           maps[i]['id'],
           maps[i]['title'],
           maps[i]['tag'],
           maps[i]['description'],
         );
       });
     }catch(e){
       return null;
     }


  }

  Future<List<Map<String,dynamic>>> gettask() async{
    //database connection
    final db=await locator.get<SqlHelper>().db();
    //getting all data
    return db.query('tasks');
  }

  //getting one item you can use for update one row
  @override
  Future<List<Task>> read() async{
    //database connection
    final db=await locator.get<SqlHelper>().db();
    //getting data
    final List<Map<String, dynamic>> maps= await db.query('tasks', where:"userId= ?",whereArgs: [ locator.get<AuthHelper>().getUserId()],limit:10);
    return List.generate(maps.length, (i) {
      return Task(
        maps[i]['userId'],
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['tag'],
        maps[i]['description'],
      );
    });
  }



  //Before call this method we call get item to get the item
   Future<bool> update(String id, String title, String? desc,String tag) async {
     try {
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
           'tasks', data, where: "id= ?", whereArgs: [id]);
       return true;
     }catch(e){
       debugPrint(e.toString());
       return false;
     }
   }


   Future<bool> delete(String id) async{
    final db=await locator.get<SqlHelper>().db();
    try{
      await db.delete('tasks',where: "id= ?",whereArgs: [id]);
      return true;
      
    }catch(e){
      debugPrint("Delete Error $e");
      return false;
    }


  }
  clearUserTable() async {
    final db=await locator.get<SqlHelper>().db();
    return await db.rawDelete("DELETE FROM tasks");
  }

}
