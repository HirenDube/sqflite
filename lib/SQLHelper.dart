import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';

class SQLHelper {
  static bool created = false;
  static List<Map> dbase = <Map>[];

  static getDataBase() async {
    Database database =
    await openDatabase("${getDatabasesPath()}/myDataBase.db", version: 1,
        onCreate: (db, version) {
          db.execute(
              "create table Students (RollNo INTEGER PRIMARY KEY,Name TEXT NOT NULL, College TEXT NOT NULL);");
          created = true;
        },
        // onOpen: (Database db) {
        //
        //   try{
        //     db.execute(
        //         "create table Students (RollNo INTEGER PRIMARY KEY,Name TEXT NOT NULL, College TEXT NOT NULL);");
        //   }
        //   catch (e){
        //     print(e);
        //   }
        //
        // }
        );

    return database;
  }

  static insertInto(
      {required int rollNo,
        required String name,
        required String college}) async {
    Database database = await getDataBase();
    // Batch btc = database.batch();
    // btc.insert(
    //     "Students", {"RollNo": rollNo, "Name": "$name", "College": "$college"});
    // btc.commit();
    database.transaction((txn) async {
      // txn.insert("Students", {"RollNo": rollNo, "Name": "$name", "College": "$college"});
      txn.rawInsert(
          "INSERT INTO Students (RollNo,Name,College) VALUES ($rollNo,'$name','$college');");
    });
  }

  static getData() async {
    Database database = await getDataBase();
    dbase = await database.rawQuery("SELECT * FROM Students;");
    return dbase;
  }

  static removeFrom(rollNo) async {
    Database database = await getDataBase();
    Batch batch = database.batch();
    batch.delete("Students", where: "RollNo = $rollNo");
    batch.commit();
  }

  static update(
      {required int rollNo,
        required int oldroll,
        required String name,
        required String college}) async {
    var database = await getDataBase();
    Batch btc = database.batch();
    btc.update(
        "Students", {"RollNo": rollNo, "Name": "$name", "College": "$college"},
        where: "RollNo = $oldroll");
    btc.commit();
  }
}